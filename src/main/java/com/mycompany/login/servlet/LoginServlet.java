package com.mycompany.login.servlet;

import com.mycompany.login.dao.UsuarioDAO;
import com.mycompany.login.model.Usuario;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/loginUser"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UsuarioDAO dao = new UsuarioDAO();
        Usuario u = dao.login(username, password);

        if (u != null) {
            // Login correcto
            HttpSession ses = request.getSession();
            ses.setAttribute("usuarioLogueado", u);
            response.sendRedirect("index.jsp");
        } else {
            // Login incorrecto
            request.setAttribute("mensajeError", "Usuario o contraseña incorrectos");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
