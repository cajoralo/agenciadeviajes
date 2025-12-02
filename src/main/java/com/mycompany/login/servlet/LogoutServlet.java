package com.mycompany.login.servlet;

import java.io.IOException;
import model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession ses = request.getSession(false);
        if (ses != null) {
            ses.invalidate();  // destruir sesión
        }

        // Opcional: mensaje de salida
        request.setAttribute("mensajeSalida", "Su sesión se ha cerrado correctamente.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
