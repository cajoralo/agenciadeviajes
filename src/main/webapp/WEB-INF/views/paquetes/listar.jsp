<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Paquete" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Paquetes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f5f7fa;
        }

        .package-card {
            border-radius: 16px;
            border: none;
            padding: 20px;
            background: white;
            box-shadow: 0 6px 18px rgba(0,0,0,0.08);
            transition: 0.2s ease-in-out;
        }

        .package-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 25px rgba(0,0,0,0.15);
        }

        .package-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: #1d3557;
        }

        .package-detail strong {
            color: #2a3d66;
        }

        .btn-reservar {
            background-color: #2b9348;
            color: white;
        }

        .btn-reservar:hover {
            background-color: #1d6f33;
            color: white;
        }

    </style>
</head>
<body>

<div class="container mt-4">

    <!-- Encabezado con volver e insertar nuevo paquete -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div class="d-flex align-items-center gap-2">
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-outline-secondary">
                ← Volver al inicio
            </a>
            <h2 class="mb-0">Paquetes</h2>
        </div>

        <div>
            <a class="btn btn-success" href="${pageContext.request.contextPath}/paquetes?action=nuevo">
                + Nuevo Paquete
            </a>
            <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/clientes?action=listar">
                Clientes
            </a>
            <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/reservas?action=listar">
                Reservas
            </a>
        </div>
    </div>

    <%
        List<Paquete> lista = (List<Paquete>) request.getAttribute("paquetes");
        if (lista != null && !lista.isEmpty()) {
            for (Paquete p : lista) {
    %>

    <!-- Tarjeta del paquete -->
    <div class="package-card mb-4">

        <div class="package-title">
            <%= p.getNombre().toUpperCase() %>
        </div>

        <p class="mt-2 text-muted">
            <%= p.getDescripcion() %>
        </p>

        <div class="package-detail mt-3">
            <p><strong>Destino:</strong> <%= p.getDestino() %></p>
            <p><strong>Precio:</strong> $<%= p.getPrecio() %></p>
            <p><strong>Duración:</strong> <%= p.getDuracionDias() %> días</p>
            <p><strong>Disponible:</strong> <%= p.isDisponible() ? "Sí" : "No" %></p>
        </div>

        <!-- Botones -->
        <div class="mt-3 d-flex gap-2">
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/paquetes?action=editar&id=<%=p.getId()%>">Editar</a>
            <a class="btn btn-danger" href="${pageContext.request.contextPath}/paquetes?action=eliminar&id=<%=p.getId()%>" onclick="return confirm('¿Eliminar paquete?')">Eliminar</a>
            <a class="btn btn-reservar" href="${pageContext.request.contextPath}/reservas?action=nueva&paqueteId=<%=p.getId()%>">
                Reservar
            </a>
        </div>

    </div>

    <%      }
        } else { %>

    <div class="alert alert-info text-center mt-4">
        No hay paquetes registrados todavía.
    </div>

    <% } %>

</div>

</body>
</html>
