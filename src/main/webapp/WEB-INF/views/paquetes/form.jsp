<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Paquete" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Paquete</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">

  <%
    Paquete p = (Paquete) request.getAttribute("paquete");
    boolean esNuevo = (p == null);
  %>

  <h3><%= esNuevo ? "Nuevo Paquete" : "Editar Paquete" %></h3>

  <form method="post" action="${pageContext.request.contextPath}/paquetes">
    <input type="hidden" name="id" value="<%= !esNuevo ? p.getId() : "" %>">

    <div class="mb-3">
      <label class="form-label">Nombre</label>
      <input name="nombre" class="form-control"
             value="<%= !esNuevo ? p.getNombre() : "" %>" required>
    </div>

    <div class="mb-3">
      <label class="form-label">Destino</label>
      <input name="destino" class="form-control"
             value="<%= !esNuevo ? p.getDestino() : "" %>" required>
    </div>

    <div class="mb-3">
      <label class="form-label">Precio</label>
      <input name="precio" type="number" step="0.01" min="0"
             class="form-control"
             value="<%= !esNuevo && p.getPrecio() != null ? p.getPrecio() : "" %>" required>
    </div>

    <div class="mb-3">
      <label class="form-label">Duración (días)</label>
      <input name="duracionDias" type="number" min="1"
             class="form-control"
             value="<%= !esNuevo ? p.getDuracionDias() : 1 %>">
    </div>

    <div class="mb-3">
      <label class="form-label">Imagen (URL)</label>
      <input name="imagenUrl" class="form-control"
             value="<%= !esNuevo ? p.getImagenUrl() : "" %>">
    </div>

    <div class="mb-3">
      <label class="form-label">Descripción</label>
      <textarea name="descripcion" class="form-control" rows="3"><%= !esNuevo && p.getDescripcion() != null ? p.getDescripcion() : "" %></textarea>
    </div>

    <div class="form-check mb-3">
      <input class="form-check-input" type="checkbox" name="disponible"
             id="chkDisponible"
             <%= !esNuevo && p.isDisponible() ? "checked" : "" %>>
      <label class="form-check-label" for="chkDisponible">
        Disponible
      </label>
    </div>

    <button class="btn btn-primary">Guardar</button>
    <a class="btn btn-secondary" href="${pageContext.request.contextPath}/paquetes">Cancelar</a>
  </form>

</div>
</body>
</html>
