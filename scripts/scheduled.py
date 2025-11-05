import subprocess
import json
from datetime import datetime, timedelta, timezone
import time
from pathlib import Path
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def parse_datetime(date_string):
    """Parse datetime string handling both ISO format with and without Z"""
    try:
        # Remove Z if present - treat it as UTC
        if date_string.endswith('Z'):
            date_string = date_string[:-1]
            # Parse as UTC by using fromisoformat and then convert to naive
            try:
                # Try to parse with timezone info first
                dt = datetime.fromisoformat(date_string.replace('Z', ''))
                # If no timezone info, assume UTC
                if dt.tzinfo is None:
                    dt = dt.replace(tzinfo=timezone.utc)
                # Convert to naive datetime (local time)
                return dt.astimezone().replace(tzinfo=None)
            except ValueError:
                # Fallback: try simple parsing
                return datetime.fromisoformat(date_string)
        else:
            # No Z, parse normally
            return datetime.fromisoformat(date_string)
    except (ValueError, AttributeError) as e:
        logger.error(f"Error parsing datetime '{date_string}': {e}")
        # Last resort: try to parse with common formats
        for fmt in ['%Y-%m-%dT%H:%M:%S.%f', '%Y-%m-%dT%H:%M:%S', '%Y-%m-%d %H:%M:%S']:
            try:
                return datetime.strptime(date_string.replace('Z', ''), fmt)
            except ValueError:
                continue
        # If all else fails, raise
        raise ValueError(f"Unable to parse datetime: {date_string}")

def update_consolidation_status(db_origen_alias, modo):
    """Update consolidation status in databases.json after successful execution"""
    try:
        databases_file = Path(__file__).parent.parent / 'json' / 'databases.json'
        if not databases_file.exists():
            logger.warning("databases.json no existe; no se pudo actualizar consolidation_status")
            return
        
        with open(databases_file, 'r', encoding='utf-8') as f:
            databases_data = json.load(f)

        db_list = databases_data.get('db_origenes', [])
        for origen in db_list:
            if origen.get('alias') == db_origen_alias:
                if 'consolidation_status' not in origen:
                    origen['consolidation_status'] = {}
                origen['consolidation_status']['status'] = 'aperturado' if modo == 'apertura' else 'cerrado'
                origen['consolidation_status']['timestamp'] = datetime.now().isoformat()
                break

        with open(databases_file, 'w', encoding='utf-8') as f:
            json.dump(databases_data, f, indent=2)
        
        logger.info(f"Updated consolidation_status for {db_origen_alias} to {modo}")
    except Exception as e:
        logger.warning(f"No se pudo actualizar consolidation_status en databases.json: {e}")

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
                    # Parse datetime handling both formats
                    database_time = parse_datetime(config['date_time'])

                    if current_time >= database_time:
                        db_origen_alias = config['db_origen'].get('alias', 'unknown')
                        modo = config['modo']
                        logger.info("Executing scheduled task: %s from %s", modo, db_origen_alias)
                        
                        # Execute the sync
                        success = execute_sync(config)
                        
                        if success:
                            # Update consolidation status in databases.json
                            update_consolidation_status(db_origen_alias, modo)
                            
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
                        else:
                            logger.warning("Scheduled task failed, will retry on next check")
                        
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

        # Get password from config (empty string if not provided)
        db_password_origen = db_origen.get('password', '')
        db_password_destino = db_destino.get('password', '')

        # Build command for sync.py - same format as app.py
        cmd = [
            'python3', 'sync.py',
            f'{db_destino["host"]}:{db_destino["user"]}:{db_password_destino}:{db_destino["database"]}',
            '--sources', f'{db_origen["alias"]}={db_origen["host"]}:{db_origen["user"]}:{db_password_origen}:{db_origen["database"]}',
            '--modo', modo
        ]
        
        logger.info("Executing command: %s", ' '.join(cmd))
        
        # Execute from scripts directory (same as app.py)
        base_dir = Path(__file__).parent.parent
        scripts_dir = base_dir / 'scripts'
        
        result = subprocess.run(
            cmd,
            cwd=scripts_dir,
            capture_output=True,
            text=True,
            timeout=300  # 5 minutes timeout
        )
        
        logger.info("Command return code: %s", result.returncode)
        if result.stdout:
            logger.info("Command stdout: %s", result.stdout[:500])  # First 500 chars
        if result.stderr:
            logger.error("Command stderr: %s", result.stderr)
        
        if result.returncode == 0:
            logger.info("Scheduled sync completed successfully")
            return True
        else:
            error_message = result.stderr or result.stdout or "Unknown error"
            logger.error("Scheduled sync failed (return code %s): %s", result.returncode, error_message)
            return False
            
    except subprocess.TimeoutExpired:
        logger.error("Scheduled sync timed out")
        return False
    except Exception as e:
        logger.error("Error executing scheduled sync: %s", e, exc_info=True)
        return False

def main():
    logger.info("Starting scheduled tasks service...")
    scheduled()

if __name__ == '__main__':
    main()

