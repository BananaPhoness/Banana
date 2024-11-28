/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

import java.sql.Timestamp;

/**
 *
 * @author moish
 */
public class Boleta {
    private int ID_Boleta;
    private int ID_Cita;
    private int ID_Perate;
    private Timestamp Fecha_Emision;
    private double Total;

    public int getID_Boleta() {
            return ID_Boleta;
        }
        public void setID_Boleta(int iD_Boleta) {
            this.ID_Boleta = iD_Boleta;
        }
        public int getID_Cita() {
            return ID_Cita;
        }
        public void setID_Cita(int iD_Cita) {
            this.ID_Cita = iD_Cita;
        }
        public int getID_Perate() {
            return ID_Perate;
        }
        public void setID_Perate(int iD_Perate) {
            this.ID_Perate = iD_Perate;
        }
        public Timestamp getFecha_Emision() {
            return Fecha_Emision;
        }
        public void setFecha_Emision(Timestamp fecha_Emision) {
            this.Fecha_Emision = fecha_Emision;
        }
        public double getTotal() {
            return Total;
        }
        public void setTotal(double total) {
            this.Total = total;
        }
    
}
