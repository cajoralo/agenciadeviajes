package controller;

import dao.PaqueteDAO;
import dao.ReservaDAO;
import model.Paquete;
import model.Reserva;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/reservas")
public class ReservaController extends HttpServlet {

    private final ReservaDAO reservaDAO = new ReservaDAO();
    private final PaqueteDAO paqueteDAO = new PaqueteDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null || action.isEmpty()) {
            action = "listar";
        }

        switch (action) {
            case "nuevo":
                // Cargar paquetes disponibles para el formulario
                List<Paquete> paquetesDisponibles = paqueteDAO.listarDisponibles();
                req.setAttribute("paquetesDisponibles", paquetesDisponibles);
                req.getRequestDispatcher("/WEB-INF/views/reservas/form.jsp")
                        .forward(req, resp);
                break;

            case "listar":
            default:
                // Cargar todas las reservas y enviarlas a la vista
                List<Reserva> reservas = reservaDAO.listar();
                req.setAttribute("reservas", reservas);
                req.getRequestDispatcher("/WEB-INF/views/reservas/listar.jsp")
                        .forward(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String clienteNombre = req.getParameter("clienteNombre");
        int paqueteId = Integer.parseInt(req.getParameter("paqueteId"));
        LocalDate fecha = LocalDate.parse(req.getParameter("fecha"));
        int numeroPersonas = Integer.parseInt(req.getParameter("numeroPersonas"));
        String estado = req.getParameter("estado");

        Paquete paquete = paqueteDAO.buscarPorId(paqueteId);

        Reserva r = new Reserva();
        r.setClienteNombre(clienteNombre);
        r.setPaquete(paquete);
        r.setFecha(fecha);
        r.setNumeroPersonas(numeroPersonas);
        r.setEstado(estado);

        reservaDAO.guardar(r);

        // Redirigir usando el context path para que funcione en cualquier servidor/ruta
        resp.sendRedirect(req.getContextPath() + "/reservas?action=listar");
    }
}
