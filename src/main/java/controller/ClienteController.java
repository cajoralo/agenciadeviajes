package controller;

import dao.ClienteDAO;
import model.Cliente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/clientes")
public class ClienteController extends HttpServlet {

    private final ClienteDAO clienteDAO = new ClienteDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "listar";

        switch (action) {

            case "nuevo":
                req.getRequestDispatcher("WEB-INF/views/clientes/form.jsp")
                   .forward(req, resp);
                break;

            case "listar":
                List<Cliente> clientes = clienteDAO.listar();
                req.setAttribute("clientes", clientes);
                req.getRequestDispatcher("WEB-INF/views/clientes/listar.jsp")
                   .forward(req, resp);
                break;

            case "editar":
                int idEditar = Integer.parseInt(req.getParameter("id"));
                Cliente cliente = clienteDAO.obtenerPorId(idEditar);

                if (cliente == null) {
                    resp.sendRedirect("clientes?action=listar&msg=no_encontrado");
                    return;
                }

                req.setAttribute("cliente", cliente);
                req.getRequestDispatcher("WEB-INF/views/clientes/form.jsp")
                   .forward(req, resp);
                break;

            case "eliminar":
                int idEliminar = Integer.parseInt(req.getParameter("id"));
                clienteDAO.eliminar(idEliminar);
                resp.sendRedirect("clientes?action=listar&msg=eliminado");
                break;

            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
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

        String nombre = req.getParameter("nombre");
        String email = req.getParameter("email");
        String telefono = req.getParameter("telefono");
        String direccion = req.getParameter("direccion");

        Cliente c = new Cliente();
        if (id != null) {
            c.setId(id);
        }
        c.setNombre(nombre);
        c.setEmail(email);
        c.setTelefono(telefono);
        c.setDireccion(direccion);

        if (id == null) {
            clienteDAO.guardar(c);
        } else {
            clienteDAO.actualizar(c);
        }

        resp.sendRedirect(req.getContextPath() + "/clientes?action=listar");
    }
}
