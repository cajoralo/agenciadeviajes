<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Nuevo Cliente - Agencia de Viajes</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background: #f8f9fa; font-family: 'Segoe UI', sans-serif; padding-top: 40px; }
        .form-container {
            background: #fff; padding: 30px; border-radius: 15px;
            max-width: 600px; margin: auto; box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }
        .form-title { color: #667eea; margin-bottom: 20px; }
        .btn-submit { background-color: #007bff; color: white; }
        .btn-submit:hover { background-color: #0069d9; }
        .btn-back { margin-left: 10px; }
    </style>
</head>
<body>

<div class="container">
    <div class="form-container">
        <h3 class="form-title"><i class="fas fa-user-plus"></i> Nuevo Cliente</h3>
        <form action="clientes" method="post">
            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre</label>
                <input type="text" class="form-control" id="nombre" name="nombre" required>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">Correo electrónico</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>

            <div class="mb-3">
                <label for="telefono" class="form-label">Teléfono</label>
                <input type="text" class="form-control" id="telefono" name="telefono" required>
            </div>

            <button type="submit" class="btn btn-submit"><i class="fas fa-save"></i> Guardar Cliente</button>
            <a href="clientes?action=listar" class="btn btn-secondary btn-back"><i class="fas fa-arrow-left"></i> Volver a Clientes</a>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>