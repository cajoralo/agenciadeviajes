package controller;

import dao.PaqueteDAO;
import dao.ReservaDAO;
import dao.ClienteDAO;
import model.Paquete;
import model.Reserva;
import model.Cliente;

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
    private final ClienteDAO clienteDAO = new ClienteDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null || action.isEmpty()) {
            action = "listar";
        }

        switch (action) {
            case "nueva":
                // Nueva reserva: solo formulario vacío
                cargarDatosFormulario(req, null);
                req.getRequestDispatcher("/WEB-INF/views/reservas/form.jsp")
                        .forward(req, resp);
                break;

            case "editar": {
                // Editar: cargamos reserva + listas
                String idParam = req.getParameter("id");
                if (idParam != null && !idParam.isEmpty()) {
                    int id = Integer.parseInt(idParam);
                    Reserva r = reservaDAO.buscarPorId(id); // asegúrate de tener este método
                    cargarDatosFormulario(req, r);
                    req.setAttribute("reserva", r);
                    req.getRequestDispatcher("/WEB-INF/views/reservas/form.jsp")
                            .forward(req, resp);
                } else {
                    resp.sendRedirect(req.getContextPath() + "/reservas?action=listar");
                }
                break;
            }

            case "eliminar": {
                String idParam = req.getParameter("id");
                if (idParam != null && !idParam.isEmpty()) {
                    int id = Integer.parseInt(idParam);
                    reservaDAO.eliminar(id); // asegúrate de tener este método
                }
                resp.sendRedirect(req.getContextPath() + "/reservas?action=listar");
                break;
            }

            case "listar":
            default:
                List<Reserva> reservas = reservaDAO.listar();
                req.setAttribute("reservas", reservas);
                req.getRequestDispatcher("/WEB-INF/views/reservas/listar.jsp")
                        .forward(req, resp);
                break;
        }
    }

    /**
     * Carga las listas de clientes y paquetes para el formulario.
     * Si la reserva es null, es "nueva"; si no, es "editar".
     */
    private void cargarDatosFormulario(HttpServletRequest req, Reserva reserva) {
        List<Cliente> clientes = clienteDAO.listar();          // método listar() en ClienteDAO
        List<Paquete> paquetes = paqueteDAO.listar();          // o listarDisponibles(), como prefieras

        req.setAttribute("clientes", clientes);
        req.setAttribute("paquetes", paquetes);
        if (reserva != null) {
            req.setAttribute("reserva", reserva);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String idParam = req.getParameter("id");
        Integer id = (idParam != null && !idParam.isEmpty())
                ? Integer.parseInt(idParam)
                : null;

        int clienteId = Integer.parseInt(req.getParameter("clienteId"));
        int paqueteId = Integer.parseInt(req.getParameter("paqueteId"));
        LocalDate fecha = LocalDate.parse(req.getParameter("fechaReserva"));
        int numeroPersonas = Integer.parseInt(req.getParameter("numeroPersonas"));
        String estado = req.getParameter("estado");

        Reserva r = new Reserva();
        if (id != null) {
            r.setId(id);
        }
        r.setClienteId(clienteId);
        r.setPaqueteId(paqueteId);
        r.setFechaReserva(fecha);
        r.setNumeroPersonas(numeroPersonas);
        r.setEstado(estado);

        if (id == null) {
            reservaDAO.guardar(r);       // insertar nueva
        } else {
            reservaDAO.actualizar(r);    // actualizar existente
        }

        resp.sendRedirect(req.getContextPath() + "/reservas?action=listar");
    }
}
