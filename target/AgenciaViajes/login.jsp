<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - Proyecto</title>

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

        .login-card {
            border-radius: 20px;
            overflow: hidden;
            background: rgba(15, 23, 42, 0.9);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.5);
            color: #e5e7eb;
        }

        .login-header {
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 50%, #0ea5e9 100%);
            color: #fff;
            padding: 20px;
            text-align: center;
        }

        .login-header h4 {
            margin: 0;
            font-weight: 700;
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

        .login-body {
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

        .input-group-text,
        .btn-outline-secondary {
            border-radius: 10px;
        }

        .btn-login {
            border-radius: 10px;
            font-weight: 600;
        }

        .caps-warning {
            font-size: 0.8rem;
            color: #f97316;
            display: none;
            margin-top: 4px;
        }

        .card-footer {
            border-top: 1px solid #111827;
        }

        .small-link a {
            color: #60a5fa;
        }

        .small-link a:hover {
            color: #93c5fd;
        }
        
        #dateTime {
            margin-top: 5px;
            font-size: 0.85rem;
            color: #f1f5f9;
            text-shadow: 0 1px 2px rgba(0,0,0,0.4);
        }
    </style>
</head>
<body>

<%
    String error = (String) request.getAttribute("mensajeError");
    String salida = (String) request.getAttribute("mensajeSalida");
%>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-4">

            <div class="card login-card">
                <!-- HEADER -->
                <div class="login-header">
                    <div class="brand-circle">
                        <i class="fas fa-plane-departure"></i>
                    </div>
                    <h4>Ingreso al sistema</h4>
                    <small>Sistema de Agencia de Viajes</small>
                    <!-- Fecha y hora -->
                    <div id="dateTime" class="mt-1 small"></div>
                </div>

                <!-- BODY -->
                <div class="login-body">

                    <!-- Mensajes del servidor -->
                    <% if (error != null) { %>
                        <div class="alert alert-danger py-2" role="alert">
                            <i class="fas fa-exclamation-circle"></i> <%= error %>
                        </div>
                    <% } else if (salida != null) { %>
                        <div class="alert alert-info py-2" role="alert">
                            <i class="fas fa-info-circle"></i> <%= salida %>
                        </div>
                    <% } %>

                    <!-- Mensaje de validación en cliente -->
                    <div id="clientErrorAlert" class="alert alert-warning py-2 d-none" role="alert">
                        <i class="fas fa-triangle-exclamation"></i>
                        <span id="clientErrorText"></span>
                    </div>

                    <!-- FORM -->
                    <form id="loginForm" action="loginUser" method="post">

                        <!-- Usuario -->
                        <div class="mb-3">
                            <label class="form-label">Usuario</label>
                            <input type="text"
                                   name="username"
                                   id="username"
                                   class="form-control"
                                   required
                                   autocomplete="off">
                        </div>

                        <!-- Contraseña -->
                        <div class="mb-1">
                            <label class="form-label">Contraseña</label>
                            <div class="input-group">
                                <input type="password"
                                       name="password"
                                       id="password"
                                       class="form-control"
                                       placeholder="Ingrese su contraseña"
                                       required>
                                <button type="button"
                                        class="btn btn-outline-secondary"
                                        id="togglePassword">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                            <div id="capsWarning" class="caps-warning">
                                <i class="fas fa-arrow-up"></i> Bloq Mayús está activado.
                            </div>
                        </div>

                        <!-- Recordar usuario -->
                        <div class="form-check my-2">
                            <input class="form-check-input" type="checkbox" id="rememberUser">
                            <label class="form-check-label" for="rememberUser">
                                Recordar usuario en este equipo
                            </label>
                        </div>

                        <!-- Botón -->
                        <button type="submit" class="btn btn-primary w-100 mb-2 btn-login">
                            Ingresar
                        </button>

                        <!-- Link recuperar -->
                        <div class="text-center small-link">
                            <a href="recuperar.jsp" class="text-decoration-none">
                                ¿Olvidaste tu contraseña?
                            </a>
                        </div>
                    </form>
                </div>

                <!-- FOOTER -->
                <div class="card-footer text-center small"
                     style="background:#ffffff; color:#111827; font-weight:600;">
                    Sistema de Agencia de Viajes · TES
                </div>
            </div> <!-- cierra .card -->

        </div> <!-- cierra .col-md-4 -->
    </div>     <!-- cierra .row -->
</div>         <!-- cierra .container -->

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Actualizar fecha y hora en la cabecera
function actualizarFechaHora() {
    var now = new Date();

    var opcionesFecha = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
    var opcionesHora  = { hour: '2-digit', minute: '2-digit', second: '2-digit' };

    var fecha = now.toLocaleDateString('es-ES', opcionesFecha);
    var hora  = now.toLocaleTimeString('es-ES', opcionesHora);

    // Primera letra de la fecha en mayúscula
    if (fecha && fecha.length > 0) {
        fecha = fecha.charAt(0).toUpperCase() + fecha.slice(1);
    }

    var dateTimeDiv = document.getElementById('dateTime');
    if (dateTimeDiv) {
        dateTimeDiv.innerHTML =
            '<i class="fas fa-clock"></i> ' + fecha + ' — ' + hora;
    }
}

setInterval(actualizarFechaHora, 1000);
actualizarFechaHora();


    // Limpiar usuario y contraseña incluso cuando se vuelve con el botón "Atrás"
    window.addEventListener('pageshow', function (event) {
        var form = document.getElementById('loginForm');
        if (form) {
            var userInput = document.getElementById('username');
            var passInput = document.getElementById('password');
            if (userInput) userInput.value = '';
            if (passInput) passInput.value = '';
        }
    });

    const passwordInput   = document.getElementById('password');
    const toggleBtn       = document.getElementById('togglePassword');
    const capsWarning     = document.getElementById('capsWarning');
    const loginForm       = document.getElementById('loginForm');
    const clientErrorBox  = document.getElementById('clientErrorAlert');
    const clientErrorText = document.getElementById('clientErrorText');
    const usernameInput   = document.getElementById('username');
    const rememberCheck   = document.getElementById('rememberUser');

    // Mostrar / ocultar contraseña
    if (passwordInput && toggleBtn) {
        toggleBtn.addEventListener('click', () => {
            const isPassword = passwordInput.type === 'password';
            passwordInput.type = isPassword ? 'text' : 'password';
            toggleBtn.innerHTML = isPassword
                ? '<i class="fas fa-eye-slash"></i>'
                : '<i class="fas fa-eye"></i>';
        });
    }

    // Detectar Bloq Mayús
    if (passwordInput && capsWarning) {
        const handleCaps = (event) => {
            if (event.getModifierState && event.getModifierState('CapsLock')) {
                capsWarning.style.display = 'block';
            } else {
                capsWarning.style.display = 'none';
            }
        };
        passwordInput.addEventListener('keyup', handleCaps);
        passwordInput.addEventListener('keydown', handleCaps);
        passwordInput.addEventListener('blur', () => capsWarning.style.display = 'none');
    }

    // Recordar usuario con localStorage
    if (usernameInput && rememberCheck) {
        // Cargar valor guardado al iniciar
        const savedRemember = localStorage.getItem('rememberUser') === 'true';
        const savedUser     = localStorage.getItem('savedUsername') || '';

        if (savedRemember && savedUser) {
            rememberCheck.checked = true;
            usernameInput.value   = savedUser;
        }

        // Guardar al enviar el formulario
        if (loginForm) {
            loginForm.addEventListener('submit', function () {
                if (rememberCheck.checked) {
                    localStorage.setItem('rememberUser', 'true');
                    localStorage.setItem('savedUsername', usernameInput.value.trim());
                } else {
                    localStorage.removeItem('rememberUser');
                    localStorage.removeItem('savedUsername');
                }
            });
        }
    }

    // Validación básica en cliente
    if (loginForm && usernameInput && passwordInput && clientErrorBox && clientErrorText) {
        loginForm.addEventListener('submit', function (e) {
            clientErrorBox.classList.add('d-none');
            clientErrorText.textContent = '';

            const user = usernameInput.value.trim();
            const pass = passwordInput.value.trim();

            if (user.length < 3) {
                e.preventDefault();
                clientErrorText.textContent = 'El usuario debe tener al menos 3 caracteres.';
                clientErrorBox.classList.remove('d-none');
                usernameInput.focus();
                return;
            }

            if (pass.length < 3) {
                e.preventDefault();
                clientErrorText.textContent = 'La contraseña debe tener al menos 3 caracteres.';
                clientErrorBox.classList.remove('d-none');
                passwordInput.focus();
            }
        });
    }
</script>

</body>
</html>
