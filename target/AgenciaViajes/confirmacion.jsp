<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Contraseña restablecida</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            min-height: 100vh;
            margin: 0;
            background: radial-gradient(circle at top, #1f2937 0%, #020617 55%);
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            color: #e5e7eb;
        }

        .card-confirm {
            width: 420px;
            border-radius: 20px;
            background: rgba(15,23,42,0.93);
            backdrop-filter: blur(18px);
            -webkit-backdrop-filter: blur(18px);
            box-shadow: 0 20px 45px rgba(0,0,0,0.6);
            overflow: hidden;
            border: 1px solid rgba(148,163,184,0.18);
            text-align: center;
        }

        .card-confirm-header {
            background: linear-gradient(135deg, #16a34a 0%, #22c55e 40%, #4ade80 100%);
            padding: 24px;
            color: #f9fafb;
        }

        .confirm-icon-circle {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            background: rgba(15,23,42,0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 10px;
        }

        .confirm-icon-circle i {
            font-size: 2.6rem;
        }

        .card-confirm-body {
            padding: 22px 24px;
        }

        #contador {
            font-weight: 700;
            color: #4ade80;
            font-size: 1.2rem;
            margin-top: 10px;
        }

        .card-confirm-footer {
            padding: 14px 20px 18px;
            text-align: center;
            font-size: 0.8rem;
            color: #6b7280;
            border-top: 1px solid rgba(31,41,55,0.9);
            background: rgba(15,23,42,0.98);
        }
    </style>
</head>

<body>

<div class="card-confirm">

    <!-- HEADER -->
    <div class="card-confirm-header">
        <div class="confirm-icon-circle">
            <i class="fas fa-check-circle"></i>
        </div>
        <h5 class="mb-0 fw-semibold">Contraseña restablecida</h5>
        <small>Sistema de Agencia de Viajes</small>
    </div>

    <!-- BODY -->
    <div class="card-confirm-body">
        <h4>¡Todo listo!</h4>
        <p>Tu contraseña se ha actualizado correctamente.</p>
        <p>Serás redirigido al inicio de sesión en:</p>

        <div id="contador">3</div> <!-- contador -->
    </div>

    <!-- FOOTER -->
    <div class="card-confirm-footer">
        Sistema de Agencia de Viajes · TES
    </div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    let segundos = 3;
    let contador = document.getElementById("contador");

    const intervalo = setInterval(() => {
        segundos--;
        contador.textContent = segundos;

        if (segundos <= 0) {
            clearInterval(intervalo);
            window.location.href = "login.jsp"; // redirección
        }
    }, 1000);
</script>

</body>
</html>
