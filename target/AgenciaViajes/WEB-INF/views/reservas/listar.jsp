<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Reserva" %>
<!DOCTYPE html>
<html><head><meta charset="utf-8"><title>Reservas</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"></head>
<body><div class="container mt-4">
  <div class="d-flex justify-content-between">
    <h3>Reservas</h3>
    <a class="btn btn-success" href="${pageContext.request.contextPath}/reservas?action=nueva">Nueva Reserva</a>
  </div>
  <table class="table table-striped mt-3">
    <thead><tr><th>ID</th><th>Cliente ID</th><th>Paquete ID</th><th>Fecha</th><th>Personas</th><th>Estado</th><th>Acciones</th></tr></thead>
    <tbody>
      <%
        List<Reserva> lista = (List<Reserva>) request.getAttribute("reservas");
        if (lista != null) {
          for (Reserva r : lista) {
      %>
      <tr>
        <td><%= r.getId() %></td>
        <td><%= r.getClienteId() %></td>
        <td><%= r.getPaqueteId() %></td>
        <td><%= r.getFechaReserva() %></td>
        <td><%= r.getNumeroPersonas() %></td>
        <td><%= r.getEstado() %></td>
        <td>
          <a class="btn btn-sm btn-primary" href="${pageContext.request.contextPath}/reservas?action=editar&id=<%=r.getId()%>">Editar</a>
          <a class="btn btn-sm btn-danger" href="${pageContext.request.contextPath}/reservas?action=eliminar&id=<%=r.getId()%>" onclick="return confirm('Eliminar?')">Eliminar</a>
        </td>
      </tr>
      <%
          }
        }
      %>
    </tbody>
  </table>
</div>
</body>
</html>