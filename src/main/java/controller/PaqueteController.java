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
                // Formulario vacío
                req.getRequestDispatcher("/WEB-INF/views/paquetes/form.jsp")
                        .forward(req, resp);
                break;

            case "editar": {
                String idParam = req.getParameter("id");
                if (idParam != null && !idParam.isEmpty()) {
                    int id = Integer.parseInt(idParam);
                    Paquete p = paqueteDAO.buscarPorId(id);
                    req.setAttribute("paquete", p);
                    req.getRequestDispatcher("/WEB-INF/views/paquetes/form.jsp")
                            .forward(req, resp);
                    return;
                }
                resp.sendRedirect(req.getContextPath() + "/paquetes?action=listar");
                break;
            }

            case "eliminar": {
                String idParam = req.getParameter("id");
                if (idParam != null && !idParam.isEmpty()) {
                    int id = Integer.parseInt(idParam);
                    paqueteDAO.eliminar(id);
                }
                resp.sendRedirect(req.getContextPath() + "/paquetes?action=listar");
                break;
            }

            case "listar":
            default:
                List<Paquete> paquetes = paqueteDAO.listar();
                req.setAttribute("paquetes", paquetes);
                req.getRequestDispatcher("/WEB-INF/views/paquetes/listar.jsp")
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
        String destino = req.getParameter("destino");
        String precioStr = req.getParameter("precio");
        String descripcion = req.getParameter("descripcion");
        String duracionStr = req.getParameter("duracionDias");
        String disponibleStr = req.getParameter("disponible");
        String imagenUrl = req.getParameter("imagenUrl");

        BigDecimal precio = (precioStr != null && !precioStr.isEmpty())
                ? new BigDecimal(precioStr)
                : BigDecimal.ZERO;

        int duracionDias = (duracionStr != null && !duracionStr.isEmpty())
                ? Integer.parseInt(duracionStr)
                : 0;

        boolean disponible = "on".equalsIgnoreCase(disponibleStr) || "true".equalsIgnoreCase(disponibleStr);

        Paquete p = new Paquete();
        if (id != null) {
            p.setId(id);
        }
        p.setNombre(nombre);
        p.setDestino(destino);
        p.setPrecio(precio);
        p.setDescripcion(descripcion);
        p.setDuracionDias(duracionDias);
        p.setDisponible(disponible);
        p.setImagenUrl(imagenUrl);

        if (id == null) {
            paqueteDAO.guardar(p);
        } else {
            paqueteDAO.actualizar(p);
        }

        resp.sendRedirect(req.getContextPath() + "/paquetes?action=listar");
    }
}
