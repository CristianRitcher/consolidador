#!/usr/bin/env python3
import os
import sys
from pathlib import Path

# Add current directory to Python path
sys.path.insert(0, str(Path(__file__).parent))

from app import app
from config import config

def main():
    # Get configuration from environment or use default
    config_name = os.environ.get('FLASK_ENV', 'development')
    app.config.from_object(config.get(config_name, config['default']))

    # Run the application
    host = os.environ.get('FLASK_HOST', '0.0.0.0')
    port = int(os.environ.get('FLASK_PORT', 5001))  # Changed default port to avoid AirPlay conflict
    debug = app.config.get('DEBUG', True)
    
    print(f"Starting {app.config.get('APP_NAME', 'Flask App')}")
    print(f"URL: http://{host}:{port}")
    print(f"Environment: {config_name}")
    print(f"Debug mode: {debug}")
    print("-" * 50)

    
    
    app.run(
        host=host,
        port=port,
        debug=debug
    )

if __name__ == '__main__':
    main()
