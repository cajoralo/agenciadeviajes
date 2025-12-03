<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Cliente" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Clientes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        /* Responsive: tabla como tarjetas en móvil */
        @media (max-width: 768px) {
            table thead {
                display: none;
            }
            table tbody tr {
                display: block;
                margin-bottom: 1rem;
                border: 1px solid #dee2e6;
                border-radius: .5rem;
                padding: .5rem .75rem;
            }
            table tbody tr td {
                display: flex;
                justify-content: space-between;
                padding: .25rem .5rem;
            }
            table tbody tr td::before {
                content: attr(data-label);
                font-weight: 600;
                margin-right: .5rem;
                color: #6c757d;
            }
        }

        th.sortable {
            cursor: pointer;
        }
        th.sortable::after {
            content: " ↕";
            font-size: 0.75rem;
            color: #6c757d;
        }
        /* Sombra y bordes suaves de la tabla */
.table-container {
    background: white;
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.05);
}

/* Fila resaltada al pasar mouse */
.table-hover tbody tr:hover {
    background-color: #f7faff !important;
    cursor: pointer;
}

/* IDs como etiqueta */
.badge-id {
    background-color: #0d6efd;
    padding: 6px 10px;
    font-size: 0.75rem;
}

/* Teléfonos como etiqueta */
.badge-tel {
    background-color: #6c757d;
    padding: 6px 10px;
    font-size: 0.75rem;
}

/* Cabeceras más elegantes */
.table thead th {
    font-weight: 600;
    color: #495057;
    background-color: #f1f3f5 !important;
}

/* Contador inferior */
.page-info {
    font-size: 0.95rem;
    color: #6c757d;
    font-style: italic;
    margin-top: 10px;
}

    </style>
