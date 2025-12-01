<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Paquete, dao.PaqueteDAO" %>
<!DOCTYPE html>
<html>
<head>
    <title>Nueva Reserva - Agencia de Viajes</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background: #f8f9fa; font-family: 'Segoe UI', sans-serif; padding-top: 40px; }
        .form-container {
            background: #ffffff; padding: 30px; border-radius: 15px;
            max-width: 700px; margin: auto; box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }
        .form-title { color: #ffc107; margin-bottom: 20px; }
        .btn-submit { background-color: #ffc107; color: white; }
        .btn-submit:hover { background-color: #e0a800; }
        .btn-back { margin-left: 10px; }
        #paqueteInfo img { max-width: 100%; border-radius: 10px; margin-top: 10px; }
        #paqueteInfo { margin-top: 15px; }
    </style>
</head>
<body>

<div class="container">
    <div class="form-container">
        <h3 class="form-title"><i class="fas fa-calendar-plus"></i> Nueva Reserva</h3>
        <form action="reservas" method="post">

            <!-- Nombre del Cliente -->
            <div class="mb-3">
                <label for="clienteNombre" class="form-label">Nombre del Cliente</label>
                <input type="text" class="form-control" id="clienteNombre" name="clienteNombre" placeholder="Ingrese su nombre" required>
            </div>

            <!-- Paquete -->
            <div class="mb-3">
                <label for="paquete" class="form-label">Paquete</label>
                <select class="form-select" id="paquete" name="paqueteId" onchange="mostrarPaqueteInfo()" required>
                    <option value="">-- Selecciona un paquete --</option>
                    <%
                        List<Paquete> paquetes = new PaqueteDAO().listarDisponibles();
                        for(Paquete p : paquetes) {
                    %>
                        <option value="<%= p.getId() %>" data-nombre="<%= p.getNombre() %>" data-destino="<%= p.getDestino() %>" data-imagen="<%= p.getImagenUrl() %>">
                            <%= p.getNombre() + " - " + p.getDestino() %>
                        </option>
                    <%
                        }
                    %>
                </select>
            </div>

            <!-- Info del paquete -->
            <div id="paqueteInfo" class="alert alert-info" style="display:none;">
                <h5 id="paqueteNombre"></h5>
                <p id="paqueteDestino"></p>
                <img id="paqueteImagen" src="" alt="Imagen del paquete">
            </div>

            <!-- Fecha de Reserva -->
            <div class="mb-3">
                <label for="fecha" class="form-label">Fecha de Reserva</label>
                <input type="date" class="form-control" id="fecha" name="fecha" required>
            </div>

            <!-- Número de Personas -->
            <div class="mb-3">
                <label for="numeroPersonas" class="form-label">Número de Personas</label>
                <input type="number" class="form-control" id="numeroPersonas" name="numeroPersonas" min="1" required>
            </div>

            <!-- Estado -->
            <div class="mb-3">
                <label for="estado" class="form-label">Estado</label>
                <select class="form-select" id="estado" name="estado">
                    <option value="Pendiente">Pendiente</option>
                    <option value="Confirmada">Confirmada</option>
                    <option value="Cancelada">Cancelada</option>
                </select>
            </div>

            <!-- Botones -->
            <button type="submit" class="btn btn-submit"><i class="fas fa-save"></i> Guardar Reserva</button>
            <a href="reservas?action=listar" class="btn btn-secondary btn-back"><i class="fas fa-arrow-left"></i> Volver a Reservas</a>

        </form>
    </div>
</div>

<script>
function mostrarPaqueteInfo() {
    var select = document.getElementById("paquete");
    var selected = select.options[select.selectedIndex];
    var infoDiv = document.getElementById("paqueteInfo");

    if(selected.value === "") {
        infoDiv.style.display = "none";
        return;
    }

    document.getElementById("paqueteNombre").innerText = selected.getAttribute("data-nombre");
    document.getElementById("paqueteDestino").innerText = selected.getAttribute("data-destino");
    document.getElementById("paqueteImagen").src = selected.getAttribute("data-imagen");
    infoDiv.style.display = "block";
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>