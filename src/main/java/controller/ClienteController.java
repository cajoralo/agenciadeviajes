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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null || action.isEmpty()) {
            action = "listar";
        }

        switch (action) {
            case "nuevo":
                // Formulario vacío para nuevo cliente
                req.getRequestDispatcher("/WEB-INF/views/clientes/form.jsp")
                        .forward(req, resp);
                break;

            case "editar": {
                // Cargar cliente por id y mandar al formulario
                String idParam = req.getParameter("id");
                if (idParam != null && !idParam.isEmpty()) {
                    int id = Integer.parseInt(idParam);
                    Cliente c = clienteDAO.buscarPorId(id); // método agregado en ClienteDAO
                    if (c != null) {
                        req.setAttribute("cliente", c);
                        req.getRequestDispatcher("/WEB-INF/views/clientes/form.jsp")
                                .forward(req, resp);
                        return;
                    }
                }
                // Si algo falla, volver a listar
                resp.sendRedirect(req.getContextPath() + "/clientes?action=listar");
                break;
            }

            case "eliminar": {
                String idParam = req.getParameter("id");
                if (idParam != null && !idParam.isEmpty()) {
                    int id = Integer.parseInt(idParam);
                    clienteDAO.eliminar(id); // método agregado en ClienteDAO
                }
                resp.sendRedirect(req.getContextPath() + "/clientes?action=listar");
                break;
            }

            case "listar":
            default:
                List<Cliente> clientes = clienteDAO.listar();
                req.setAttribute("clientes", clientes);
                req.getRequestDispatcher("/WEB-INF/views/clientes/listar.jsp")
                        .forward(req, resp);
                break;
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
            // nuevo
            clienteDAO.guardar(c);
        } else {
            // actualización
            clienteDAO.actualizar(c);
        }

        resp.sendRedirect(req.getContextPath() + "/clientes?action=listar");
    }
}
