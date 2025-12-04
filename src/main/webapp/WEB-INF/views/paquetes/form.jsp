<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Paquete" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Paquete</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f5f5f9;
        }
        .page-title {
            font-weight: 600;
        }
        .card-form {
            border-radius: 14px;
            box-shadow: 0 8px 20px rgba(0,0,0,.06);
        }
        .card-header {
            border-radius: 14px 14px 0 0 !important;
        }
        .preview-card {
            border-radius: 14px;
        }
        .badge-dias {
            background-color: #0d6efd;
        }
        .badge-precio {
            background-color: #198754;
        }
    </style>
</head>

<body>
<div class="container mt-4 mb-4">

    <%
        Paquete p = (Paquete) request.getAttribute("paquete");
        boolean editando = (p != null);
    %>

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 class="page-title">
            <%= editando ? "Editar Paquete" : "Nuevo Paquete" %>
        </h3>
        <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-outline-secondary btn-sm">
            ⬅ Volver al inicio
        </a>
    </div>

    <div class="row g-4">
        <!-- FORMULARIO -->
        <div class="col-lg-8">
            <div class="card card-form">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><%= editando ? "Datos del paquete" : "Registra un nuevo paquete" %></h5>
                </div>
                <div class="card-body">
                    <form method="post" action="${pageContext.request.contextPath}/paquetes">
                        <input type="hidden" name="id" value="<%= editando ? p.getId() : "" %>">

                        <!-- NOMBRE -->
                        <div class="mb-3">
                            <label class="form-label">Nombre</label>
                            <input
                                name="nombre"
                                class="form-control"
                                placeholder="Ej: Tour Galápagos 5 días / 4 noches"
                                value="<%= editando ? p.getNombre() : "" %>"
                                required>
                            <small class="text-muted">Nombre comercial del paquete que verá el cliente.</small>
                        </div>

                        <!-- DESCRIPCIÓN -->
                        <div class="mb-3">
                            <label class="form-label">Descripción</label>
                            <textarea
                                name="descripcion"
                                class="form-control"
                                rows="3"
                                placeholder="Describe qué incluye el paquete (alojamiento, alimentación, tours, etc.)"><%= editando && p.getDescripcion() != null ? p.getDescripcion() : "" %></textarea>
                        </div>

                        <!-- PRECIO + DURACIÓN -->
                        <div class="row mb-3">
                            <div class="col-md-6 mb-3 mb-md-0">
                                <label class="form-label">Precio (USD)</label>
                                <input
                                    name="precio"
                                    type="number"
                                    step="0.01"
                                    min="1"
                                    class="form-control"
                                    placeholder="Ej: 899.99"
                                    value="<%= editando && p.getPrecio() != null ? p.getPrecio() : "" %>"
                                    required>
                                <small class="text-muted">Precio total por persona.</small>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Duración (días)</label>
                                <input
                                    name="duracionDias"
                                    type="number"
                                    min="1"
                                    step="1"
                                    class="form-control"
                                    placeholder="Ej: 5"
                                    value="<%= editando ? p.getDuracionDias() : "" %>"
                                    required>
                                <small class="text-muted">Número de días del viaje.</small>
                            </div>
                        </div>

                        <!-- DESTINO -->
                        <div class="mb-3">
                            <label class="form-label">Destino</label>
                            <input
                                name="destino"
                                class="form-control"
                                placeholder="Ej: Galápagos, Ecuador"
                                value="<%= editando ? p.getDestino() : "" %>"
                                required>
                        </div>

                        <!-- IMAGEN -->
                        <div class="mb-3">
                            <label class="form-label">Imagen (URL)</label>
                            <input
                                id="imagenUrl"
                                name="imagenUrl"
                                class="form-control"
                                placeholder="https://tusitio.com/imagenes/galapagos.jpg"
                                value="<%= editando && p.getImagenUrl() != null ? p.getImagenUrl() : "" %>">
                            <small class="text-muted">Opcional: URL de una imagen promocional del paquete.</small>
                        </div>

                        <!-- DISPONIBLE -->
                        <div class="mb-3">
                            <label class="form-label">Disponible</label>
                            <select name="disponible" class="form-select">
                                <option value="true"  <%= editando && p.isDisponible()      ? "selected" : "" %>>Sí, disponible para la venta</option>
                                <option value="false" <%= editando && !p.isDisponible()     ? "selected" : "" %>>No disponible temporalmente</option>
                            </select>
                        </div>

                        <!-- BOTONES -->
                        <div class="d-flex justify-content-between mt-4">
                               <a href="${pageContext.request.contextPath}/index.jsp"
                                  class="btn btn-outline-secondary">
                                  ⬅ Volver al inicio
                               </a>

                            <div class="d-flex justify-content-end gap-2 mt-3">
    <!-- Botón GUARDAR (envía el formulario) -->
    <button type="submit" class="btn btn-primary">
        💾 Guardar
    </button>

    <!-- Botón para ir al INICIO -->
    <a class="btn btn-secondary"
       href="${pageContext.request.contextPath}/index.jsp">
        🏠 Inicio
    </a>
