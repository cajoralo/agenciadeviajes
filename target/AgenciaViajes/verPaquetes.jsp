<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.PaqueteDAO, model.Paquete, java.util.List" %>
<%
    PaqueteDAO paqueteDAO = new PaqueteDAO();
    List<Paquete> paquetes = paqueteDAO.listar();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Lista Paquetes - Agencia de Viajes</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background: #f8f9fa; font-family: 'Segoe UI', sans-serif; padding-top: 40px; }
        .table-container {
            background: #ffffff; padding: 30px; border-radius: 15px;
            max-width: 900px; margin: auto; box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }
        .table-title { color: #28a745; margin-bottom: 20px; }
        .btn-save { background-color: #28a745; color: white; }
        .btn-save:hover { background-color: #218838; }
    </style>
</head>
<body>

<div class="container">
    <div class="table-container">
        <h3 class="table-title"><i class="fas fa-suitcase-rolling"></i> Lista de Paquetes</h3>
        <form action="paquetes" method="post">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Destino</th>
                        <th>Precio (USD)</th>
                        <th>Descripción</th>
                        <th>Duración (días)</th>
                        <th>Disponible</th>
                        <th>Acción</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    for (Paquete p : paquetes) {
                %>
                    <tr>
                        <td><%= p.getId() %></td>
                        <td><%= p.getNombre() %></td>
                        <td><%= p.getDestino() %></td>
                        <td><%= p.getPrecio() %></td>
                        <td>
                            <input type="text" name="descripcion_<%= p.getId() %>" value="<%= p.getDescripcion() %>" class="form-control">
                        </td>
                        <td><%= p.getDuracionDias() %></td>
                        <td><%= p.isDisponible() ? "Sí" : "No" %></td>
                        <td>
                            <button type="submit" name="editar" value="<%= p.getId() %>" class="btn btn-save btn-sm">
                                <i class="fas fa-save"></i> Guardar
                            </button>
                        </td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </form>
        <a href="index.jsp" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Volver al Inicio</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>