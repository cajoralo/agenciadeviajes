
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

    private ReservaDAO reservaDAO = new ReservaDAO();
    private PaqueteDAO paqueteDAO = new PaqueteDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("listar".equals(action)) {
            List<Reserva> reservas = reservaDAO.listar();
            req.setAttribute("reservas", reservas);
            req.getRequestDispatcher("verReservas.jsp").forward(req, resp);
        } else if ("nuevo".equals(action)) {
            List<Paquete> paquetesDisponibles = paqueteDAO.listarDisponibles();
            req.setAttribute("paquetesDisponibles", paquetesDisponibles);
            req.getRequestDispatcher("nuevaReserva.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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

        resp.sendRedirect("reservas?action=listar");
    }
}