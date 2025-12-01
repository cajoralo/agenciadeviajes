<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Cliente" %>
<!DOCTYPE html>
<html><head><meta charset="utf-8"><title>Cliente</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"></head>
<body><div class="container mt-4">
  <h3><%= request.getAttribute("cliente") == null ? "Nuevo Cliente" : "Editar Cliente" %></h3>
  <%
    Cliente c = (Cliente) request.getAttribute("cliente");
  %>
  <form method="post" action="${pageContext.request.contextPath}/clientes">
    <input type="hidden" name="id" value="<%= c != null ? c.getId() : "" %>">
    <div class="mb-3"><label class="form-label">Nombre</label><input name="nombre" class="form-control" value="<%= c != null ? c.getNombre() : "" %>" required></div>
    <div class="mb-3"><label class="form-label">Email</label><input name="email" type="email" class="form-control" value="<%= c != null ? c.getEmail() : "" %>" required></div>
    <div class="mb-3"><label class="form-label">Teléfono</label><input name="telefono" class="form-control" value="<%= c != null ? c.getTelefono() : "" %>"></div>
    <div class="mb-3"><label class="form-label">Dirección</label><input name="direccion" class="form-control" value="<%= c != null ? c.getDireccion() : "" %>"></div>
    <button class="btn btn-primary">Guardar</button>
    <a class="btn btn-secondary" href="${pageContext.request.contextPath}/clientes">Cancelar</a>
  </form>
</div>
</body>
</html>