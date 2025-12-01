<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Recuperar contraseña</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome (iconos) -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            min-height: 100vh;
            background: radial-gradient(circle at top, #1f2933 0%, #020617 55%);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .recovery-card {
            border-radius: 20px;
            overflow: hidden;
            background: rgba(15, 23, 42, 0.9);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.5);
            color: #e5e7eb;
        }

        .recovery-header {
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 50%, #0ea5e9 100%);
            color: #fff;
            padding: 20px;
            text-align: center;
        }

        .recovery-header h4 {
            margin: 0;
            font-weight: 700;
        }

        .recovery-header small {
            opacity: 0.9;
        }

        .brand-circle {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: rgba(15, 23, 42, 0.25);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 8px;
        }

        .brand-circle i {
            font-size: 1.9rem;
        }

        .recovery-body {
            padding: 22px 24px 24px;
        }

        .form-control {
            border-radius: 10px;
            background-color: #0b1120;
            border: 1px solid #1f2937;
            color: #e5e7eb;
        }

        .form-control:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 0.15rem rgba(59, 130, 246, 0.35);
            background-color: #020617;
            color: #f9fafb;
        }

        .btn-primary,
        .btn-success,
        .btn-warning {
            border-radius: 10px;
            font-weight: 600;
        }

        .card-footer {
            background: #ffffff;
            color: #111827;
        }

        .card-footer a {
            color: #2563eb;
        }

        .card-footer a:hover {
            color: #1d4ed8;
        }
    </style>
</head>
<body>

<%
    String usernameAttr   = (String) request.getAttribute("username");
    String pregunta       = (String) request.getAttribute("pregunta");
    String mensajeError   = (String) request.getAttribute("mensajeError");
    String mensajeExito   = (String) request.getAttribute("mensajeExito");
%>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5">

            <div class="card recovery-card">

                <!-- HEADER -->
                <div class="recovery-header">
                    <div class="brand-circle">
                        <i class="fas fa-key"></i>
                    </div>
                    <h4>Recuperar contraseña</h4>
                    <small>Sistema de Agencia de Viajes</small>
                </div>

                <!-- BODY -->
                <div class="recovery-body">

                    <!-- Mensajes del servidor -->
                    <% if (mensajeError != null) { %>
                        <div class="alert alert-danger py-2" role="alert">
                            <i class="fas fa-exclamation-circle"></i> <%= mensajeError %>
                        </div>
                    <% } else if (mensajeExito != null) { %>
                        <div class="alert alert-success py-2" role="alert">
                            <i class="fas fa-check-circle"></i> <%= mensajeExito %>
                        </div>
                    <% } %>

                    <!-- 1er formulario: buscar usuario y mostrar pregunta -->
                    <form action="recuperarPassword" method="post" class="mb-3">
                        <input type="hidden" name="accion" value="buscar">

                        <div class="mb-3">
                            <label class="form-label">Usuario</label>
                            <input type="text"
                                   name="username"
                                   class="form-control"
                                   required
                                   value="<%= usernameAttr != null ? usernameAttr : "" %>">
                        </div>

                        <button type="submit" class="btn btn-warning w-100">
                            <i class="fas fa-search"></i> Buscar pregunta
                        </button>
                    </form>

                    <% if (pregunta != null) { %>
                    <!-- 2do formulario: responder y poner nueva contraseña -->
                    <hr class="border-secondary">

                    <form action="recuperarPassword" method="post">
                        <input type="hidden" name="accion" value="restablecer">
                        <input type="hidden" name="username"
                               value="<%= usernameAttr != null ? usernameAttr : "" %>">

                        <div class="mb-3">
                            <label class="form-label">Pregunta de seguridad</label>
                            <input type="text"
                                   class="form-control"
                                   value="<%= pregunta %>"
                                   readonly>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Respuesta</label>
                            <input type="text"
                                   name="respuesta"
                                   class="form-control"
                                   required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Nueva contraseña</label>
                            <input type="password"
                                   name="nuevaPassword"
                                   class="form-control"
                                   required>
                        </div>

                        <button type="submit" class="btn btn-success w-100">
                            <i class="fas fa-unlock-alt"></i> Restablecer contraseña
                        </button>
                    </form>
                    <% } %>
                </div>

                <!-- FOOTER -->
                <div class="card-footer text-center small">
                    <a href="login.jsp" class="text-decoration-none">
                        ← Volver al login
                    </a>
                </div>

            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
