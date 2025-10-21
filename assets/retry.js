// Retry functionality for failed inserts
const failedInsertsList = document.getElementById('failed_inserts_list');
const logsContainer = document.getElementById('logs_content');

// Load initial data
document.addEventListener('DOMContentLoaded', function() {
    cargarInsertsFallidos();
});

async function cargarInsertsFallidos() {
    try {
        const response = await fetch('/api/failed_inserts');
        const data = await response.json();

        if (data.status === 'error') {
            failedInsertsList.innerHTML = `<p class="error-message"> ${data.message}</p>`;
            return;
        }

        if (!data.failed_inserts || data.failed_inserts.length === 0) {
            failedInsertsList.innerHTML = `
                <div class="no-failures">
                    <h4>No hay inserts fallidos</h4>
                    <p>Todos los inserts se han procesado correctamente.</p>
                </div>
            `;
            return;
        }

        // Display failed inserts
        let html = `<h4>Inserts Fallidos (${data.failed_inserts.length})</h4>`;
        
        data.failed_inserts.forEach((insert, index) => {
            html += `
                <div class="failed-insert-item">
                    <div class="insert-header">
                        <span class="insert-table"> ${insert.table}</span>
                        <span class="insert-source">🗃️ ${insert.source_config.alias}</span>
                        <span class="insert-time"> ${new Date(insert.timestamp).toLocaleString()}</span>
                    </div>
                    <div class="insert-error">
                        <strong>Error:</strong> ${insert.error}
                    </div>
                    <details class="insert-details">
                        <summary>Ver detalles del registro</summary>
                        <pre class="insert-record">${JSON.stringify(insert.record, null, 2)}</pre>
                    </details>
                </div>
            `;
        });

        failedInsertsList.innerHTML = html;
        updateLog(`[${new Date().toLocaleString()}] Cargados ${data.failed_inserts.length} inserts fallidos`);

    } catch (error) {
        console.error('Error loading failed inserts:', error);
        failedInsertsList.innerHTML = `<p class="error-message"> Error de conexión: ${error.message}</p>`;
        updateLog(`[${new Date().toLocaleString()}] Error cargando inserts fallidos: ${error.message}`);
    }
}

async function ejecutarRetry() {
    const button = document.getElementById('btn_retry');
    
    try {
        console.log("Starting retry...");
        setButtonState(button, true);
        
        showNotification("Iniciando proceso de retry...", "info");
        updateLog(`[${new Date().toLocaleString()}] Iniciando retry de inserts fallidos`);
        
        const response = await fetch('/api/retry_inserts', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' }
        });
        
        const result = await response.json();
        console.log("Retry response:", result);
        
        if (response.ok && result.status !== 'error') {
            showNotification("Retry completado exitosamente", "success");
            updateLog(`[${new Date().toLocaleString()}] Retry completado: ${result.successful_retries} exitosos, ${result.failed_retries} fallidos`);
            
            // Refresh the failed inserts list
            setTimeout(() => {
                cargarInsertsFallidos();
            }, 1000);
        } else {
            const errorMsg = result.message || "Error desconocido";
            showNotification(` Error en retry: ${errorMsg}`, "error");
            updateLog(`[${new Date().toLocaleString()}] Error en retry: ${errorMsg}`);
        }
    } catch (error) {
        console.error("Error en retry:", error);
        showNotification(` Error de conexión: ${error.message}`, "error");
        updateLog(`[${new Date().toLocaleString()}] Error de conexión en retry: ${error.message}`);
    } finally {
        setButtonState(button, false);
    }
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
