// Scheduled tasks functionality
const dbOrigenSelect = document.getElementById('scheduled_db_origen');
const dbDestinoSelect = document.getElementById('scheduled_db_destino');
const modoSelect = document.getElementById('scheduled_modo');
const recurrenciaSelect = document.getElementById('scheduled_recurrencia');
const fechaInput = document.getElementById('scheduled_fecha');
const concurrenciaInput = document.getElementById('scheduled_concurrencia');
const concurrenciaContainer = document.getElementById('concurrencia_container');
const scheduledTasksList = document.getElementById('scheduled_tasks_list');
const logsContainer = document.getElementById('logs_content');

// Load initial data
document.addEventListener('DOMContentLoaded', function() {
    cargarOpciones();
    cargarTareasProgramadas();
});

async function cargarOpciones() {
    try {
        const res = await fetch("/api/databases");
        const data = await res.json();

        if (data.status === 'error') {
            console.error('Error loading databases:', data.message);
            showNotification('Error cargando configuración de bases de datos', 'error');
            return;
        }

        // Clear existing options
        dbOrigenSelect.innerHTML = '<option value="">-- Seleccionar base de origen --</option>';
        dbDestinoSelect.innerHTML = '<option value="">-- Seleccionar base de destino --</option>';

        // Load origen databases
        data.db_origenes.forEach(origen => {
            const option = document.createElement("option");
            option.value = JSON.stringify(origen);
            option.textContent = `${origen.alias} (${origen.database})`;
            dbOrigenSelect.appendChild(option);
        });

        // Load destino databases
        data.db_destinos.forEach(destino => {
            const option = document.createElement("option");
            option.value = JSON.stringify(destino);
            option.textContent = `${destino.alias} (${destino.database})`;
            dbDestinoSelect.appendChild(option);
        });

        showNotification('Configuración cargada exitosamente', 'success');
    } catch (error) {
        console.error('Error loading options:', error);
        showNotification('Error de conexión al cargar configuración', 'error');
    }
}

function toggleRecurrenciaOptions() {
    const recurrencia = recurrenciaSelect.value;
    
    if (recurrencia === 'recurrente') {
        concurrenciaContainer.style.display = 'block';
        concurrenciaInput.setAttribute('required', 'required');
    } else {
        concurrenciaContainer.style.display = 'none';
        concurrenciaInput.removeAttribute('required');
    }
}

async function programarTarea() {
    const button = document.getElementById('btn_schedule');
    
    try {
        // Validate form
        if (!dbOrigenSelect.value || !dbDestinoSelect.value || !modoSelect.value || !recurrenciaSelect.value || !fechaInput.value) {
            showNotification("Por favor complete todos los campos requeridos", "error");
            return;
        }

        const recurrencia = recurrenciaSelect.value;
        if (recurrencia === 'recurrente' && (!concurrenciaInput.value || concurrenciaInput.value < 1)) {
            showNotification("Por favor ingrese un valor válido para la concurrencia", "error");
            return;
        }

        setButtonState(button, true);

        const origen = JSON.parse(dbOrigenSelect.value);
        const destino = JSON.parse(dbDestinoSelect.value);
        const modo = modoSelect.value;
        const fecha = new Date(fechaInput.value);
        
        // Determine concurrency based on recurrence
        let concurrency;
        if (recurrencia === 'unico') {
            concurrency = 0; // Single execution
        } else {
            concurrency = parseInt(concurrenciaInput.value);
        }

        const taskData = {
            db_origen: origen,
            db_destino: destino,
            modo: modo,
            concurrency: concurrency,
            date_time: fecha.toISOString()
        };

        console.log("Scheduling task:", taskData);
        showNotification("Programando tarea...", "info");
        updateLog(`[${new Date().toLocaleString()}] Programando tarea: ${modo} de ${origen.alias} a ${destino.alias}`);

        const response = await fetch('/api/schedule_sync', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(taskData)
        });

        const result = await response.json();
        console.log("Schedule response:", result);

        if (response.ok && result.status !== 'error') {
            showNotification("Tarea programada exitosamente", "success");
            updateLog(`[${new Date().toLocaleString()}] Tarea programada exitosamente`);
            
            // Refresh scheduled tasks list
            setTimeout(() => {
                cargarTareasProgramadas();
            }, 1000);
            
            // Clear form
            limpiarFormulario();
        } else {
            const errorMsg = result.message || "Error desconocido";
            showNotification(`Error programando tarea: ${errorMsg}`, "error");
            updateLog(`[${new Date().toLocaleString()}] Error programando tarea: ${errorMsg}`);
        }
    } catch (error) {
        console.error("Error scheduling task:", error);
        showNotification(`Error de conexión: ${error.message}`, "error");
        updateLog(`[${new Date().toLocaleString()}] Error de conexión: ${error.message}`);
    } finally {
        setButtonState(button, false);
    }
}

