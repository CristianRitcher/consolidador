// Flask-based Database Consolidation System Frontend
// Global variables
const dbOrigenSelect = document.getElementById("db_origen_select");
const dbDestinoSelect = document.getElementById("db_destino_select");
const statusContainer = document.getElementById("status_info");
const logsContainer = document.getElementById("logs_content");
const currentStatusSpan = document.getElementById("current_status");
const lastActionSpan = document.getElementById("last_action");
const lastActionTimeSpan = document.getElementById("last_action_time");
const currentDatabaseSpan = document.getElementById("current_database");

// Modal elements
const confirmModal = document.getElementById("confirmModal");
const modalTitle = document.getElementById("modalTitle");
const modalMessage = document.getElementById("modalMessage");
const confirmBtn = document.getElementById("confirmBtn");
const cancelBtn = document.getElementById("cancelBtn");

// Load initial data and setup
document.addEventListener('DOMContentLoaded', function() {
    cargarOpciones();
    loadSystemStatus();
    setupModal();
    setupDatabaseSelectionListener();
});

// Setup event listener for database origin selection changes
function setupDatabaseSelectionListener() {
    dbOrigenSelect.addEventListener('change', function() {
        if (this.value) {
            try {
                const selectedOrigen = JSON.parse(this.value);
                const origenAlias = selectedOrigen.alias;
                
                console.log(`Base de datos origen seleccionada: ${origenAlias}`);
                
                // Update status for the selected database
                loadSystemStatus(origenAlias);
                
                // Show notification
                showNotification(`Mostrando estado de: ${origenAlias}`, 'info');
            } catch (error) {
                console.error('Error parsing selected database:', error);
                showNotification('Error al procesar la selección de base de datos', 'error');
            }
        } else {
            // If no database selected, show general status
            loadSystemStatus();
            showNotification('Mostrando estado general del sistema', 'info');
        }
    });
}

