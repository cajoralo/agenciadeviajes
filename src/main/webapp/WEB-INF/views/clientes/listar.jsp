<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Paquete" %>
<!DOCTYPE html>
<html><head><meta charset="utf-8"><title>Paquetes</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"></head>
<body><div class="container mt-4">
  <div class="d-flex justify-content-between">
    <h3>Paquetes</h3>
    <div>
      <a class="btn btn-success" href="${pageContext.request.contextPath}/paquetes?action=nuevo">Nuevo Paquete</a>
      <a class="btn btn-link" href="${pageContext.request.contextPath}/clientes">Clientes</a>
      <a class="btn btn-link" href="${pageContext.request.contextPath}/reservas">Reservas</a>
    </div>
  </div>
  <div class="row mt-3">
    <%
      List<Paquete> lista = (List<Paquete>) request.getAttribute("paquetes");
      if (lista != null) {
        for (Paquete p : lista) {
    %>
    <div class="col-md-6 mb-3">
      <div class="card">
        <div class="card-body">
          <h5 class="card-title"><%= p.getTitulo() %></h5>
          <p class="card-text"><%= p.getDescripcion() != null && p.getDescripcion().length() > 120 ? p.getDescripcion().substring(0,120) + "..." : p.getDescripcion() %></p>
          <p class="mb-1">Precio: <strong>$<%= p.getPrecio() %></strong></p>
          <p class="mb-1">Duración: <%= p.getDuracionDias() %> días</p>
          <p class="mb-2">Disponible: <%= p.isDisponible() ? "Sí" : "No" %></p>
          <a class="btn btn-primary btn-sm" href="${pageContext.request.contextPath}/paquetes?action=editar&id=<%= p.getId() %>">Editar</a>
          <a class="btn btn-danger btn-sm" href="${pageContext.request.contextPath}/paquetes?action=eliminar&id=<%= p.getId() %>" onclick="return confirm('Eliminar?')">Eliminar</a>
          <a class="btn btn-outline-success btn-sm" href="${pageContext.request.contextPath}/reservas?action=nueva">Reservar</a>
        </div>
      </div>
    </div>
    <%
        }
      }
    %>
  </div>
</div>
</body>
</html>