
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
    private ClienteDAO clienteDAO = new ClienteDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("nuevo".equals(action)) {
            req.getRequestDispatcher("nuevoCliente.jsp").forward(req, resp);
        } else if ("listar".equals(action)) {
            List<Cliente> clientes = clienteDAO.listar();
            req.setAttribute("clientes", clientes);
            req.getRequestDispatcher("verCliente.jsp").forward(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String nombre = req.getParameter("nombre");
        String email = req.getParameter("email");
        String telefono = req.getParameter("telefono");

        Cliente c = new Cliente();
        c.setNombre(nombre);
        c.setEmail(email);
        c.setTelefono(telefono);

        clienteDAO.guardar(c);
        resp.sendRedirect("clientes?action=listar");
    }
}