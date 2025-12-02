package model;

import java.time.LocalDate;

public class Reserva {
    
    private int id;
    private int clienteId;       // ID del cliente
    private int paqueteId;       // ID del paquete
    private LocalDate fechaReserva;
    private int numeroPersonas;
    private String estado;

    // GETTERS Y SETTERS

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public int getClienteId() {
        return clienteId;
    }
    public void setClienteId(int clienteId) {
        this.clienteId = clienteId;
    }

    public int getPaqueteId() {
        return paqueteId;
    }
    public void setPaqueteId(int paqueteId) {
        this.paqueteId = paqueteId;
    }

    public LocalDate getFechaReserva() {
        return fechaReserva;
    }
    public void setFechaReserva(LocalDate fechaReserva) {
        this.fechaReserva = fechaReserva;
    }

    public int getNumeroPersonas() {
        return numeroPersonas;
    }
    public void setNumeroPersonas(int numeroPersonas) {
        this.numeroPersonas = numeroPersonas;
    }

    public String getEstado() {
        return estado;
    }
    public void setEstado(String estado) {
        this.estado = estado;
    }
}
