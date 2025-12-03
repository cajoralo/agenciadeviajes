<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Usuario" %>

<%
    Usuario u = (Usuario) session.getAttribute("usuarioLogueado");
    if (u == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cambiar contraseña</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            min-height: 100vh;
            background: radial-gradient(circle at top, #1f2933 0%, #020617 55%);
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .card-custom {
            width: 480px;
            border-radius: 20px;
            background: rgba(15, 23, 42, 0.9);
            color: #e5e7eb;
            box-shadow: 0 20px 40px rgba(0,0,0,0.6);
            overflow: hidden;
        }

        .card-header-custom {
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 50%, #0ea5e9 100%);
            padding: 30px;
            text-align: center;
            color: white;
        }

        .header-icon {
            font-size: 3.2rem;
            margin-bottom: 8px;
        }

        .input-dark {
            background-color: #0b1120;
            border: 1px solid #1f2937;
            color: #e5e7eb;
            border-radius: 10px;
        }

        .input-dark:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 0.15rem rgba(59,130,246,0.35);
            background-color: #020617;
        }

        .toggle-btn i {
            font-size: 1.1rem;
            color: #a1a1aa;
        }

        .toggle-btn:hover i {
            color: #fff;
        }

        .card-footer-custom {
            background: #ffffff;
            color: #111827;
            font-weight: 600;
            padding: 10px 0;
            text-align: center;
        }

        a.text-link {
            color: #60a5fa;
            text-decoration: none;
        }

        a.text-link:hover {
            color: #93c5fd;
        }
    </style>

</head>
<body>

<div class="card card-custom">

    <!-- HEADER -->
    <div class="card-header-custom">
        <i class="fas fa-lock header-icon"></i>
        <h3 class="fw-bold">Cambiar contraseña</h3>
        <small>Sistema de Agencia de Viajes</small>
    </div>

    <!-- BODY -->
    <div class="card-body p-4">

        <p class="mb-3">
            Usuario: <strong><%= u.getNombre() + " " + u.getApellido() %></strong>
        </p>

        <!-- FORM -->
        <form id="formCambiarPass" action="cambiarPassword" method="post">

            <!-- Contraseña actual -->
            <div class="mb-3">
                <label class="form-label">Contraseña actual</label>
                <div class="input-group">
                    <input type="password" name="passwordActual" id="passActual"
                           class="form-control input-dark" required>
                    <button type="button" class="btn btn-outline-secondary toggle-btn"
                            data-target="passActual">
                        <i class="fas fa-eye"></i>
                    </button>
                </div>
            </div>

            <!-- Nueva contraseña -->
            <div class="mb-3">
                <label class="form-label">Nueva contraseña</label>
                <div class="input-group">
                    <input type="password" name="passwordNueva" id="passNueva"
                           class="form-control input-dark" required>
                    <button type="button" class="btn btn-outline-secondary toggle-btn"
                            data-target="passNueva">
                        <i class="fas fa-eye"></i>
                    </button>
                </div>
            </div>

            <!-- Confirmar nueva -->
            <div class="mb-3">
                <label class="form-label">Confirmar nueva contraseña</label>
                <div class="input-group">
                    <input type="password" name="passwordConfirmar" id="passConfirmar"
                           class="form-control input-dark" required>
                    <button type="button" class="btn btn-outline-secondary toggle-btn"
                            data-target="passConfirmar">
                        <i class="fas fa-eye"></i>
                    </button>
                </div>
            </div>

            <button type="button"
                    class="btn btn-info w-100 mt-2"
                    data-bs-toggle="modal"
                    data-bs-target="#confirmarCambioModal">
                Guardar cambios
            </button>
        </form>

        <!-- MENSAJES -->
        <%
            String mensajeError = (String) request.getAttribute("mensajeError");
            String mensajeExito = (String) request.getAttribute("mensajeExito");

            if (mensajeError != null) {
        %>
            <div class="alert alert-danger mt-3"><%= mensajeError %></div>

        <% } else if (mensajeExito != null) { %>

        <!-- MODAL ÉXITO -->
        <div class="modal fade" id="exitoModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">

                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title">Éxito</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body text-center">
                        <i class="fas fa-check-circle text-success" style="font-size: 3rem;"></i>
                        <p class="mt-3"><%= mensajeExito %></p>
                    </div>

                    <div class="modal-footer">
                        <a href="login.jsp" class="btn btn-success w-100">Aceptar</a>
                    </div>

                </div>
            </div>
        </div>

        <script>
            window.onload = function() {
                var myModal = new bootstrap.Modal(document.getElementById('exitoModal'));
                myModal.show();
            };
        </script>

        <% } %>

    </div>

    <!-- FOOTER -->
    <div class="card-footer-custom">
        <a href="index.jsp" class="text-link">← Volver a la página principal</a>
    </div>

</div>


<!-- MODAL CONFIRMAR CAMBIO -->
<div class="modal fade" id="confirmarCambioModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title">Confirmar cambio</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">
                ¿Está seguro de cambiar su contraseña?
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                <button type="submit" class="btn btn-info" form="formCambiarPass">Sí, cambiar</button>
            </div>

        </div>
    </div>
</div>


<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- TOGGLE PASSWORD SCRIPT -->
<script>
document.querySelectorAll(".toggle-btn").forEach(btn => {
    btn.addEventListener("click", () => {
        const id = btn.getAttribute("data-target");
        const input = document.getElementById(id);

        const isPass = input.type === "password";
        input.type = isPass ? "text" : "password";

        btn.innerHTML = isPass
            ? '<i class="fas fa-eye-slash"></i>'
            : '<i class="fas fa-eye"></i>';
    });
});
</script>

</body>
</html>
