<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Reserva, model.Cliente, model.Paquete, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Reserva</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f5f7fb;
        }
        .card-reserva {
            border-radius: 16px;
            border: none;
            box-shadow: 0 8px 20px rgba(15, 23, 42, 0.08);
        }
        .card-reserva .card-header {
            border-radius: 16px 16px 0 0;
        }
        .section-title {
            font-size: .85rem;
            text-transform: uppercase;
            letter-spacing: .08em;
            color: #6c757d;
            font-weight: 600;
            margin-bottom: .25rem;
        }
    </style>
</head>
<body>
<div class="container py-4">

    <%
        Reserva r = (Reserva) request.getAttribute("reserva");
        List<Cliente> clientes = (List<Cliente>) request.getAttribute("clientes");
        List<Paquete> paquetes = (List<Paquete>) request.getAttribute("paquetes");
        boolean esNueva = (r == null);
    %>

    <!-- Título + botón volver -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div>
            <h2 class="mb-0"><%= esNueva ? "Nueva Reserva" : "Editar Reserva" %></h2>
            <p class="text-muted mb-0">Gestiona las reservas de tus clientes de forma sencilla</p>
        </div>
        <a class="btn btn-outline-secondary"
           href="${pageContext.request.contextPath}/reservas?action=listar">
            ← Volver a la lista
        </a>
    </div>

    <!-- Card principal -->
    <div class="card card-reserva">
        <div class="card-header bg-primary text-white">
            <strong><%= esNueva ? "Datos de la nueva reserva" : "Actualizar datos de la reserva" %></strong>
        </div>
        <div class="card-body">

            <form method="post" action="${pageContext.request.contextPath}/reservas">
                <input type="hidden" name="id" value="<%= r != null ? r.getId() : "" %>">

                <!-- Bloque 1: Cliente y Paquete -->
                <div class="mb-4">
                    <div class="section-title">Información básica</div>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Cliente</label>
                            <select name="clienteId" class="form-select" required>
                                <option value="">-- Seleccione cliente --</option>
                                <%
                                    if (clientes != null) {
                                        for (Cliente c : clientes) {
                                %>
                                <option value="<%= c.getId() %>"
                                    <%= r != null && r.getClienteId() == c.getId() ? "selected" : "" %>>
                                    <%= c.getNombre() %> - <%= c.getEmail() %>
                                </option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                            <div class="form-text">Elige el cliente que realiza la reserva.</div>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Paquete</label>
                            <select name="paqueteId" class="form-select" required>
                                <option value="">-- Seleccione paquete --</option>
                                <%
                                    if (paquetes != null) {
                                        for (Paquete p : paquetes) {
                                %>
                                <option value="<%= p.getId() %>"
                                    <%= r != null && r.getPaqueteId() == p.getId() ? "selected" : "" %>>
                                    <%= p.getNombre() %> - $<%= p.getPrecio() %>
                                </option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                            <div class="form-text">Selecciona el paquete turístico.</div>
                        </div>
                    </div>
                </div>

                <!-- Bloque 2: Fecha, Personas, Estado -->
                <div class="mb-4">
                    <div class="section-title">Detalles del viaje</div>
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label class="form-label">Fecha</label>
                            <input type="date"
                                   name="fechaReserva"
                                   class="form-control"
                                   value="<%= r != null && r.getFechaReserva() != null ? r.getFechaReserva().toString() : "" %>"
                                   required>
                            <div class="form-text">Día de inicio del viaje.</div>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Personas</label>
                            <input type="number"
                                   min="1"
                                   name="numeroPersonas"
                                   class="form-control"
                                   value="<%= r != null ? r.getNumeroPersonas() : 1 %>">
                            <div class="form-text">Número total de viajeros.</div>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Estado</label>
                            <select name="estado" class="form-select">
                                <option value="CONFIRMADA"
                                    <%= r != null && "CONFIRMADA".equals(r.getEstado()) ? "selected" : "" %>>
                                    CONFIRMADA
                                </option>
                                <option value="PENDIENTE"
                                    <%= r != null && "PENDIENTE".equals(r.getEstado()) ? "selected" : "" %>>
                                    PENDIENTE
                                </option>
                                <option value="CANCELADA"
                                    <%= r != null && "CANCELADA".equals(r.getEstado()) ? "selected" : "" %>>
                                    CANCELADA
                                </option>
                            </select>
                            <div class="form-text">Controla el estado de la reserva.</div>
                        </div>
                    </div>
                </div>

                <!-- Botones -->
                <div class="d-flex justify-content-end gap-2 mt-3">

    <a class="btn btn-secondary"
       href="${pageContext.request.contextPath}/reservas?action=listar">
        Cancelar
    </a>

    <button class="btn btn-primary" type="submit">
        Guardar
    </button>

    <a class="btn btn-outline-primary"
       href="${pageContext.request.contextPath}/index.jsp">
        ← Volver al inicio
    </a>

</div>
</form>


        </div>
    </div>

</div>
</body>
</html>