async function cargarOpciones() {
    try {
        const res = await fetch("/api/databases");
        const data = await res.json();

        if (data.status === 'error') {
            console.error('Error loading databases:', data.message);
            showNotification('Error cargando configuración de bases de datos', 'error');
            return;
        }

        // Clear existing options except the first one
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

async function loadSystemStatus(selectedOrigenAlias = null) {
    try {
        // Build URL with optional origen_alias parameter
        let url = "/api/status";
        if (selectedOrigenAlias) {
            url += `?origen_alias=${encodeURIComponent(selectedOrigenAlias)}`;
        }
        
        const res = await fetch(url);
        const data = await res.json();

        if (data.status === 'error') {
            currentStatusSpan.textContent = 'Error obteniendo estado';
            return;
        }

        // Update status display
        currentStatusSpan.textContent = data.consolidation_status || 'Sistema en línea';
        currentStatusSpan.className = data.consolidation_status === 'aperturado' ? 'status-value status-aperturado' : 'status-value status-cerrado';
        
        // Update last action info
        if (data.last_action) {
            lastActionSpan.textContent = data.last_action;
            lastActionTimeSpan.textContent = data.last_action_time ? new Date(data.last_action_time).toLocaleString() : '-';
        }

        // Update current database display
        if (data.current_database) {
            currentDatabaseSpan.textContent = data.current_database;
            console.log(`Mostrando estado de la base de datos: ${data.current_database}`);
        } else {
            currentDatabaseSpan.textContent = selectedOrigenAlias || 'General';
        }

        if (data.recent_logs && data.recent_logs.length > 0) {
            logsContainer.innerHTML = '<pre>' + data.recent_logs.slice(-10).join('') + '</pre>';
        }
    } catch (error) {
        console.error('Error loading status:', error);
        currentStatusSpan.textContent = 'Error de conexión';
    }
}

// Setup modal functionality
function setupModal() {
    cancelBtn.addEventListener('click', () => {
        confirmModal.style.display = 'none';
    });

    window.addEventListener('click', (event) => {
        if (event.target === confirmModal) {
            confirmModal.style.display = 'none';
        }
    });
}

// Show confirmation modal
function showConfirmModal(title, message, onConfirm) {
    modalTitle.textContent = title;
    modalMessage.textContent = message;
    confirmModal.style.display = 'block';
    
    // Remove previous event listeners
    const newConfirmBtn = confirmBtn.cloneNode(true);
    confirmBtn.parentNode.replaceChild(newConfirmBtn, confirmBtn);
    
    newConfirmBtn.addEventListener('click', () => {
        confirmModal.style.display = 'none';
        onConfirm();
    });
}

// Confirmation functions
function confirmarApertura() {
    if (!dbOrigenSelect.value || !dbDestinoSelect.value) {
        showNotification("Por favor seleccione las bases de datos de origen y destino", "error");
        return;
    }
    
    showConfirmModal(
        "Confirmar Apertura", 
        "¿Está seguro que desea realizar la apertura? Esta acción tomará un snapshot de la base de datos de origen.",
        () => apertura()
    );
}

function confirmarCierre() {
    if (!dbOrigenSelect.value || !dbDestinoSelect.value) {
        showNotification("Por favor seleccione las bases de datos de origen y destino", "error");
        return;
    }
    
    showConfirmModal(
        "Confirmar Cierre", 
        "¿Está seguro que desea realizar el cierre? Esta acción consolidará los cambios en la base de datos de destino.",
        () => cierre()
    );
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

const apertura = async () => {
    const button = document.getElementById('btn_apertura');
    
    try {
        console.log("Starting apertura...");
        setButtonState(button, true);
        
        const origen = JSON.parse(dbOrigenSelect.value);
        const destino = JSON.parse(dbDestinoSelect.value);
        
        const post_json = {
            "modo": "apertura",
            "db_password_origen": document.getElementById("db_password_origen").value,
            "db_password_destino": document.getElementById("db_password_destino").value,
            "db_origen": origen,
            "db_destino": destino
        };
        
        console.log("Sending apertura request:", post_json);
        showNotification("Iniciando proceso de apertura...", "info");
        
        const response = await fetch("/api/sync_db", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(post_json)
        });
        
        const result = await response.json();
        console.log("Apertura response:", result);
        
        if (response.ok && result.status !== 'error') {
            showNotification("Apertura completada exitosamente", "success");
            updateLog(`[${new Date().toLocaleString()}] Apertura completada - ${origen.alias} → ${destino.alias}`);
            loadSystemStatus(); // Refresh status
        } else {
            const errorMsg = result.message || "Error desconocido";
            showNotification(`Error en apertura: ${errorMsg}`, "error");
            updateLog(`[${new Date().toLocaleString()}] Error en apertura: ${errorMsg}`);
        }
    } catch (error) {
        console.error("Error en apertura:", error);
        showNotification(`Error de conexión: ${error.message}`, "error");
        updateLog(`[${new Date().toLocaleString()}] Error de conexión: ${error.message}`);
    } finally {
        setButtonState(button, false);
    }
}

const cierre = async () => {
    const button = document.getElementById('btn_cierre');
    
    try {
        console.log("Starting cierre...");
        setButtonState(button, true);
        
        const origen = JSON.parse(dbOrigenSelect.value);
        const destino = JSON.parse(dbDestinoSelect.value);
        
        const post_json = {
            "modo": "cierre",
            "db_password_origen": document.getElementById("db_password_origen").value,
            "db_password_destino": document.getElementById("db_password_destino").value,
            "db_origen": origen,
            "db_destino": destino
        };
        
        console.log("Sending cierre request:", post_json);
        showNotification("Iniciando proceso de cierre...", "info");
        
        const response = await fetch("/api/sync_db", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(post_json)
        });
        
        const result = await response.json();
        console.log("Cierre response:", result);
        
        if (response.ok && result.status !== 'error') {
            showNotification("Cierre completado exitosamente", "success");
            updateLog(`[${new Date().toLocaleString()}] Cierre completado - ${origen.alias} → ${destino.alias}`);
            loadSystemStatus(); // Refresh status
        } else {
            const errorMsg = result.message || "Error desconocido";
            showNotification(`Error en cierre: ${errorMsg}`, "error");
            updateLog(`[${new Date().toLocaleString()}] Error en cierre: ${errorMsg}`);
        }
    } catch (error) {
        console.error("Error en cierre:", error);
        showNotification(`Error de conexión: ${error.message}`, "error");
        updateLog(`[${new Date().toLocaleString()}] Error de conexión: ${error.message}`);
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