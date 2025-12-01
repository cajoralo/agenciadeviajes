
package controller;

import dao.PaqueteDAO;
import model.Paquete;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/paquetes")
public class PaqueteController extends HttpServlet {

    private PaqueteDAO paqueteDAO = new PaqueteDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        switch (action != null ? action : "") {
            case "listar":
                // Listar todos los paquetes
                List<Paquete> paquetes = paqueteDAO.listar();
                req.setAttribute("paquetes", paquetes);
                req.getRequestDispatcher("verPaquetes.jsp").forward(req, resp);
                break;

            case "nuevo":
                // Mostrar formulario para crear paquete
                req.getRequestDispatcher("crearPaquete.jsp").forward(req, resp);
                break;

            case "listarDisponibles":
                // Listar solo paquetes disponibles
                List<Paquete> paquetesDisponibles = paqueteDAO.listarDisponibles();
                req.setAttribute("paquetes", paquetesDisponibles);
                req.getRequestDispatcher("verPaquetes.jsp").forward(req, resp);
                break;

            default:
                // Manejar edición de descripción
                if (req.getParameter("editar") != null) {
                    int id = Integer.parseInt(req.getParameter("editar"));
                    String nuevaDesc = req.getParameter("descripcion_" + id);
                    Paquete p = paqueteDAO.buscarPorId(id);
                    if (p != null) {
                        p.setDescripcion(nuevaDesc);
                        paqueteDAO.actualizar(p);
                    }
                    resp.sendRedirect("paquetes?action=listar");
                    return;
                }

                // Buscar paquete por ID (para mostrar info individual)
                if (req.getParameter("id") != null) {
                    int id = Integer.parseInt(req.getParameter("id"));
                    Paquete p = paqueteDAO.buscarPorId(id);
                    req.setAttribute("paquete", p);
                    req.getRequestDispatcher("verPaquete.jsp").forward(req, resp);
                    return;
                }

                // Si no hay acción válida, redirigir a listar
                resp.sendRedirect("paquetes?action=listar");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Crear nuevo paquete
        String nombre = req.getParameter("nombre");
        String destino = req.getParameter("destino");
        String descripcion = req.getParameter("descripcion");
        String precioStr = req.getParameter("precio");
        String duracionDiasStr = req.getParameter("duracionDias");
        String disponibleStr = req.getParameter("disponible");
        String imagenUrl = req.getParameter("imagenUrl");

        BigDecimal precio = new BigDecimal(precioStr);
        int duracionDias = Integer.parseInt(duracionDiasStr);
        boolean disponible = Boolean.parseBoolean(disponibleStr);

        Paquete p = new Paquete();
        p.setNombre(nombre);
        p.setDestino(destino);
        p.setDescripcion(descripcion);
        p.setPrecio(precio);
        p.setDuracionDias(duracionDias);
        p.setDisponible(disponible);
        p.setImagenUrl(imagenUrl);

        paqueteDAO.guardar(p);

        resp.sendRedirect("paquetes?action=listar");
    }
}