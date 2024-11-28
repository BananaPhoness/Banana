/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

import java.sql.Timestamp;
/**
 *
 * @author moish
 */public class Paciente {
    private int Num_hist;
    private String DNI_Pac;
    private String Nom_Pac;
    private String Ape_Pac;
    private Timestamp FechNac_Pac;
    private String Telef_Pac;
    private String Estad_Civil_Pac;
    private String Sex_Pac;
    private String Domicilio;
    private String Cod_Distr;

    public int getNum_hist() {
        return Num_hist;
    }

    public void setNum_hist(int Num_hist) {
        this.Num_hist = Num_hist;
    }

    public String getDNI_Pac() {
        return DNI_Pac;
    }

    public void setDNI_Pac(String DNI_Pac) {
        this.DNI_Pac = DNI_Pac;
    }

    public String getNom_Pac() {
        return Nom_Pac;
    }

    public void setNom_Pac(String Nom_Pac) {
        this.Nom_Pac = Nom_Pac;
    }

    public String getApe_Pac() {
        return Ape_Pac;
    }

    public void setApe_Pac(String Ape_Pac) {
        this.Ape_Pac = Ape_Pac;
    }

    public Timestamp getFechNac_Pac() {
        return FechNac_Pac;
    }

    public void setFechNac_Pac(Timestamp FechNac_Pac) {
        this.FechNac_Pac = FechNac_Pac;
    }

    public String getTelef_Pac() {
        return Telef_Pac;
    }

    public void setTelef_Pac(String Telef_Pac) {
        this.Telef_Pac = Telef_Pac;
    }

    public String getEstad_Civil_Pac() {
        return Estad_Civil_Pac;
    }

    public void setEstad_Civil_Pac(String Estad_Civil_Pac) {
        this.Estad_Civil_Pac = Estad_Civil_Pac;
    }

    public String getSex_Pac() {
        return Sex_Pac;
    }

    public void setSex_Pac(String Sex_Pac) {
        this.Sex_Pac = Sex_Pac;
    }

    public String getDomicilio() {
        return Domicilio;
    }

    public void setDomicilio(String Domicilio) {
        this.Domicilio = Domicilio;
    }

    public String getCod_Distr() {
        return Cod_Distr;
    }

    public void setCod_Distr(String Cod_Distr) {
        this.Cod_Distr = Cod_Distr;
    }
}
