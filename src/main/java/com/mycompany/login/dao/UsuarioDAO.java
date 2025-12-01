package com.mycompany.login.dao;

import com.mycompany.login.model.Usuario;
import com.mycompany.login.util.ConexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioDAO {

    public Usuario login(String username, String password) {
        Usuario u = null;

        String sql = "SELECT id, username, email, password, nombre, apellido " +
                 "FROM usuarios WHERE username = ? AND password = ?";

        try (Connection cn = ConexionBD.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setNombre(rs.getString("nombre"));     
                u.setApellido(rs.getString("apellido"));
            }

        } catch (SQLException e) {
            System.out.println("Error en login: " + e.getMessage());
        }

        return u;
    }
    // OBTENER PREGUNTA DE SEGURIDAD POR USERNAME
    public String obtenerPregunta(String username) {
    String pregunta = null;
    String sql = "SELECT pregunta_seguridad FROM usuarios WHERE username = ?";

    try (Connection cn = ConexionBD.getConnection();
         PreparedStatement ps = cn.prepareStatement(sql)) {

        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            pregunta = rs.getString("pregunta_seguridad");
        }
    } catch (SQLException e) {
        System.out.println("Error al obtener pregunta: " + e.getMessage());
    }
    return pregunta;
}
    // RESTABLECER PASSWORD SI LA RESPUESTA ES CORRECTA
    public boolean restablecerPassword(String username, String respuesta, String nuevaPass) {
    String sql = "UPDATE usuarios " +
                 "SET password = ? " +
                 "WHERE username = ? AND lower(respuesta_seguridad) = lower(?)";

    try (Connection cn = ConexionBD.getConnection();
         PreparedStatement ps = cn.prepareStatement(sql)) {

        ps.setString(1, nuevaPass);
        ps.setString(2, username);
        ps.setString(3, respuesta);

        int filas = ps.executeUpdate();
        return filas > 0;

    } catch (SQLException e) {
        System.out.println("Error al restablecer password: " + e.getMessage());
        return false;
    }
    }
    
    public boolean cambiarPassword(int idUsuario, String passwordActual, String passwordNueva) {
    String sql = "UPDATE usuarios SET password = ? WHERE id = ? AND password = ?";

    try (Connection cn = ConexionBD.getConnection();
         PreparedStatement ps = cn.prepareStatement(sql)) {

        ps.setString(1, passwordNueva);
        ps.setInt(2, idUsuario);
        ps.setString(3, passwordActual);

        int filas = ps.executeUpdate();
        return filas > 0;

    } catch (SQLException e) {
        System.out.println("Error al cambiar password: " + e.getMessage());
        return false;
    }
}
}

