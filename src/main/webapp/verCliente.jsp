<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ClienteDAO, model.Cliente, java.util.List" %>

<%
    ClienteDAO clienteDAO = new ClienteDAO();
    List<Cliente> clientes = clienteDAO.listar();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Lista Clientes - Agencia de Viajes</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background: #f8f9fa; font-family: 'Segoe UI', sans-serif; padding-top: 40px; }
        .table-container {
            background: #ffffff; padding: 30px; border-radius: 15px;
            max-width: 900px; margin: auto; box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }
        .table-title { color: #17a2b8; margin-bottom: 20px; }
    </style>
</head>
<body>

<div class="container">
    <div class="table-container">
        <h3 class="table-title"><i class="fas fa-users"></i> Lista de Clientes</h3>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Email</th>
                    <th>Teléfono</th>
                    <th>Fecha de Registro</th>
                </tr>
            </thead>
            <tbody>
            <%
                for (Cliente c : clientes) {
            %>
                <tr>
                    <td><%= c.getId() %></td>
                    <td><%= c.getNombre() %></td>
                    <td><%= c.getEmail() %></td>
                    <td><%= c.getTelefono() %></td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
        <a href="index.jsp" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Volver al Inicio</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>