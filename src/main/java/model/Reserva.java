package model;

import java.time.LocalDate;
import model.Paquete;

public class Reserva {
    private int id;
    private String clienteNombre;  // Nombre del cliente
    private Paquete paquete;       // Paquete reservado
    private LocalDate fecha;       // Fecha de reserva
    private int numeroPersonas;
    private String estado;

    // Getters y Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getClienteNombre() { return clienteNombre; }
    public void setClienteNombre(String clienteNombre) { this.clienteNombre = clienteNombre; }

    public Paquete getPaquete() { return paquete; }
    public void setPaquete(Paquete paquete) { this.paquete = paquete; }

    public LocalDate getFecha() { return fecha; }
    public void setFecha(LocalDate fecha) { this.fecha = fecha; }

    public int getNumeroPersonas() { return numeroPersonas; }
    public void setNumeroPersonas(int numeroPersonas) { this.numeroPersonas = numeroPersonas; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
}