</head>
<body>
<div class="container mt-4">

    <%-- Mensajes de feedback --%>
    <%
        String msg = request.getParameter("msg");
        if ("creado".equals(msg)) {
    %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ✅ Cliente creado correctamente.
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <%
        } else if ("editado".equals(msg)) {
    %>
        <div class="alert alert-info alert-dismissible fade show" role="alert">
            ✏️ Cliente actualizado correctamente.
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <%
        } else if ("eliminado".equals(msg)) {
    %>
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            🗑️ Cliente eliminado.
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <%
        }
    %>

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3>Clientes</h3>
        <div>
            <a class="btn btn-success" href="${pageContext.request.contextPath}/clientes?action=nuevo">
                ➕ Nuevo Cliente
            </a>
            <a class="btn btn-link" href="${pageContext.request.contextPath}/paquetes">Paquetes</a>
            <a class="btn btn-link" href="${pageContext.request.contextPath}/reservas">Reservas</a>
        </div>
    </div>

    <%-- Buscador + tamaño de página --%>
    <div class="row mb-3">
        <div class="col-md-6 mb-2">
            <input id="searchInput" type="text" class="form-control" placeholder="Buscar por nombre o email...">
        </div>
        <div class="col-md-3 mb-2">
            <select id="rowsPerPage" class="form-select">
                <option value="5">5 por página</option>
                <option value="10" selected>10 por página</option>
                <option value="20">20 por página</option>
                <option value="50">50 por página</option>
            </select>
        </div>
    </div>

    <div class="table-responsive table-container">
    <table id="tablaClientes" class="table table-striped table-hover align-middle">
            <thead class="table-light">
            <tr>
                <th class="sortable" data-col="id">ID</th>
                <th class="sortable" data-col="nombre">Nombre</th>
                <th class="sortable" data-col="email">Email</th>
                <th class="sortable" data-col="telefono">Teléfono</th>
                <th class="sortable" data-col="direccion">Dirección</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<Cliente> lista = (List<Cliente>) request.getAttribute("clientes");
                if (lista != null) {
                    for (Cliente c : lista) {
            %>
            <tr>
                <td data-label="ID">
    <span class="badge badge-id">#<%= c.getId() %></span>
</td>

                <td data-label="Nombre" data-col="nombre"><%= c.getNombre() %></td>
                <td data-label="Email" data-col="email"><%= c.getEmail() %></td>
                <td data-label="Teléfono">
    <span class="badge badge-tel"><%= c.getTelefono() %></span>
</td>

                <td data-label="Dirección" data-col="direccion"><%= c.getDireccion() %></td>
                <td data-label="Acciones">
                    <a class="btn btn-sm btn-outline-secondary mb-1"
                       href="${pageContext.request.contextPath}/clientes?action=editar&id=<%= c.getId() %>">
                        👁 Ver
                    </a>
                    <a class="btn btn-sm btn-primary mb-1"
                       href="${pageContext.request.contextPath}/clientes?action=editar&id=<%= c.getId() %>">
                        ✏️ Editar
                    </a>
                    <button type="button"
                            class="btn btn-sm btn-outline-danger mb-1"
                            data-bs-toggle="modal"
                            data-bs-target="#modalEliminar"
                            data-id="<%= c.getId() %>"
                            data-nombre="<%= c.getNombre() %>">
                        🗑 Eliminar
                    </button>
                </td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>
    </div>

    <%-- Paginación --%>
    <div class="d-flex justify-content-between align-items-center mt-2">
        <div id="pageInfo" class="page-info"></div>
        <nav>
            <ul class="pagination mb-0">
                <li class="page-item">
                    <button class="page-link" id="prevPage">Anterior</button>
                </li>
                <li class="page-item">
                    <button class="page-link" id="nextPage">Siguiente</button>
                </li>
            </ul>
        </nav>
    </div>

</div>

<%-- Modal confirmar eliminación --%>
<div class="modal fade" id="modalEliminar" tabindex="-1" aria-labelledby="modalEliminarLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title" id="modalEliminarLabel">Confirmar eliminación</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <div class="modal-body">
                 <p id="textoEliminar">¿Seguro que deseas eliminar al cliente?</p>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <a id="btnConfirmarEliminar" href="#" class="btn btn-danger">Eliminar</a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // ==== BÚSQUEDA + PAGINACIÓN + ORDEN ====
    const tabla = document.getElementById('tablaClientes');
    const tbody = tabla.querySelector('tbody');
    const searchInput = document.getElementById('searchInput');
    const rowsPerPageSelect = document.getElementById('rowsPerPage');
    const pageInfo = document.getElementById('pageInfo');
    const prevPageBtn = document.getElementById('prevPage');
    const nextPageBtn = document.getElementById('nextPage');

    let allRows = Array.from(tbody.querySelectorAll('tr'));
    let filteredRows = [...allRows];
    let currentPage = 1;
    let rowsPerPage = parseInt(rowsPerPageSelect.value, 10);
    let currentSortCol = null;
    let sortAsc = true;

   function renderTable() {
    tbody.innerHTML = '';

    const total = filteredRows.length;
    const start = (currentPage - 1) * rowsPerPage;
    const end = start + rowsPerPage;
    const pageRows = filteredRows.slice(start, end);

    // === SI NO HAY REGISTROS: MOSTRAR MENSAJE ===
    if (total === 0) {
        tbody.innerHTML = `
            <tr>
                <td colspan="6" class="text-center py-4 text-muted">
                    😕 No hay clientes registrados.
                </td>
            </tr>
        `;
        pageInfo.textContent = "";
        prevPageBtn.disabled = true;
        nextPageBtn.disabled = true;
        return;
    }

    // === SI HAY REGISTROS: MOSTRAR NORMAL ===
    pageRows.forEach(row => tbody.appendChild(row));

    const from = start + 1;
    const to = Math.min(end, total);

    pageInfo.textContent = `Mostrando ${from}-${to} de ${total} clientes`;

    prevPageBtn.disabled = currentPage === 1;
    nextPageBtn.disabled = end >= total;
}


    function applyFilter() {
        const term = searchInput.value.toLowerCase();
        filteredRows = allRows.filter(row => {
            const nombre = row.querySelector('[data-col="nombre"]').textContent.toLowerCase();
            const email = row.querySelector('[data-col="email"]').textContent.toLowerCase();
            return nombre.includes(term) || email.includes(term);
        });
        currentPage = 1;
        renderTable();
    }

    function applySort(col) {
        if (currentSortCol === col) {
            sortAsc = !sortAsc;
        } else {
            currentSortCol = col;
            sortAsc = true;
        }

        filteredRows.sort((a, b) => {
            const aText = a.querySelector('[data-col="' + col + '"]').textContent.trim().toLowerCase();
            const bText = b.querySelector('[data-col="' + col + '"]').textContent.trim().toLowerCase();

            if (!isNaN(aText) && !isNaN(bText)) {
                return sortAsc ? (Number(aText) - Number(bText)) : (Number(bText) - Number(aText));
            }

            if (aText < bText) return sortAsc ? -1 : 1;
            if (aText > bText) return sortAsc ? 1 : -1;
            return 0;
        });

        currentPage = 1;
        renderTable();
    }

    searchInput.addEventListener('input', applyFilter);
    rowsPerPageSelect.addEventListener('change', () => {
        rowsPerPage = parseInt(rowsPerPageSelect.value, 10);
        currentPage = 1;
        renderTable();
    });
    prevPageBtn.addEventListener('click', () => {
        if (currentPage > 1) {
            currentPage--;
            renderTable();
        }
    });
    nextPageBtn.addEventListener('click', () => {
        const maxPage = Math.ceil(filteredRows.length / rowsPerPage);
        if (currentPage < maxPage) {
            currentPage++;
            renderTable();
        }
    });

    document.querySelectorAll('th.sortable').forEach(th => {
        th.addEventListener('click', () => {
            const col = th.getAttribute('data-col');
            applySort(col);
        });
    });

    // ==== MODAL ELIMINAR ====
    const modalEliminarEl = document.getElementById('modalEliminar');
    const textoEliminar = document.getElementById('textoEliminar');
    const btnConfirmarEliminar = document.getElementById('btnConfirmarEliminar');
    const contextPath = '<%= request.getContextPath() %>';

    modalEliminarEl.addEventListener('show.bs.modal', event => {
        const button = event.relatedTarget;
        const id = button.getAttribute('data-id');
        const nombre = button.getAttribute('data-nombre');

        textoEliminar.textContent =
            `¿Seguro que deseas eliminar al cliente? Esta acción no se puede deshacer.`;

        btnConfirmarEliminar.href = contextPath + '/clientes?action=eliminar&id=' + id;
    });

    // Inicializar tabla
    renderTable();
</script>
</body>
</html>
