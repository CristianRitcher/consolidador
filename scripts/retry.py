import json
import mysql.connector
from mysql.connector import Error
from datetime import datetime
from pathlib import Path
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class Retry:
    def __init__(self, log_file: str='log/consolidation_failures.json'):
        self.log_file = log_file
        self.failed_inserts_log = []
        self.logger = logger

    def load_failed_inserts(self):
        """Carga inserts fallidos del archivo de log"""
        if Path(self.log_file).exists():
            try:
                with open(self.log_file, 'r', encoding='utf-8') as f:
                    self.failed_inserts_log = json.load(f)
                self.logger.info(f"Cargados {len(self.failed_inserts_log)} inserts fallidos")
            except Exception as e:
                self.logger.error(f"Error cargando log de fallos: {e}")
                self.failed_inserts_log = []
        else:
            self.failed_inserts_log = []
            
    def retry_inserts(self):
        """Procesa inserts fallidos del log"""
        if not self.failed_inserts_log:
            self.logger.info("No hay inserts fallidos para reintentar")
            return {"successful_retries": 0, "failed_retries": 0}
        
        successful_retries = []
        failed_retries = []
        
        # Group by target database to optimize connections
        target_dbs = {}
        for failed_insert in self.failed_inserts_log:
            source_config = failed_insert['source_config']
            target_db = source_config.get('target_database', 'restaurante_unificado1')  # Default target
            
            if target_db not in target_dbs:
                target_dbs[target_db] = []
            target_dbs[target_db].append(failed_insert)
        
        for target_db, inserts in target_dbs.items():
            # Get target database config from databases.json
            target_config = self.get_target_config(target_db)
            if not target_config:
                self.logger.error(f"No se encontró configuración para base de datos destino: {target_db}")
                failed_retries.extend(inserts)
                continue
            
            try:
                # Connect to target database
                conn = mysql.connector.connect(
                    host=target_config['host'],
                    user=target_config['user'],
                    password=target_config['password'],
                    database=target_config['database'],
                    port=target_config.get('port', 3306),
                    charset='utf8mb4',
                    autocommit=False
                )
                
                for failed_insert in inserts:
                    table_name = failed_insert['table']
                    record = failed_insert['record']
                    source_config = failed_insert['source_config']
                    
                    try:
                        insert_data = record.copy()
                        insert_data['_source_database'] = source_config['database']
                        insert_data['_source_alias'] = source_config['alias']
                        insert_data['_sync_timestamp'] = datetime.now()
                        
                        columns = list(insert_data.keys())
                        placeholders = ','.join(['%s' for _ in columns])
                        values = [insert_data[col] for col in columns]
                        
                        query = f"INSERT INTO `{table_name}` (`{'`, `'.join(columns)}`) VALUES ({placeholders})"
                        
                        cursor = conn.cursor()
                        cursor.execute(query, values)
                        conn.commit()
                        cursor.close()
                        
                        successful_retries.append(failed_insert)
                        self.logger.info(f"Retry exitoso para {table_name} desde {source_config['alias']}")
                        
                    except Exception as e:
                        self.logger.warning(f"Retry fallido para {table_name}: {e}")
                        conn.rollback()
                        failed_retries.append(failed_insert)
                
                conn.close()
                
            except Exception as e:
                self.logger.error(f"Error conectando a base de datos destino {target_db}: {e}")
                failed_retries.extend(inserts)
        
        # Update failed inserts log with remaining failures
        self.failed_inserts_log = failed_retries
        self.save_failed_inserts()
        
        result = {
            "successful_retries": len(successful_retries),
            "failed_retries": len(failed_retries)
        }
        
        self.logger.info(f"Retry completado: {result['successful_retries']} exitosos, {result['failed_retries']} fallidos")
        return result
    
    def get_target_config(self, target_db):
        """Get target database configuration from databases.json"""
        try:
            databases_file = Path(__file__).parent.parent / 'json' / 'databases.json'
            with open(databases_file, 'r', encoding='utf-8') as f:
                data = json.load(f)
            
            for destino in data.get('db_destinos', []):
                if destino['database'] == target_db:
                    return destino
            
            return None
        except Exception as e:
            self.logger.error(f"Error leyendo configuración de bases de datos: {e}")
            return None
    
    def save_failed_inserts(self):
        """Guarda inserts fallidos al archivo de log"""
        try:
            with open(self.log_file, 'w', encoding='utf-8') as f:
                json.dump(self.failed_inserts_log, f, indent=2, default=str)
            self.logger.info(f"Guardados {len(self.failed_inserts_log)} inserts fallidos")
        except Exception as e:
            self.logger.error(f"Error guardando log de fallos: {e}")

def main():
    retry = Retry()
    retry.load_failed_inserts()
    result = retry.retry_inserts()
    
    # Print result as JSON for API consumption
    print(json.dumps(result))

if __name__ == '__main__':
    main()