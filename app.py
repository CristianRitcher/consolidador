from flask import Flask, request, jsonify, render_template, send_from_directory
import subprocess
import json
import os
import logging
from pathlib import Path
from datetime import datetime

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False  # Support for UTF-8 characters

# Configuration
BASE_DIR = Path(__file__).parent
ASSETS_DIR = BASE_DIR / 'assets'
STATIC_DIR = BASE_DIR / 'static'
TEMPLATES_DIR = BASE_DIR / 'templates'

@app.route('/')
def index():
    """Serve the main page"""
    return render_template('index.html')

@app.route('/retry')
def retry():
    """Serve the retry page"""
    return render_template('retry.html')

@app.route('/scheduled')
def scheduled():
    """Serve the scheduled page"""
    return render_template('scheduled.html')

@app.route('/assets/<path:filename>')
def serve_assets(filename):
    """Serve static assets (CSS, JS, JSON)"""
    return send_from_directory('assets', filename)

@app.route('/static/<path:filename>')
def serve_static(filename):
    """Serve static files"""
    return send_from_directory('static', filename)

@app.route('/api/sync_db', methods=['POST'])
def sync_database():
    """
    Main API endpoint for database synchronization
    Replaces the PHP api.php functionality
    """
    try:
        # Get JSON data from request
        data = request.get_json()
        
        if not data:
            return jsonify({
                "status": "error",
                "message": "No JSON data received"
            }), 400

        logger.info("Received sync request: %s", data)

        # Validate required fields
        if 'modo' not in data:
            return jsonify({
                "status": "error",
                "message": 'El campo "modo" es requerido. Use "apertura" o "cierre"'
            }), 400

        # Extract and validate data
        modo = data['modo']
        if modo not in ['apertura', 'cierre']:
            return jsonify({
                "status": "error",
                "message": 'El modo debe ser "apertura" o "cierre"'
            }), 400

        # Extract database configurations
        db_origen = data.get('db_origen', {})
        db_destino = data.get('db_destino', {})
        db_password_origen = data.get('db_password_origen', '')
        db_password_destino = data.get('db_password_destino', '')

        # Validate database configurations
        required_fields = ['host', 'user', 'database']
        for field in required_fields:
            if field not in db_origen:
                return jsonify({
                    "status": "error",
                    "message": f'Campo requerido en db_origen: {field}'
                }), 400
            if field not in db_destino:
                return jsonify({
                    "status": "error",
                    "message": f'Campo requerido en db_destino: {field}'
                }), 400

        # Extract configuration values
        db_origen_alias = db_origen.get('alias', 'origen')
        db_origen_host = db_origen['host']
        db_origen_user = db_origen['user']
        db_origen_database = db_origen['database']

        db_destino_host = db_destino['host']
        db_destino_user = db_destino['user']
        db_destino_database = db_destino['database']

        # Build command for sync.py
        cmd = [
            'python3', 'sync.py',
            f'{db_destino_host}:{db_destino_user}:{db_password_destino}:{db_destino_database}',
            '--sources', f'{db_origen_alias}={db_origen_host}:{db_origen_user}:{db_password_origen}:{db_origen_database}',
            '--modo', modo
        ]

        logger.info("Executing command: %s", ' '.join(cmd))

        # Execute sync.py
        result = subprocess.run(
            cmd,
            cwd=BASE_DIR / 'scripts',
            capture_output=True,
            text=True,
            timeout=300  # 5 minutes timeout
        )

        logger.info("Command return code: %s", result.returncode)
        logger.info("Command output: %s", result.stdout)
        if result.stderr:
            logger.error("Command stderr: %s", result.stderr)

        if result.returncode != 0:
            error_message = result.stderr or result.stdout or "Unknown error"
            return jsonify({
                "status": "error",
                "message": f"Error durante la ejecución: {error_message}"
            }), 500

        # Try to parse output as JSON (sync.py should return JSON)
        try:
            output_json = json.loads(result.stdout)
            return jsonify(output_json)
        except json.JSONDecodeError:
            # If not JSON, return as plain text
            return jsonify({
                "status": "success",
                "message": result.stdout.strip() or "Operación completada exitosamente"
            })

    except subprocess.TimeoutExpired:
        return jsonify({
            "status": "error",
            "message": "La operación excedió el tiempo límite (5 minutos)"
        }), 408

    except Exception as e:
        logger.error("Unexpected error: %s", str(e))
        return jsonify({
            "status": "error",
            "message": f"Error interno del servidor: {str(e)}"
        }), 500

