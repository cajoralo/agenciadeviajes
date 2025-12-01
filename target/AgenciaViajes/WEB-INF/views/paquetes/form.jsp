<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Paquete" %>
<!DOCTYPE html>
<html><head><meta charset="utf-8"><title>Paquete</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"></head>
<body><div class="container mt-4">
  <h3><%= request.getAttribute("paquete") == null ? "Nuevo Paquete" : "Editar Paquete" %></h3>
  <%
    Paquete p = (Paquete) request.getAttribute("paquete");
  %>
  <form method="post" action="${pageContext.request.contextPath}/paquetes">
    <input type="hidden" name="id" value="<%= p != null ? p.getId() : "" %>">
    <div class="mb-3"><label class="form-label">Título</label><input name="titulo" class="form-control" value="<%= p != null ? p.getTitulo() : "" %>" required></div>
    <div class="mb-3"><label class="form-label">Descripción</label><textarea name="descripcion" class="form-control"><%= p != null ? p.getDescripcion() : "" %></textarea></div>
    <div class="row">
      <div class="col"><label class="form-label">Precio</label><input name="precio" type="number" step="0.01" class="form-control" value="<%= p != null && p.getPrecio() != null ? p.getPrecio() : "" %>" required></div>
      <div class="col"><label class="form-label">Duración (días)</label><input name="duracionDias" type="number" class="form-control" value="<%= p != null ? p.getDuracionDias() : "" %>"></div>
    </div>
    <div class="form-check mt-2"><input class="form-check-input" type="checkbox" name="disponible" <%= p != null && p.isDisponible() ? "checked" : "" %> ><label class="form-check-label">Disponible</label></div>
    <button class="btn btn-primary mt-3">Guardar</button>
    <a class="btn btn-secondary mt-3" href="${pageContext.request.contextPath}/paquetes">Cancelar</a>
  </form>
</div>
</body>
</html>