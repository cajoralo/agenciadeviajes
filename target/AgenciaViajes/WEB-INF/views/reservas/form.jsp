<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Reserva, model.Cliente, model.Paquete" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Reserva</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
  <h3><%= request.getAttribute("reserva") == null ? "Nueva Reserva" : "Editar Reserva" %></h3>
  <%
    Reserva r = (Reserva) request.getAttribute("reserva");
    List<Cliente> clientes = (List<Cliente>) request.getAttribute("clientes");
    List<Paquete> paquetes = (List<Paquete>) request.getAttribute("paquetes");
  %>
  <form method="post" action="${pageContext.request.contextPath}/reservas">
    <input type="hidden" name="id" value="<%= r != null ? r.getId() : "" %>">

    <div class="mb-3">
      <label class="form-label">Cliente</label>
      <select name="clienteId" class="form-select" required>
        <option value="">-- Seleccione cliente --</option>
        <%
          if (clientes != null) {
            for (Cliente c : clientes) {
        %>
          <option value="<%= c.getId() %>"
                  <%= r != null && r.getClienteId() == c.getId() ? "selected" : "" %>>
            <%= c.getNombre() %> - <%= c.getEmail() %>
          </option>
        <%
            }
          }
        %>
      </select>
    </div>

    <div class="mb-3">
      <label class="form-label">Paquete</label>
      <select name="paqueteId" class="form-select" required>
        <option value="">-- Seleccione paquete --</option>
        <%
          if (paquetes != null) {
            for (Paquete p : paquetes) {
        %>
          <option value="<%= p.getId() %>"
                  <%= r != null && r.getPaqueteId() == p.getId() ? "selected" : "" %>>
            <%= p.getNombre() %> - $<%= p.getPrecio() %>
          </option>
        <%
            }
          }
        %>
      </select>
    </div>

    <div class="row">
      <div class="col-md-4 mb-3">
        <label class="form-label">Fecha</label>
        <input type="date" name="fechaReserva" class="form-control"
               value="<%= r != null && r.getFechaReserva() != null ? r.getFechaReserva().toString() : "" %>"
               required>
      </div>
      <div class="col-md-4 mb-3">
        <label class="form-label">Personas</label>
        <input type="number" min="1" name="numeroPersonas" class="form-control"
               value="<%= r != null ? r.getNumeroPersonas() : 1 %>">
      </div>
      <div class="col-md-4 mb-3">
        <label class="form-label">Estado</label>
        <select name="estado" class="form-select">
          <option value="CONFIRMADA" <%= r != null && "CONFIRMADA".equals(r.getEstado()) ? "selected" : "" %>>CONFIRMADA</option>
          <option value="PENDIENTE"  <%= r != null && "PENDIENTE".equals(r.getEstado())  ? "selected" : "" %>>PENDIENTE</option>
          <option value="CANCELADA"  <%= r != null && "CANCELADA".equals(r.getEstado())  ? "selected" : "" %>>CANCELADA</option>
        </select>
      </div>
    </div>

    <button class="btn btn-primary mt-2">Guardar</button>
    <a class="btn btn-secondary mt-2" href="${pageContext.request.contextPath}/index.jsp">Cancelar</a>
  </form>
</div>
</body>
</html>
