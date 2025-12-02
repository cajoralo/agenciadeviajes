package com.mycompany.login.servlet;

import com.mycompany.login.dao.UsuarioDAO;
import model.Usuario;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "RecuperarPasswordServlet", urlPatterns = {"/recuperarPassword"})
public class RecuperarPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        UsuarioDAO dao = new UsuarioDAO();

        if ("buscar".equals(accion)) {
            // 1er paso: buscar la pregunta
            String username = request.getParameter("username");
            String pregunta = dao.obtenerPregunta(username);

            if (pregunta != null) {
                request.setAttribute("username", username);
                request.setAttribute("pregunta", pregunta);
            } else {
                request.setAttribute("mensajeError", "Usuario no encontrado");
            }
            request.getRequestDispatcher("recuperar.jsp").forward(request, response);

        } else if ("restablecer".equals(accion)) {
            // 2do paso: validar respuesta y cambiar clave
            String username = request.getParameter("username");
            String respuesta = request.getParameter("respuesta");
            String nuevaPass = request.getParameter("nuevaPassword");

            boolean ok = dao.restablecerPassword(username, respuesta, nuevaPass);

            if (ok) {
                request.setAttribute("mensajeExito", "Su contraseña se ha restablecido correctamente.");
                request.getRequestDispatcher("confirmacion.jsp").forward(request, response);

            } else {
                request.setAttribute("mensajeError", "Respuesta incorrecta. Inténtalo de nuevo.");
                request.setAttribute("username", username);
                request.setAttribute("pregunta", dao.obtenerPregunta(username));
                request.getRequestDispatcher("recuperar.jsp").forward(request, response);
            }
        }
    }
}
