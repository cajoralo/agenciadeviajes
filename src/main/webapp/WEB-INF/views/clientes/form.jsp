<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Cliente" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Cliente</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f5f5f5;
        }
        .page-title {
            font-weight: 700;
        }
        .card-form {
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.07);
        }
    </style>
</head>
<body>

<div class="container mt-4 mb-5">
    <%
        Cliente c = (Cliente) request.getAttribute("cliente");
        boolean esNuevo = (c == null);
    %>

    <!-- Título y enlace volver -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div>
            <h3 class="page-title mb-0">
                <%= esNuevo ? "Nuevo Cliente" : "Editar Cliente" %>
            </h3>
            <small class="text-muted">
                Completa la información del cliente para poder gestionar sus reservas.
            </small>
        </div>
        <a href="${pageContext.request.contextPath}/clientes?action=listar"
           class="btn btn-link">&larr; Volver al listado</a>
    </div>

    <div class="row justify-content-center">
        <div class="col-lg-8 col-xl-6">
            <div class="card card-form">
                <div class="card-body">
                    <form method="post" action="${pageContext.request.contextPath}/clientes">
                        <input type="hidden" name="id" value="<%= c != null ? c.getId() : "" %>">

                        <div class="mb-3">
                            <label class="form-label">Nombre completo</label>
                            <input name="nombre"
                                   class="form-control"
                                   placeholder="Ej: Carlos Aguilera"
                                   value="<%= c != null ? c.getNombre() : "" %>"
                                   required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input name="email" type="email"
                                   class="form-control"
                                   placeholder="ejemplo@correo.com"
                                   value="<%= c != null ? c.getEmail() : "" %>"
                                   required>
                            <div class="form-text">
                                Usaremos este correo para enviar confirmaciones de reserva.
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Teléfono</label>
                            <input name="telefono"
                                   class="form-control"
                                   placeholder="Ej: 0999999999"
                                   value="<%= c != null ? c.getTelefono() : "" %>">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Dirección</label>
                            <input name="direccion"
                                   class="form-control"
                                   placeholder="Ciudad, sector, referencia..."
                                   value="<%= c != null ? c.getDireccion() : "" %>">
                        </div>

                        <div class="d-flex justify-content-end gap-2 mt-3">

    <!-- Botón Cancelar -> vuelve al listado de clientes -->
    <a class="btn btn-secondary"
       href="${pageContext.request.contextPath}/clientes?action=listar">
        Cancelar
    </a>

    <!-- Botón Guardar -->
    <button class="btn btn-primary" type="submit">
        Guardar
    </button>

    <!-- Botón Volver al inicio -->
    <a class="btn btn-outline-primary"
       href="${pageContext.request.contextPath}/index.jsp">
        ← Volver al inicio
    </a>

</div>
</form>

                </div>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