async function cargarTareasProgramadas() {
    try {
        const response = await fetch('/api/scheduled_tasks');
        const data = await response.json();

        if (data.status === 'error') {
            scheduledTasksList.innerHTML = `<p class="error-message">${data.message}</p>`;
            return;
        }

        if (!data.tasks || data.tasks.length === 0) {
            scheduledTasksList.innerHTML = `
                <div class="no-tasks">
                    <h4>No hay tareas programadas</h4>
                    <p>No se encontraron tareas programadas.</p>
                </div>
            `;
            return;
        }

        // Display scheduled tasks
        let html = `<h4>Tareas Programadas (${data.tasks.length})</h4>`;
        
        data.tasks.forEach((task, index) => {
            const fechaProgramada = new Date(task.date_time);
            const concurrencyText = task.concurrency === 0 ? 'Único' : `Cada ${task.concurrency} días`;
            const modoText = task.modo === 'apertura' ? 'Apertura' : 'Cierre';
            
            html += `
                <div class="scheduled-task-item">
                    <div class="task-header">
                        <span class="task-mode">${modoText}</span>
                        <span class="task-source">${task.db_origen.alias} → ${task.db_destino.alias}</span>
                        <span class="task-recurrence">${concurrencyText}</span>
                    </div>
                    <div class="task-details">
                        <div class="task-time">
                            <strong>Programado para:</strong> ${fechaProgramada.toLocaleString()}
                        </div>
                        <div class="task-actions">
                            <button class="btn btn-sm btn-danger" onclick="eliminarTarea(${index})">
                                Eliminar
                            </button>
                        </div>
                    </div>
                </div>
            `;
        });

        scheduledTasksList.innerHTML = html;

    } catch (error) {
        console.error('Error loading scheduled tasks:', error);
        scheduledTasksList.innerHTML = `<p class="error-message">Error de conexión: ${error.message}</p>`;
        updateLog(`[${new Date().toLocaleString()}] Error cargando tareas programadas: ${error.message}`);
    }
}

async function eliminarTarea(index) {
    try {
        showNotification("Eliminando tarea...", "info");
        updateLog(`[${new Date().toLocaleString()}] Eliminando tarea programada #${index}`);
        
        const response = await fetch(`/api/scheduled_tasks/${index}`, {
            method: 'DELETE'
        });

        const result = await response.json();

        if (response.ok && result.status !== 'error') {
            showNotification("Tarea eliminada exitosamente", "success");
            updateLog(`[${new Date().toLocaleString()}] Tarea eliminada exitosamente`);
            
            // Refresh scheduled tasks list
            setTimeout(() => {
                cargarTareasProgramadas();
            }, 1000);
        } else {
            const errorMsg = result.message || "Error desconocido";
            showNotification(`Error eliminando tarea: ${errorMsg}`, "error");
            updateLog(`[${new Date().toLocaleString()}] Error eliminando tarea: ${errorMsg}`);
        }
    } catch (error) {
        console.error("Error deleting task:", error);
        showNotification(`Error de conexión: ${error.message}`, "error");
        updateLog(`[${new Date().toLocaleString()}] Error de conexión: ${error.message}`);
    }
}

function limpiarFormulario() {
    dbOrigenSelect.value = '';
    dbDestinoSelect.value = '';
    modoSelect.value = '';
    recurrenciaSelect.value = '';
    fechaInput.value = '';
    concurrenciaInput.value = '1';
    concurrenciaContainer.style.display = 'none';
    concurrenciaInput.removeAttribute('required');
}

// Update log display
function updateLog(message) {
    const timestamp = new Date().toLocaleString();
    const logEntry = `[${timestamp}] ${message}`;
    
    if (logsContainer.innerHTML.includes('Esperando operaciones...')) {
        logsContainer.innerHTML = `<pre>${logEntry}</pre>`;
    } else {
        const currentLogs = logsContainer.innerHTML.replace('<pre>', '').replace('</pre>', '');
        logsContainer.innerHTML = `<pre>${currentLogs}\n${logEntry}</pre>`;
    }
}

// Utility functions
function showNotification(message, type = 'info') {
    // Create notification element
    const notification = document.createElement('div');
    notification.className = `notification notification-${type}`;
    notification.textContent = message;
    
    // Add to page
    document.body.appendChild(notification);
    
    // Auto remove after 5 seconds
    setTimeout(() => {
        if (notification.parentNode) {
            notification.parentNode.removeChild(notification);
        }
    }, 5000);
}

function setButtonState(button, loading = false) {
    if (loading) {
        button.disabled = true;
        button.dataset.originalText = button.textContent;
        button.textContent = 'Procesando...';
    } else {
        button.disabled = false;
        button.textContent = button.dataset.originalText || button.textContent;
    }
}