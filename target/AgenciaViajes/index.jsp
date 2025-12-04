<%@page import="java.lang.Object"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.ClienteDAO, dao.PaqueteDAO, dao.ReservaDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Usuario" %>

<%
    // ==== CONTROL DE SESIÓN ====
    Object obj = session.getAttribute("usuarioLogueado");
    Usuario u = null;

    if (obj instanceof Usuario) {
        u = (Usuario) obj;
    }

    if (u == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // ==== ESTADÍSTICAS ====
    ClienteDAO clienteDAO = new ClienteDAO();
    PaqueteDAO paqueteDAO = new PaqueteDAO();
    ReservaDAO reservaDAO = new ReservaDAO();

    List clientes = clienteDAO.listar();
    int totalClientes = clientes != null ? clientes.size() : 0;

    List paquetes = paqueteDAO.listar();
    int totalPaquetes = paquetes != null ? paquetes.size() : 0;

    List reservas = reservaDAO.listar();
    int totalReservas = reservas != null ? reservas.size() : 0;
%>

<!DOCTYPE html>
<html>
<head>
    <title>Agencia de Viajes TRAVEXA - Sistema de Gestión</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            background: #f8f9fa;
            color: #333;
            font-family: 'Segoe UI', sans-serif;
        }
        /* NAVBAR */
        .top-navbar {
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 50%, #0ea5e9 100%);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }
        .top-navbar .navbar-brand {
            font-weight: 700;
        }

        .hero-section {
            background: #fff;
            padding: 60px 30px;
            border-radius: 15px;
            margin-top: 25px;
            margin-bottom: 40px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }
        .hero-section i {
            color: #667eea;
            opacity: 0.9;
        }
        .stat-card {
            background: #fff;
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            margin-bottom: 20px;
            border-left: 5px solid #667eea;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        .stat-number {
            font-size: 2.5rem;
            font-weight: bold;
            color: #667eea;
        }
        .stat-label {
            color: #6c757d;
            font-size: 0.9rem;
        }
        .quick-actions {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 50px;
        }
        .quick-btn {
            padding: 15px 20px;
            font-size: 1.1rem;
            border-radius: 10px;
            font-weight: 600;
        }
        .feature-card {
            background: #fff;
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: transform 0.3s ease;
            margin-bottom: 20px;
        }
        .feature-card:hover {
            transform: translateY(-5px);
        }
        .feature-icon {
            font-size: 3rem;
            margin-bottom: 15px;
            color: #667eea;
        }
        footer {
            margin-top: 50px;
            color: #6c757d;
        }

        /* Banner promocional animado */
        .promo-banner {
            background: linear-gradient(90deg, #0ea5e9, #2563eb);
            color: white;
            padding: 12px;
            border-radius: 10px;
            overflow: hidden;
            margin-top: 25px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
        }
        .promo-text {
            white-space: nowrap;
            display: inline-block;
            padding-left: 100%;
            animation: scrollPromo 55s linear infinite;
            font-size: 1.25rem;
            font-weight: 600;
            letter-spacing: 0.5px;
        }
        @keyframes scrollPromo {
            from { transform: translateX(0); }
            to   { transform: translateX(-100%); }
        }
    </style>
</head>
<body>

<!-- NAVBAR SUPERIOR -->
<nav class="navbar navbar-expand-lg navbar-dark top-navbar">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">
            <i class="fas fa-plane-departure me-2"></i>Agencia de Viajes TRAVEXA
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-end" id="navbarMain">
            <span class="navbar-text text-white me-3">
                Bienvenido/a:
                <strong><%= u.getNombre() + " " + u.getApellido() %></strong>
            </span>

            <a href="cambiar_password.jsp" class="btn btn-outline-light btn-sm me-2">
                <i class="fas fa-key"></i> Cambiar contraseña
            </a>

            <a href="logout" class="btn btn-light btn-sm">
                <i class="fas fa-sign-out-alt"></i> Cerrar sesión
            </a>
        </div>
    </div>
</nav>

<div class="container">

    <!-- CARRUSEL DE DESTINOS -->
    <div id="carouselDestinos" class="carousel slide mt-3 mb-4" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="https://images.unsplash.com/photo-1507525428034-b723cf961d3e" class="d-block w-100"
                     style="height:350px; object-fit:cover;">
                <div class="carousel-caption d-none d-md-block">
                    <h5>Explora el mundo</h5>
                    <p>Descubre playas, ciudades y aventuras inolvidables.</p>
                </div>
            </div>
            <div class="carousel-item">
                <img src="https://images.unsplash.com/photo-1500530855697-b586d89ba3ee" class="d-block w-100"
                     style="height:350px; object-fit:cover;">
                <div class="carousel-caption d-none d-md-block">
                    <h5>Viajes de ensueño</h5>
                    <p>Ofertas especiales todo el año para tus clientes.</p>
                </div>
            </div>
            <div class="carousel-item">
                <img src="https://images.unsplash.com/photo-1493558103817-58b2924bce98" class="d-block w-100"
                     style="height:350px; object-fit:cover;">
                <div class="carousel-caption d-none d-md-block">
                    <h5>Paquetes personalizados</h5>
                    <p>La experiencia perfecta para cada tipo de viajero.</p>
                </div>
            </div>
        </div>

        <button class="carousel-control-prev" type="button" data-bs-target="#carouselDestinos" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselDestinos" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </button>
    </div>
    <!-- FIN CARRUSEL -->

    <!-- Hero Section -->
    <div class="hero-section">
        <div class="row align-items-center">
            <div class="col-lg-8">
                <h1 class="display-4 fw-bold">🏝️ TRAVEXA</h1>
                <p class="lead">Sistema integral de gestión para tu agencia de viajes</p>
                <p>Gestiona clientes, paquetes turísticos y reservas de manera eficiente</p>
            </div>
            <div class="col-lg-4 text-center">
                <img src="https://i.imgur.com/lSds2eb.png" alt="Logo Agencia" style="height:250px;">
            </div>
        </div>
    </div>

    <!-- Banner Promocional Animado -->
    <div class="promo-banner">
        <div class="promo-text">
            🎄✨ ¡PROMOCIÓN NAVIDEÑA EN TRAVEXA! ✨🎄
            | 🌎 Viaja a los mejores destinos internacionales con hasta 40% de DESCUENTO en paquetes completos.
            | 🎁 Promoción válida por temporada navideña y fin de año. ¡Reserva antes de que se agoten los lugares!
            | 🏨 Incluye hoteles seleccionados, transporte, tours guiados y asistencia personalizada las 24 horas.
            | ✈️ Aprovecha vuelos especiales con tarifas reducidas y flexibilidad en cambios.
            | 🎅 Regala un viaje inolvidable: sorprende a tu familia con experiencias únicas este año.
            | 🎆 TRAVEXA te desea unas Felices Fiestas, un próspero Año Nuevo y miles de aventuras por descubrir.
            | 🧳 Empieza a preparar tus maletas… ¡tu próximo destino te está esperando!
        </div>
    </div>

    <!-- Estadísticas -->
    <div class="row mb-5 mt-4">
        <div class="col-md-4">
            <div class="stat-card">
                <div class="stat-number"><%= totalClientes %></div>
                <div class="stat-label">CLIENTES REGISTRADOS</div>
                <i class="fas fa-users mt-2" style="font-size: 1.5rem;"></i>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card">
                <div class="stat-number"><%= totalPaquetes %></div>
                <div class="stat-label">PAQUETES DISPONIBLES</div>
                <i class="fas fa-suitcase mt-2" style="font-size: 1.5rem;"></i>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card">
                <div class="stat-number"><%= totalReservas %></div>
                <div class="stat-label">RESERVAS ACTIVAS</div>
                <i class="fas fa-calendar-check mt-2" style="font-size: 1.5rem;"></i>
            </div>
        </div>
    </div>

    <!-- Acciones Rápidas -->
    <div class="quick-actions">
        <a href="clientes?action=nuevo" class="btn btn-primary quick-btn">
            <i class="fas fa-user-plus"></i> Nuevo Cliente
        </a>
        <a href="paquetes?action=nuevo" class="btn btn-success quick-btn">
            <i class="fas fa-plus-circle"></i> Crear Paquete
        </a>
    </div>

    <!-- Módulos del Sistema -->
    <div class="row">
        <div class="col-md-4">
            <div class="feature-card">
                <div class="feature-icon"><i class="fas fa-users"></i></div>
                <h5>Gestión de Clientes</h5>
                <p>Administra la información de tus clientes, contactos y preferencias de viaje.</p>
                <a href="clientes?action=listar" class="btn btn-outline-primary">Administrar Clientes</a>
            </div>
        </div>

        <div class="col-md-4">
            <div class="feature-card">
                <div class="feature-icon"><i class="fas fa-globe"></i></div>
                <h5>Explora Países</h5>
                <p>Más de 60 países para descubrir, reservar y vivir experiencias únicas.</p>
                <a href="explorarPaises.jsp" class="btn btn-success">Ver Países</a>
            </div>
        </div>

        <div class="col-md-4">
            <div class="feature-card">
                <div class="feature-icon"><i class="fas fa-suitcase-rolling"></i></div>
                <h5>Paquetes Turísticos</h5>
                <p>Crea y gestiona paquetes de viaje con destinos, precios y disponibilidad.</p>
                <a href="paquetes?action=listar" class="btn btn-success">Ver Paquetes</a>
            </div>
        </div>

        <div class="col-md-4">
            <div class="feature-card">
                <div class="feature-icon"><i class="fas fa-calendar-alt"></i></div>
                <h5>Sistema de Reservas</h5>
                <p>Gestiona reservas, fechas de viaje y confirmaciones de tus clientes.</p>
                <a href="reservas?action=listar" class="btn btn-outline-warning">Gestionar Reservas</a>
            </div>
        </div>
    </div>

    <!-- RESERVA RÁPIDA -->
    <div class="row mt-4">
        <div class="col-12">
            <div class="card shadow-sm border-0">
                <div class="card-body d-flex flex-column flex-md-row justify-content-between align-items-md-center">
                    <div>
                        <h5 class="mb-1">Reserva rápida</h5>
                        <p class="text-muted mb-0">
                            Crea una nueva reserva en pocos clics para tus clientes frecuentes.
                        </p>
                    </div>
                    <a href="reservas?action=nueva"
                       class="btn btn-primary mt-3 mt-md-0">
                        📝 Crear nueva reserva
                    </a>
                </div>
            </div>
        </div>
    </div>
    <!-- FIN RESERVA RÁPIDA -->

    <!-- Estado de la Base de Datos -->
    <div class="row mt-5">
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-light">
                    <h5 class="mb-0"><i class="fas fa-database"></i> Estado del Sistema</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <h6>Base de Datos Conectada</h6>
                            <div class="alert alert-success">
                                <i class="fas fa-check-circle"></i> PostgreSQL - agencia_viajes
                            </div>
                        </div>
                        <div class="col-md-6">
                            <h6>Tablas Configuradas</h6>
                            <ul class="list-group">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    Tabla: clientes
                                    <span class="badge bg-primary rounded-pill"><%= totalClientes %></span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    Tabla: paquetes
                                    <span class="badge bg-success rounded-pill"><%= totalPaquetes %></span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    Tabla: reservas
                                    <span class="badge bg-warning rounded-pill"><%= totalReservas %></span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="text-center mt-5 mb-4">
        <hr>
        <p class="text-muted">Sistema de Gestión - Agencia de Viajes &copy; 2025</p>
    </footer>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
