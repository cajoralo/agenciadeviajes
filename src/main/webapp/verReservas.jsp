<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Paquete, dao.PaqueteDAO" %>
<%
    PaqueteDAO dao = new PaqueteDAO();
    List<Paquete> paquetes = dao.listar();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Lista Paquetes - Agencia</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Lista de Paquetes</h2>
    <table class="table table-bordered table-striped mt-3">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Destino</th>
                <th>Precio</th>
                <th>Descripción</th>
                <th>Duración</th>
                <th>Disponible</th>
                <th>Fecha de Creación</th>
            </tr>
        </thead>
        <tbody>
        <% for(Paquete p : paquetes) { %>
            <tr>
                <td><%= p.getId() %></td>
                <td><%= p.getNombre() %></td>
                <td><%= p.getDestino() %></td>
                <td><%= p.getPrecio() %></td>
                <td><%= p.getDescripcion() %></td>
                <td><%= p.getDuracionDias() %></td>
                <td><%= p.isDisponible() ? "Sí" : "No" %></td>
                <td><%= p.getFechaCreacion() %></td>
            </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>