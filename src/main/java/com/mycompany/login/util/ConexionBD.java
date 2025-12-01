package com.mycompany.login.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {

    private static final String URL = "jdbc:postgresql://localhost:5432/agencia_viajes";
    private static final String USER = "postgres";
    private static final String PASSWORD = "1234";

    public static Connection getConnection() {
        Connection cn = null;
        try {
            Class.forName("org.postgresql.Driver");
            cn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Conexión exitosa a PostgreSQL");
        } catch (ClassNotFoundException e) {
            System.out.println("No se encontró el driver: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("Error al conectar: " + e.getMessage());
        }
        return cn;
    }
}