@app.route('/api/schedule_sync', methods=['POST'])
def schedule_sync():
    """Schedule a new sync task"""
    try:
        data = request.get_json()
        
        if not data:
            return jsonify({
                "status": "error",
                "message": "No JSON data received"
            }), 400

        # Validate required fields
        required_fields = ['db_origen', 'db_destino', 'modo', 'concurrency', 'date_time']
        for field in required_fields:
            if field not in data:
                return jsonify({
                    "status": "error",
                    "message": f'Campo requerido: {field}'
                }), 400

        scheduled_file = BASE_DIR / 'json' / 'scheduled.json'
        
        # Load existing scheduled tasks
        if scheduled_file.exists():
            with open(scheduled_file, 'r', encoding='utf-8') as f:
                schedule = json.load(f)
        else:
            schedule = {"configs": []}
        
        # Add new task
        schedule['configs'].append(data)
        
        # Save updated schedule
        with open(scheduled_file, 'w', encoding='utf-8') as f:
            json.dump(schedule, f, indent=2)
        
        logger.info("Scheduled new task: %s from %s to %s", data['modo'], data['db_origen']['alias'], data['db_destino']['alias'])
        
        return jsonify({
            "status": "success",
            "message": "Tarea programada exitosamente"
        })
        
    except Exception as e:
        logger.error("Error scheduling sync: %s", str(e))
        return jsonify({
            "status": "error",
            "message": f"Error programando tarea: {str(e)}"
        }), 500

@app.route('/api/scheduled_tasks', methods=['GET'])
def get_scheduled_tasks():
    """Get all scheduled tasks"""
    try:
        scheduled_file = BASE_DIR / 'json' / 'scheduled.json'
        
        if not scheduled_file.exists():
            return jsonify({
                "status": "success",
                "tasks": []
            })
        
        with open(scheduled_file, 'r', encoding='utf-8') as f:
            schedule = json.load(f)
        
        return jsonify({
            "status": "success",
            "tasks": schedule.get('configs', [])
        })
        
    except Exception as e:
        logger.error("Error getting scheduled tasks: %s", str(e))
        return jsonify({
            "status": "error",
            "message": f"Error obteniendo tareas programadas: {str(e)}"
        }), 500

@app.route('/api/scheduled_tasks/<int:task_index>', methods=['DELETE'])
def delete_scheduled_task(task_index):
    """Delete a scheduled task by index"""
    try:
        scheduled_file = BASE_DIR / 'json' / 'scheduled.json'
        
        if not scheduled_file.exists():
            return jsonify({
                "status": "error",
                "message": "No hay tareas programadas"
            }), 404
        
        with open(scheduled_file, 'r', encoding='utf-8') as f:
            schedule = json.load(f)
        
        configs = schedule.get('configs', [])
        
        if task_index >= len(configs):
            return jsonify({
                "status": "error",
                "message": "Índice de tarea inválido"
            }), 404
        
        # Remove the task
        deleted_task = configs.pop(task_index)
        
        # Save updated schedule
        with open(scheduled_file, 'w', encoding='utf-8') as f:
            json.dump(schedule, f, indent=2)
        
        logger.info("Deleted scheduled task: %s from %s", deleted_task['modo'], deleted_task['db_origen']['alias'])
        
        return jsonify({
            "status": "success",
            "message": "Tarea eliminada exitosamente"
        })
        
    except Exception as e:
        logger.error("Error deleting scheduled task: %s", str(e))
        return jsonify({
            "status": "error",
            "message": f"Error eliminando tarea: {str(e)}"
        }), 500

@app.route('/api/failed_inserts', methods=['GET'])
def get_failed_inserts():
    """Get failed inserts from log file"""
    try:
        failed_inserts_file = BASE_DIR / 'log' / 'consolidation_failures.json'
        
        if not failed_inserts_file.exists():
            return jsonify({
                "status": "success",
                "failed_inserts": []
            })
        
        with open(failed_inserts_file, 'r', encoding='utf-8') as f:
            failed_inserts = json.load(f)
        
        return jsonify({
            "status": "success",
            "failed_inserts": failed_inserts
        })
        
    except Exception as e:
        logger.error("Error getting failed inserts: %s", str(e))
        return jsonify({
            "status": "error",
            "message": f"Error obteniendo inserts fallidos: {str(e)}"
        }), 500