</div>

                        </div>

                    </form>
                </div>
            </div>
        </div>

        <!-- PREVISUALIZACIÓN -->
        <div class="col-lg-4">
            <div class="card preview-card shadow-sm">
                <div class="card-header bg-light">
                    <strong>Vista previa del paquete</strong>
                </div>
                <div class="card-body">
                    <div class="mb-3 text-center">
                        <img id="previewImg"
                             src="<%= editando && p.getImagenUrl() != null && !p.getImagenUrl().isEmpty() ? p.getImagenUrl() : "" %>"
                             class="img-fluid rounded border <%= editando && p.getImagenUrl() != null && !p.getImagenUrl().isEmpty() ? "" : "d-none" %>"
                             alt="Vista previa">
                    </div>

                    <h5 id="previewNombre"><%= editando ? p.getNombre() : "Nombre del paquete" %></h5>
                    <p class="text-muted mb-1" id="previewDestino">
                        <%= editando && p.getDestino() != null && !p.getDestino().isEmpty() ? p.getDestino() : "Destino" %>
                    </p>

                    <div class="mb-2">
                        <span class="badge badge-dias" id="previewDias">
                            <%= editando && p.getDuracionDias() > 0 ? p.getDuracionDias() + " días" : "Duración" %>
                        </span>
                        <span class="badge badge-precio ms-2" id="previewPrecio">
                            <%= editando && p.getPrecio() != null ? "$ " + p.getPrecio() : "Precio" %>
                        </span>
                    </div>

                    <p class="small text-muted" id="previewDescripcion">
                        <%= editando && p.getDescripcion() != null && !p.getDescripcion().isEmpty()
                                ? p.getDescripcion()
                                : "Aquí aparecerá un resumen de la descripción del paquete." %>
                    </p>

                    <div class="mt-2">
                        <span class="badge <%= editando && p.isDisponible() ? "bg-success" : "bg-secondary" %>" id="previewDisponible">
                            <%= editando
                                    ? (p.isDisponible() ? "Disponible" : "No disponible")
                                    : "Disponibilidad" %>
                        </span>
                    </div>
                </div>
            </div>
        </div>

    </div> <!-- row -->

</div> <!-- container -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // === PREVIEW EN VIVO ===
    const inputNombre   = document.querySelector('input[name="nombre"]');
    const inputDestino  = document.querySelector('input[name="destino"]');
    const inputPrecio   = document.querySelector('input[name="precio"]');
    const inputDias     = document.querySelector('input[name="duracionDias"]');
    const inputDesc     = document.querySelector('textarea[name="descripcion"]');
    const inputImg      = document.getElementById('imagenUrl');
    const selectDisp    = document.querySelector('select[name="disponible"]');

    const prevNombre    = document.getElementById('previewNombre');
    const prevDestino   = document.getElementById('previewDestino');
    const prevPrecio    = document.getElementById('previewPrecio');
    const prevDias      = document.getElementById('previewDias');
    const prevDesc      = document.getElementById('previewDescripcion');
    const prevImg       = document.getElementById('previewImg');
    const prevDisp      = document.getElementById('previewDisponible');

    if (inputNombre) {
        inputNombre.addEventListener('input', () => {
            prevNombre.textContent = inputNombre.value || 'Nombre del paquete';
        });
    }

    if (inputDestino) {
        inputDestino.addEventListener('input', () => {
            prevDestino.textContent = inputDestino.value || 'Destino';
        });
    }

    if (inputPrecio) {
        inputPrecio.addEventListener('input', () => {
            prevPrecio.textContent = inputPrecio.value
                ? '$ ' + inputPrecio.value
                : 'Precio';
        });
    }

    if (inputDias) {
        inputDias.addEventListener('input', () => {
            prevDias.textContent = inputDias.value
                ? inputDias.value + ' días'
                : 'Duración';
        });
    }

    if (inputDesc) {
        inputDesc.addEventListener('input', () => {
            prevDesc.textContent = inputDesc.value
                || 'Aquí aparecerá un resumen de la descripción del paquete.';
        });
    }

    if (inputImg) {
        inputImg.addEventListener('input', () => {
            const url = inputImg.value.trim();
            if (url) {
                prevImg.src = url;
                prevImg.classList.remove('d-none');
            } else {
                prevImg.classList.add('d-none');
            }
        });
    }

    if (selectDisp) {
        selectDisp.addEventListener('change', () => {
            if (selectDisp.value === 'true') {
                prevDisp.textContent = 'Disponible';
                prevDisp.className = 'badge bg-success';
            } else {
                prevDisp.textContent = 'No disponible';
                prevDisp.className = 'badge bg-secondary';
            }
        });
    }
</script>

</body>
</html>
