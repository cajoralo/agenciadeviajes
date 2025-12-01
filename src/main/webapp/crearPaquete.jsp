<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Crear Paquete - Agencia de Viajes</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: #f8f9fa;
            font-family: 'Segoe UI', sans-serif;
            padding-top: 40px;
        }
        .form-container {
            background: #ffffff;
            padding: 30px;
            border-radius: 15px;
            max-width: 600px;
            margin: auto;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }
        .form-title {
            color: #667eea;
            margin-bottom: 20px;
        }
        .btn-submit {
            background-color: #28a745;
            color: white;
        }
        .btn-submit:hover {
            background-color: #218838;
        }
        .btn-back {
            margin-left: 10px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="form-container">
        <h3 class="form-title"><i class="fas fa-suitcase-rolling"></i> Crear Nuevo Paquete</h3>
        <form action="paquetes" method="post">
            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre del Paquete</label>
                <input type="text" class="form-control" id="nombre" name="nombre" required>
            </div>

            <div class="mb-3">
                <label for="destino" class="form-label">Destino</label>
                <input type="text" class="form-control" id="destino" name="destino" required>
            </div>

            <div class="mb-3">
                <label for="descripcion" class="form-label">Descripción</label>
                <textarea class="form-control" id="descripcion" name="descripcion" rows="3"></textarea>
            </div>

            <div class="mb-3">
                <label for="precio" class="form-label">Precio (USD)</label>
                <input type="number" step="0.01" class="form-control" id="precio" name="precio" required>
            </div>

            <div class="mb-3">
                <label for="duracionDias" class="form-label">Duración (días)</label>
                <input type="number" class="form-control" id="duracionDias" name="duracionDias" required>
            </div>

            <div class="mb-3">
                <label for="disponible" class="form-label">Disponible</label>
                <select class="form-select" id="disponible" name="disponible">
                    <option value="true">Sí</option>
                    <option value="false">No</option>
                </select>
            </div>

            <button type="submit" class="btn btn-submit"><i class="fas fa-plus-circle"></i> Guardar Paquete</button>
            <a href="paquetes?action=listar" class="btn btn-secondary btn-back"><i class="fas fa-arrow-left"></i> Volver a Paquetes</a>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>