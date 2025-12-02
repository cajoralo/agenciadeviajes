package dao;

import model.Paquete;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import com.mycompany.login.util.ConexionBD;
import java.sql.Connection;

public class PaqueteDAO {

    

    // Listar todos los paquetes
    public List<Paquete> listar() {
        List<Paquete> paquetes = new ArrayList<>();
        String sql = "SELECT * FROM paquetes ORDER BY id";

        Connection cn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Paquete p = new Paquete();
                p.setId(rs.getInt("id"));
                p.setNombre(rs.getString("nombre"));
                p.setDestino(rs.getString("destino"));
                p.setPrecio(rs.getBigDecimal("precio"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setDuracionDias(rs.getInt("duracion_dias"));
                p.setDisponible(rs.getBoolean("disponible"));
                p.setImagenUrl(rs.getString("imagen_url"));
                p.setFechaCreacion(rs.getTimestamp("fecha_creacion").toLocalDateTime());
                paquetes.add(p);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return paquetes;
    }

    // Listar paquetes disponibles
    public List<Paquete> listarDisponibles() {
        List<Paquete> paquetes = new ArrayList<>();
        String sql = "SELECT * FROM paquetes WHERE disponible = true ORDER BY id";

        Connection cn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Paquete p = new Paquete();
                p.setId(rs.getInt("id"));
                p.setNombre(rs.getString("nombre"));
                p.setDestino(rs.getString("destino"));
                p.setPrecio(rs.getBigDecimal("precio"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setDuracionDias(rs.getInt("duracion_dias"));
                p.setDisponible(rs.getBoolean("disponible"));
                p.setImagenUrl(rs.getString("imagen_url"));
                p.setFechaCreacion(rs.getTimestamp("fecha_creacion").toLocalDateTime());
                paquetes.add(p);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return paquetes;
    }

    // Buscar paquete por ID
    public Paquete buscarPorId(int id) {
        Paquete p = null;
        String sql = "SELECT * FROM paquetes WHERE id = ?";

        Connection cn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    p = new Paquete();
                    p.setId(rs.getInt("id"));
                    p.setNombre(rs.getString("nombre"));
                    p.setDestino(rs.getString("destino"));
                    p.setPrecio(rs.getBigDecimal("precio"));
                    p.setDescripcion(rs.getString("descripcion"));
                    p.setDuracionDias(rs.getInt("duracion_dias"));
                    p.setDisponible(rs.getBoolean("disponible"));
                    p.setImagenUrl(rs.getString("imagen_url"));
                    p.setFechaCreacion(rs.getTimestamp("fecha_creacion").toLocalDateTime());
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return p;
    }

    // Guardar nuevo paquete
    public void guardar(Paquete p) {
        String sql = "INSERT INTO paquetes(nombre, destino, precio, descripcion, duracion_dias, disponible, imagen_url, fecha_creacion) " +
                     "VALUES(?,?,?,?,?,?,?,?)";

        Connection cn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDestino());
            ps.setBigDecimal(3, p.getPrecio());
            ps.setString(4, p.getDescripcion());
            ps.setInt(5, p.getDuracionDias());
            ps.setBoolean(6, p.isDisponible());
            ps.setString(7, p.getImagenUrl());
            ps.setTimestamp(8, Timestamp.valueOf(LocalDateTime.now())); // Fecha de creación actual

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Actualizar paquete
    public void actualizar(Paquete p) {
        String sql = "UPDATE paquetes SET nombre=?, destino=?, precio=?, descripcion=?, duracion_dias=?, disponible=?, imagen_url=? WHERE id=?";

        Connection cn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDestino());
            ps.setBigDecimal(3, p.getPrecio());
            ps.setString(4, p.getDescripcion());
            ps.setInt(5, p.getDuracionDias());
            ps.setBoolean(6, p.isDisponible());
            ps.setString(7, p.getImagenUrl());
            ps.setInt(8, p.getId());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
