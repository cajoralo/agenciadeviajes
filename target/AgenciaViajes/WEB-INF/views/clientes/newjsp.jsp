<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Cliente" %>
<!DOCTYPE html>
<html><head><meta charset="utf-8"><title>Clientes</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"></head>
<body><div class="container mt-4">
  <div class="d-flex justify-content-between">
    <h3>Clientes</h3>
    <a class="btn btn-success" href="${pageContext.request.contextPath}/clientes?action=nuevo">Nuevo Cliente</a>
  </div>
  <table class="table table-striped mt-3">
    <thead><tr><th>ID</th><th>Nombre</th><th>Email</th><th>Teléfono</th><th>Dirección</th><th>Acciones</th></tr></thead>
    <tbody>
      <%
        List<Cliente> lista = (List<Cliente>) request.getAttribute("clientes");
        if (lista != null) {
          for (Cliente c : lista) {
      %>
      <tr>
        <td><%= c.getId() %></td>
        <td><%= c.getNombre() %></td>
        <td><%= c.getEmail() %></td>
        <td><%= c.getTelefono() %></td>
        <td><%= c.getDireccion() %></td>
        <td>
          <a class="btn btn-sm btn-primary" href="${pageContext.request.contextPath}/clientes?action=editar&id=<%=c.getId()%>">Editar</a>
          <a class="btn btn-sm btn-danger" href="${pageContext.request.contextPath}/clientes?action=eliminar&id=<%=c.getId()%>" onclick="return confirm('Eliminar?')">Eliminar</a>
        </td>
      </tr>
      <%
          }
        }
      %>
    </tbody>
  </table>
  <a class="btn btn-link" href="${pageContext.request.contextPath}/paquetes">Ver Paquetes</a>
</div>
</body>
</html>