@app.route('/api/retry_inserts', methods=['POST'])
def retry_inserts():
    """Retry failed inserts"""
    try:
        # Execute the retry script
        cmd = ['python3', 'scripts/retry.py']
        
        result = subprocess.run(
            cmd,
            cwd=BASE_DIR/'scripts',
            capture_output=True,
            text=True,
            timeout=300  # 5 minutes timeout
        )
        
        if result.returncode != 0:
            return jsonify({
                "status": "error",
                "message": f"Error durante el retry: {result.stderr or result.stdout}"
            }), 500
        
        # Try to parse the result to get statistics
        try:
            # The retry script should return JSON with statistics
            output_json = json.loads(result.stdout)
            return jsonify(output_json)
        except json.JSONDecodeError:
            # If not JSON, return success with the output
            return jsonify({
                "status": "success",
                "message": "Retry completado",
                "output": result.stdout.strip()
            })
        
    except subprocess.TimeoutExpired:
        return jsonify({
            "status": "error",
            "message": "El retry excedió el tiempo límite (5 minutos)"
        }), 408
        
    except Exception as e:
        logger.error("Error during retry: %s", str(e))
        return jsonify({
            "status": "error",
            "message": f"Error interno durante el retry: {str(e)}"
        }), 500
    

@app.route('/api/databases', methods=['GET'])
def get_databases():
    """Get available databases configuration from databases.json"""
    try:
        databases_file = BASE_DIR / 'json' / 'databases.json'
        if not databases_file.exists():
            return jsonify({
                "status": "error",
                "message": "Archivo databases.json no encontrado"
            }), 404

        with open(databases_file, 'r', encoding='utf-8') as f:
            data = json.load(f)

        return jsonify(data)

    except Exception as e:
        logger.error("Error loading databases.json: %s", str(e))
        return jsonify({
            "status": "error",
            "message": f"Error cargando configuración: {str(e)}"
        }), 500

@app.route('/api/status', methods=['GET'])
def get_status():
    """Get system status and recent logs"""
    try:
        status = {
            "status": "online",
            "timestamp": datetime.now().isoformat(),
            "version": "2.0.0-flask"
        }

        # Get optional origen database alias from query parameter
        origen_alias = request.args.get('origen_alias')

        # Get consolidation status from databases.json
        try:
            databases_file = BASE_DIR / 'json' / 'databases.json'
            if databases_file.exists():
                with open(databases_file, 'r', encoding='utf-8') as f:
                    db_data = json.load(f)
                
                # Find the specific origen database or use the first one
                target_origen = None
                if db_data.get('db_origenes'):
                    if origen_alias:
                        # Look for the specific database by alias
                        for origen in db_data['db_origenes']:
                            if origen.get('alias') == origen_alias:
                                target_origen = origen
                                break
                    
                    # If no specific database found or no alias provided, use the first one
                    if not target_origen:
                        target_origen = db_data['db_origenes'][0]
                    
                    if 'consolidation_status' in target_origen:
                        status['consolidation_status'] = target_origen['consolidation_status']['status']
                        status['last_action'] = target_origen['consolidation_status']['status']
                        status['last_action_time'] = target_origen['consolidation_status']['timestamp']
                        status['current_database'] = target_origen.get('alias', 'Unknown')
        except Exception as e:
            logger.warning("Could not read consolidation status: %s", e)

        # Check if log files exist and get recent entries
        log_file = BASE_DIR / 'log' / 'db_consolidation.log'
        if log_file.exists():
            try:
                with open(log_file, 'r', encoding='utf-8') as f:
                    lines = f.readlines()
                    status['recent_logs'] = lines[-10:]  # Last 10 lines
            except Exception:
                status['recent_logs'] = []

        # Check if snapshot exists
        snapshot_file = BASE_DIR / 'log' / 'consolidation_snapshot.json'
        if snapshot_file.exists():
            stat = snapshot_file.stat()
            status['last_snapshot'] = stat.st_mtime

        return jsonify(status)

    except Exception as e:
        logger.error("Error getting status: %s", str(e))
        return jsonify({
            "status": "error",
            "message": f"Error obteniendo estado: {str(e)}"
        }), 500

@app.errorhandler(404)
def not_found(error):
    """Handle 404 errors"""
    return jsonify({
        "status": "error",
        "message": "Endpoint no encontrado"
    }), 404

@app.errorhandler(500)
def internal_error(error):
    """Handle 500 errors"""
    logger.error("Internal server error: %s", error)
    return jsonify({
        "status": "error",
        "message": "Error interno del servidor"
    }), 500

if __name__ == '__main__':
    # Create directories if they don't exist
    os.makedirs(TEMPLATES_DIR, exist_ok=True)
    os.makedirs(STATIC_DIR, exist_ok=True)
    
    # Run Flask development server
    app.run(
        host='0.0.0.0',
        port=5001,
        debug=True
    )
