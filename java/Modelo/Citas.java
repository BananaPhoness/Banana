/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;
import java.sql.Timestamp;

public class Citas {
    private int ID_Cita;
    private int Num_hist;
    private int ID_Per;
    private String ID_Espec;
    private Timestamp Fecha;
    private String Alergias;
    private String Enfermedad_Cronica;
    private String Sintomas;

    // Constructor vacío
    public Citas() {}

    // Constructor con parámetros
    public Citas(int ID_Cita, int Num_hist, int ID_Per, String ID_Espec, Timestamp Fecha,
                 String Alergias, String Enfermedad_Cronica, String Sintomas) {
        this.ID_Cita = ID_Cita;
        this.Num_hist = Num_hist;
        this.ID_Per = ID_Per;
        this.ID_Espec = ID_Espec;
        this.Fecha = Fecha;
        this.Alergias = Alergias;
        this.Enfermedad_Cronica = Enfermedad_Cronica;
        this.Sintomas = Sintomas;
    }

    // Getters y Setters
    public int getID_Cita() {
        return ID_Cita;
    }

    public void setID_Cita(int ID_Cita) {
        this.ID_Cita = ID_Cita;
    }

    public int getNum_hist() {
        return Num_hist;
    }

    public void setNum_hist(int Num_hist) {
        this.Num_hist = Num_hist;
    }

    public int getID_Per() {
        return ID_Per;
    }

    public void setID_Per(int ID_Per) {
        this.ID_Per = ID_Per;
    }

    public String getID_Espec() {
        return ID_Espec;
    }

    public void setID_Espec(String ID_Espec) {
        this.ID_Espec = ID_Espec;
    }

    public Timestamp getFecha() {
        return Fecha;
    }

    public void setFecha(Timestamp Fecha) {
        this.Fecha = Fecha;
    }

    public String getAlergias() {
        return Alergias;
    }

    public void setAlergias(String Alergias) {
        this.Alergias = Alergias;
    }

    public String getEnfermedad_Cronica() {
        return Enfermedad_Cronica;
    }

    public void setEnfermedad_Cronica(String Enfermedad_Cronica) {
        this.Enfermedad_Cronica = Enfermedad_Cronica;
    }

    public String getSintomas() {
        return Sintomas;
    }

    public void setSintomas(String Sintomas) {
        this.Sintomas = Sintomas;
    }
}