<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="model.Reserva, model.Cliente, model.Paquete" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Reservas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .table-container {
            background: #ffffff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }
        .table-hover tbody tr:hover {
            background-color: #f7faff !important;
            cursor: pointer;
        }
        .badge-id {
            background-color: #0d6efd;
            padding: 6px 10px;
            font-size: 0.75rem;
        }
        .badge-estado {
            font-size: 0.75rem;
        }
        .badge-estado-CONFIRMADA {
            background-color: #198754;
        }
        .badge-estado-PENDIENTE {
            background-color: #ffc107;
            color: #000;
        }
        .badge-estado-CANCELADA {
            background-color: #dc3545;
        }
    </style>
</head>
<body>
<div class="container mt-4">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3>Reservas</h3>
        <div>
            <a class="btn btn-outline-secondary me-2"
               href="${pageContext.request.contextPath}/index.jsp">
                ⬅ Volver al inicio
            </a>
            <a class="btn btn-success"
               href="${pageContext.request.contextPath}/reservas?action=nueva">
                ➕ Nueva Reserva
            </a>
        </div>
    </div>

    <div class="table-responsive table-container">
        <table class="table table-striped table-hover align-middle">
            <thead class="table-light">
            <tr>
                <th>ID</th>
                <th>Cliente</th>
                <th>Paquete</th>
                <th>Fecha</th>
                <th>Personas</th>
                <th>Precio / persona</th>
                <th>Total</th>
                <th>Estado</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<Reserva> reservas = (List<Reserva>) request.getAttribute("reservas");
                List<Cliente> clientes = (List<Cliente>) request.getAttribute("clientes");
                List<Paquete> paquetes = (List<Paquete>) request.getAttribute("paquetes");

                if (reservas != null && !reservas.isEmpty()) {
                    for (Reserva r : reservas) {

                        Cliente cli = null;
                        if (clientes != null) {
                            for (Cliente c : clientes) {
                                if (c.getId() == r.getClienteId()) {
                                    cli = c;
                                    break;
                                }
                            }
                        }

                        Paquete paq = null;
                        if (paquetes != null) {
                            for (Paquete p : paquetes) {
                                if (p.getId() == r.getPaqueteId()) {
                                    paq = p;
                                    break;
                                }
                            }
                        }

                        BigDecimal precio = BigDecimal.ZERO;
                        if (paq != null && paq.getPrecio() != null) {
                            precio = paq.getPrecio();
                        }
                        BigDecimal total = precio.multiply(new BigDecimal(r.getNumeroPersonas()));
            %>
            <tr>
                <td>
                    <span class="badge badge-id">#<%= r.getId() %></span>
                </td>
                <td>
                    <%= (cli != null ? cli.getNombre() : ("ID " + r.getClienteId())) %>
                </td>
                <td>
                    <%= (paq != null ? paq.getNombre() : ("ID " + r.getPaqueteId())) %>
                </td>
                <td><%= r.getFechaReserva() != null ? r.getFechaReserva().toString() : "" %></td>
                <td><%= r.getNumeroPersonas() %></td>
                <td>
                    <% if (precio != null) { %>
                        $<%= precio.setScale(2, BigDecimal.ROUND_HALF_UP).toString() %>
                    <% } else { %>
                        -
                    <% } %>
                </td>
                <td>
                    <% if (precio != null) { %>
                        $<%= total.setScale(2, BigDecimal.ROUND_HALF_UP).toString() %>
                    <% } else { %>
                        -
                    <% } %>
                </td>
                <td>
                    <%
                        String estado = r.getEstado() != null ? r.getEstado() : "";
                        String claseEstado = "badge-estado " +
                                ("CONFIRMADA".equals(estado) ? "badge-estado-CONFIRMADA" :
                                 "PENDIENTE".equals(estado)  ? "badge-estado-PENDIENTE" :
                                 "CANCELADA".equals(estado)  ? "badge-estado-CANCELADA" : "");
                    %>
                    <span class="badge <%= claseEstado %>"><%= estado %></span>
                </td>
                <td>
                    <a class="btn btn-sm btn-primary"
                       href="${pageContext.request.contextPath}/reservas?action=editar&id=<%= r.getId() %>">
                        ✏ Editar
                    </a>
                    <a class="btn btn-sm btn-danger"
                       href="${pageContext.request.contextPath}/reservas?action=eliminar&id=<%= r.getId() %>"
                       onclick="return confirm('¿Seguro que quieres eliminar esta reserva?');">
                        🗑 Eliminar
                    </a>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="9" class="text-center text-muted py-4">
                    😕 No hay reservas registradas todavía.
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>

</div>
</body>
</html>
