# Volcado Web - Sistema de Consolidación de Bases de Datos MySQL

## Descripción

Sistema web para consolidar múltiples bases de datos MySQL en una base centralizada para generar reportes. El sistema permite realizar operaciones de apertura (snapshot) y cierre (consolidación) de manera manual o programada.

## Características

### Página Principal (index.html)
- **Selector de bases de datos**: Permite seleccionar base de datos de origen y destino
- **Botones de operación**: Apertura (snapshot) y Cierre (consolidación) con confirmación
- **Estado del sistema**: Muestra el estado actual y la hora de la última acción
- **Log de actividad**: Registra todas las operaciones realizadas

### Página de Retry (retry.html)
- **Inserts fallidos**: Lista todos los inserts que fallaron durante la consolidación
- **Botón de retry**: Ejecuta manualmente la función de reintentar inserts fallidos
- **Log de actividad**: Muestra el resultado de las operaciones de retry
- **Actualización automática**: La lista se actualiza después de cada retry

### Página de Programación (scheduled.html)
- **Configuración de tareas**: Permite programar tareas de apertura o cierre
- **Recurrencia**: Opciones de ejecución única o recurrente
- **Concurrencia**: Configuración de días entre ejecuciones para tareas recurrentes
- **Gestión de tareas**: Lista y eliminación de tareas programadas

## Instalación y Configuración

### Requisitos
- Python 3.7+
- MySQL Server
- Flask
- mysql-connector-python

### Instalación de dependencias
```bash
pip install flask mysql-connector-python
```

### Configuración de bases de datos
Editar el archivo `json/databases.json` con la configuración de las bases de datos:

```json
{
    "db_destinos": [
        {
            "alias": "destino_restaurante1",
            "host": "localhost",
            "user": "root",
            "password": "",
            "database": "restaurante_unificado1"
        }
    ],
    "db_origenes": [
        {
            "alias": "origen_restaurante",
            "host": "localhost",
            "user": "root",
            "password": "",
            "database": "restaurante",
            "consolidation_status": {
                "status": "cerrado",
                "timestamp": "2025-01-10T20:00:00.000000"
            }
        }
    ]
}
```

## Uso

### Iniciar la aplicación
```bash
python3 app.py
```

La aplicación estará disponible en `http://localhost:5000`

### Servicio de tareas programadas
Para ejecutar tareas programadas automáticamente:

```bash
python3 scripts/scheduled.py
```

### Operaciones manuales

#### Apertura (Snapshot)
1. Seleccionar base de datos de origen y destino
2. Ingresar contraseñas si es necesario
3. Hacer clic en "Apertura (Snapshot)"
4. Confirmar la operación en el modal

#### Cierre (Consolidación)
1. Seleccionar base de datos de origen y destino
2. Ingresar contraseñas si es necesario
3. Hacer clic en "Cierre (Consolidar)"
4. Confirmar la operación en el modal

#### Retry de inserts fallidos
1. Ir a la página "Retry"
2. Revisar la lista de inserts fallidos
3. Hacer clic en "Reintentar Inserts Fallidos"
4. Verificar los resultados en el log

#### Programar tareas
1. Ir a la página "Programado"
2. Seleccionar bases de datos de origen y destino
3. Elegir el modo (apertura o cierre)
4. Configurar la recurrencia (único o recurrente)
5. Establecer fecha y hora de ejecución
6. Configurar concurrencia si es recurrente
7. Hacer clic en "Programar Tarea"

## Estructura del Proyecto

```
volcado/
├── app.py                 # Aplicación Flask principal
├── run.py                 # Script de inicio
├── start.sh              # Script de inicio para producción
├── templates/            # Plantillas HTML
│   ├── index.html
│   ├── retry.html
│   └── scheduled.html
├── assets/               # Archivos estáticos
│   ├── styles.css
│   ├── scripts.js
│   ├── retry.js
│   └── scheduled.js
├── scripts/              # Scripts de Python
│   ├── sync.py          # Sincronización de bases de datos
│   ├── retry.py         # Retry de inserts fallidos
│   └── scheduled.py     # Servicio de tareas programadas
├── json/                 # Archivos de configuración
│   ├── databases.json   # Configuración de bases de datos
│   └── scheduled.json   # Tareas programadas
└── log/                  # Archivos de log
    ├── db_consolidation.log
    ├── consolidation_failures.json
    └── consolidation_snapshot.json
```

## API Endpoints

### GET /api/databases
Obtiene la configuración de bases de datos disponibles.

### GET /api/status
Obtiene el estado actual del sistema.

### POST /api/sync_db
Ejecuta una operación de sincronización (apertura o cierre).

### GET /api/failed_inserts
Obtiene la lista de inserts fallidos.

### POST /api/retry_inserts
Ejecuta el retry de inserts fallidos.

### GET /api/scheduled_tasks
Obtiene la lista de tareas programadas.

### POST /api/schedule_sync
Programa una nueva tarea de sincronización.

### DELETE /api/scheduled_tasks/<index>
Elimina una tarea programada por índice.

## Logs y Monitoreo

### Logs del sistema
- `log/db_consolidation.log`: Log principal del sistema
- `log/consolidation_failures.json`: Inserts fallidos
- `log/consolidation_snapshot.json`: Snapshot de consolidación

### Monitoreo
- Estado del sistema en tiempo real
- Logs de actividad en cada página
- Notificaciones de éxito/error
- Estadísticas de operaciones

## Solución de Problemas

### Error de conexión a base de datos
- Verificar configuración en `json/databases.json`
- Comprobar que MySQL esté ejecutándose
- Validar credenciales de acceso

### Inserts fallidos
- Revisar la página de Retry
- Ejecutar retry manual
- Verificar logs para errores específicos

### Tareas programadas no se ejecutan
- Verificar que `scripts/scheduled.py` esté ejecutándose
- Comprobar configuración en `json/scheduled.json`
- Revisar logs del sistema

## Soporte

Para soporte técnico o reportar problemas, contactar al administrador del sistema.
