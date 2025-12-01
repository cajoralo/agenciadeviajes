package dao;

import model.Cliente;
import java.sql.*;
import java.util.*;

public class ClienteDAO {

    private Conexion Conexion = new Conexion();

    public void guardar(Cliente c) {
        String sql = "INSERT INTO clientes(nombre,email,telefono,direccion) VALUES(?,?,?,?)";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, c.getNombre());
            ps.setString(2, c.getEmail());
            ps.setString(3, c.getTelefono());
            ps.setString(4, c.getDireccion());
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Método listar actualizado con dirección
    public List<Cliente> listar() {
        List<Cliente> clientes = new ArrayList<>();
        String sql = "SELECT * FROM clientes";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Cliente cliente = new Cliente();
                cliente.setId(rs.getInt("id"));
                cliente.setNombre(rs.getString("nombre"));
                cliente.setEmail(rs.getString("email"));
                cliente.setTelefono(rs.getString("telefono"));
                cliente.setDireccion(rs.getString("direccion")); // ← Agregado
                clientes.add(cliente);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return clientes;
    }
}