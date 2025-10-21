import subprocess
import json
from datetime import datetime, timedelta
import time
from pathlib import Path
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def scheduled():
    """Main scheduled tasks loop"""
    while True:
        try:
            current_time = datetime.now()
            
            # Load scheduled tasks
            scheduled_file = Path(__file__).parent.parent / 'json' / 'scheduled.json'
            if not scheduled_file.exists():
                logger.info("No scheduled tasks file found, waiting...")
                time.sleep(60)
                continue
                
            with open(scheduled_file, 'r', encoding='utf-8') as f:
                schedule = json.load(f)

            configs = schedule.get('configs', [])
            updated_configs = []
            
            for config in configs:
                try:
                    database_time = datetime.fromisoformat(config['date_time'])

                    if current_time >= database_time:
                        logger.info( "Executing scheduled task: %s from %s", config["modo"], config["db_origen"]["alias"])
                        
                        # Execute the sync
                        success = execute_sync(config)
                        
                        if success:
                            # Handle recurrence
                            if config['concurrency'] == 0:
                                # Single execution - remove from schedule
                                logger.info("Single execution task completed and removed")
                                continue
                            elif config['concurrency'] >= 1:
                                # Recurring task - update next execution time
                                new_date_time = database_time + timedelta(days=config['concurrency'])
                                config['date_time'] = new_date_time.isoformat()
                                logger.info("Recurring task scheduled for next execution: %s", new_date_time)
                        
                        updated_configs.append(config)
                    else:
                        # Task not due yet
                        updated_configs.append(config)
                        
                except Exception as e:
                    logger.error("Error processing scheduled task: %s", e)
                    updated_configs.append(config)  # Keep the task for retry
            
            # Update the schedule file
            schedule['configs'] = updated_configs
            with open(scheduled_file, 'w', encoding='utf-8') as f:
                json.dump(schedule, f, indent=2)
                
        except Exception as e:
            logger.error("Error in scheduled tasks loop: %s", e)
            
        time.sleep(60)

def execute_sync(config):
    """Execute a sync task"""
    try:
        db_origen = config['db_origen']
        db_destino = config['db_destino']
        modo = config['modo']

        # Build command for sync.py
        cmd = [
            'python3', 'scripts/sync.py',
            f'{db_destino["host"]}:{db_destino["user"]}:{db_destino["password"]}:{db_destino["database"]}',
            '--sources', f'{db_origen["alias"]}={db_origen["host"]}:{db_origen["user"]}:{db_origen["password"]}:{db_origen["database"]}',
            '--modo', modo
        ]
        
        logger.info("Executing command: %s", ' '.join(cmd))
        
        result = subprocess.run(
            cmd,
            cwd=Path(__file__).parent.parent,
            capture_output=True,
            text=True,
            timeout=300  # 5 minutes timeout
        )
        
        if result.returncode == 0:
            logger.info("Scheduled sync completed successfully")
            return True
        else:
            logger.error("Scheduled sync failed: %s", result.stderr)
            return False
            
    except subprocess.TimeoutExpired:
        logger.error("Scheduled sync timed out")
        return False
    except Exception as e:
        logger.error("Error executing scheduled sync: %s", e)
        return False

def main():
    logger.info("Starting scheduled tasks service...")
    scheduled()

if __name__ == '__main__':
    main()

