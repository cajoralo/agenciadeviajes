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

  <h3><%= request.getAttribute("paquete") == null ? "Nuevo Paquete" : "Editar Paquete" %></h3>

  <%
    Paquete p = (Paquete) request.getAttribute("paquete");
  %>

  <form method="post" action="${pageContext.request.contextPath}/paquetes">
    <input type="hidden" name="id" value="<%= p != null ? p.getId() : "" %>">

    <!-- NOMBRE DEL PAQUETE (antes decía Título y usaba getTitulo()) -->
    <div class="mb-3">
      <label class="form-label">Nombre</label>
      <input name="nombre" class="form-control" value="<%= p != null ? p.getNombre() : "" %>" required>
    </div>

    <div class="mb-3">
      <label class="form-label">Descripción</label>
      <textarea name="descripcion" class="form-control"><%= p != null ? p.getDescripcion() : "" %></textarea>
    </div>

    <div class="row">
      <div class="col">
        <label class="form-label">Precio</label>
        <input name="precio" type="number" step="0.01" class="form-control"
               value="<%= p != null && p.getPrecio() != null ? p.getPrecio() : "" %>" required>
      </div>

      <div class="col">
        <label class="form-label">Duración (días)</label>
        <input name="duracionDias" type="number" class="form-control"
               value="<%= p != null ? p.getDuracionDias() : "" %>" required>
      </div>
    </div>

    <div class="mb-3 mt-3">
      <label class="form-label">Destino</label>
      <input name="destino" class="form-control"
             value="<%= p != null ? p.getDestino() : "" %>" required>
    </div>

    <div class="mb-3">
      <label class="form-label">Imagen (URL)</label>
      <input name="imagenUrl" class="form-control"
             value="<%= p != null ? p.getImagenUrl() : "" %>">
    </div>

    <div class="mb-3">
      <label class="form-label">Disponible</label>
      <select name="disponible" class="form-select">
        <option value="true" <%= p != null && p.isDisponible() ? "selected" : "" %>>Sí</option>
        <option value="false" <%= p != null && !p.isDisponible() ? "selected" : "" %>>No</option>
      </select>
    </div>

    <button class="btn btn-primary">Guardar</button>
    <a class="btn btn-secondary" href="${pageContext.request.contextPath}/index.jsp">Cancelar</a>

  </form>

</div>
</body>
</html>

