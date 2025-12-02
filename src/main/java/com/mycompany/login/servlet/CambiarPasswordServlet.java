package com.mycompany.login.servlet;

import com.mycompany.login.dao.UsuarioDAO;
import model.Usuario;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "CambiarPasswordServlet", urlPatterns = {"/cambiarPassword"})
public class CambiarPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession ses = request.getSession(false);
        if (ses == null || ses.getAttribute("usuarioLogueado") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Usuario u = (Usuario) ses.getAttribute("usuarioLogueado");
        int idUsuario = u.getId();

        String passActual = request.getParameter("passwordActual");
        String passNueva = request.getParameter("passwordNueva");
        String passConfirmar = request.getParameter("passwordConfirmar");

        if (passActual == null || passNueva == null || passConfirmar == null ||
            passActual.isBlank() || passNueva.isBlank() || passConfirmar.isBlank()) {

            request.setAttribute("mensajeError", "Todos los campos son obligatorios.");
            request.getRequestDispatcher("cambiar_password.jsp").forward(request, response);
            return;
        }

        if (!passNueva.equals(passConfirmar)) {
            request.setAttribute("mensajeError", "La nueva contraseña y su confirmación no coinciden.");
            request.getRequestDispatcher("cambiar_password.jsp").forward(request, response);
            return;
        }

        UsuarioDAO dao = new UsuarioDAO();
        boolean ok = dao.cambiarPassword(idUsuario, passActual, passNueva);

        if (ok) {
            // ✅ Cerrar sesión y mandar al login con mensaje
            ses.invalidate();
            request.setAttribute("mensajeSalida",
                    "Su contraseña se ha actualizado correctamente. Inicie sesión nuevamente.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("mensajeError", "La contraseña actual no es correcta.");
            request.getRequestDispatcher("cambiar_password.jsp").forward(request, response);
        }
    }

    // Si alguien entra por GET a /cambiarPassword, lo mandamos al JSP
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("cambiar_password.jsp");
    }
}
