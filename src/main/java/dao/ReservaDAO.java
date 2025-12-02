package dao;

import model.Reserva;
import com.mycompany.login.util.ConexionBD;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ReservaDAO {

    // INSERTAR una nueva reserva
    public void guardar(Reserva r) {
        String sql = "INSERT INTO reservas (cliente_id, paquete_id, fecha_reserva, numero_personas, estado) " +
                     "VALUES (?, ?, ?, ?, ?)";

        try (Connection cn = ConexionBD.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, r.getClienteId());
            ps.setInt(2, r.getPaqueteId());
            ps.setDate(3, Date.valueOf(r.getFechaReserva())); // LocalDate -> java.sql.Date
            ps.setInt(4, r.getNumeroPersonas());
            ps.setString(5, r.getEstado());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // LISTAR todas las reservas
    public List<Reserva> listar() {
        List<Reserva> reservas = new ArrayList<>();

        String sql = "SELECT id, cliente_id, paquete_id, fecha_reserva, numero_personas, estado " +
                     "FROM reservas";

        try (Connection cn = ConexionBD.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Reserva r = new Reserva();
                r.setId(rs.getInt("id"));
                r.setClienteId(rs.getInt("cliente_id"));
                r.setPaqueteId(rs.getInt("paquete_id"));

                Date fechaSql = rs.getDate("fecha_reserva");
                if (fechaSql != null) {
                    r.setFechaReserva(fechaSql.toLocalDate());
                }

                r.setNumeroPersonas(rs.getInt("numero_personas"));
                r.setEstado(rs.getString("estado"));

                reservas.add(r);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reservas;
    }

    // BUSCAR una reserva por ID
    public Reserva buscarPorId(int id) {
        Reserva r = null;

        String sql = "SELECT id, cliente_id, paquete_id, fecha_reserva, numero_personas, estado " +
                     "FROM reservas WHERE id = ?";

        try (Connection cn = ConexionBD.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    r = new Reserva();
                    r.setId(rs.getInt("id"));
                    r.setClienteId(rs.getInt("cliente_id"));
                    r.setPaqueteId(rs.getInt("paquete_id"));

                    Date fechaSql = rs.getDate("fecha_reserva");
                    if (fechaSql != null) {
                        r.setFechaReserva(fechaSql.toLocalDate());
                    }

                    r.setNumeroPersonas(rs.getInt("numero_personas"));
                    r.setEstado(rs.getString("estado"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return r;
    }

    // ACTUALIZAR una reserva existente
    public void actualizar(Reserva r) {
        String sql = "UPDATE reservas " +
                     "SET cliente_id = ?, paquete_id = ?, fecha_reserva = ?, " +
                     "    numero_personas = ?, estado = ? " +
                     "WHERE id = ?";

        try (Connection cn = ConexionBD.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, r.getClienteId());
            ps.setInt(2, r.getPaqueteId());
            ps.setDate(3, Date.valueOf(r.getFechaReserva()));
            ps.setInt(4, r.getNumeroPersonas());
            ps.setString(5, r.getEstado());
            ps.setInt(6, r.getId());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ELIMINAR una reserva
    public void eliminar(int id) {
        String sql = "DELETE FROM reservas WHERE id = ?";

        try (Connection cn = ConexionBD.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
