package dao;

import model.Reserva;
import model.Paquete;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ReservaDAO {

    private Conexion conexion = new Conexion();

    // Guardar una nueva reserva
    public void guardar(Reserva r) {
        String sql = "INSERT INTO reservas(cliente_nombre, paquete_id, fecha, numero_personas, estado) VALUES(?,?,?,?,?)";

        try (Connection conn = conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, r.getClienteNombre());           // Nombre del cliente
            ps.setInt(2, r.getPaquete().getId());           // ID del paquete
            ps.setDate(3, Date.valueOf(r.getFecha()));      // LocalDate -> java.sql.Date
            ps.setInt(4, r.getNumeroPersonas());
            ps.setString(5, r.getEstado());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Listar todas las reservas
    public List<Reserva> listar() {
        List<Reserva> reservas = new ArrayList<>();
        String sql = "SELECT r.id, r.cliente_nombre, r.paquete_id, r.fecha, r.numero_personas, r.estado, " +
                     "p.nombre AS paquete_nombre, p.destino AS paquete_destino, p.imagen_url AS paquete_imagen " +
                     "FROM reservas r " +
                     "LEFT JOIN paquetes p ON r.paquete_id = p.id";

        try (Connection conn = conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Reserva r = new Reserva();
                r.setId(rs.getInt("id"));
                r.setClienteNombre(rs.getString("cliente_nombre"));
                r.setFecha(rs.getDate("fecha").toLocalDate());
                r.setNumeroPersonas(rs.getInt("numero_personas"));
                r.setEstado(rs.getString("estado"));

                // Crear objeto Paquete
                Paquete p = new Paquete();
                p.setId(rs.getInt("paquete_id"));
                p.setNombre(rs.getString("paquete_nombre"));
                p.setDestino(rs.getString("paquete_destino"));
                p.setImagenUrl(rs.getString("paquete_imagen"));
                r.setPaquete(p);

                reservas.add(r);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reservas;
    }

    // Buscar una reserva por ID
    public Reserva buscarPorId(int id) {
        Reserva r = null;
        String sql = "SELECT r.id, r.cliente_nombre, r.paquete_id, r.fecha, r.numero_personas, r.estado, " +
                     "p.nombre AS paquete_nombre, p.destino AS paquete_destino, p.imagen_url AS paquete_imagen " +
                     "FROM reservas r " +
                     "LEFT JOIN paquetes p ON r.paquete_id = p.id " +
                     "WHERE r.id = ?";

        try (Connection conn = conexion.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    r = new Reserva();
                    r.setId(rs.getInt("id"));
                    r.setClienteNombre(rs.getString("cliente_nombre"));
                    r.setFecha(rs.getDate("fecha").toLocalDate());
                    r.setNumeroPersonas(rs.getInt("numero_personas"));
                    r.setEstado(rs.getString("estado"));

                    Paquete p = new Paquete();
                    p.setId(rs.getInt("paquete_id"));
                    p.setNombre(rs.getString("paquete_nombre"));
                    p.setDestino(rs.getString("paquete_destino"));
                    p.setImagenUrl(rs.getString("paquete_imagen"));
                    r.setPaquete(p);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return r;
    }
}