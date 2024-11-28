/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package Interfaces;

import Modelo.Citas;
import Modelo.Especialidades;
import Modelo.Paciente;
import Modelo.Personaldeatencion;
import Modelo.Personalmedico;
import java.util.List;

/**
 *
 * @author moish
 */
public interface CRUD {
    
    public Personaldeatencion verificar(String DNI_Perate, int ID_Perate);
    public List listar();
    public Paciente InicioCSM(Integer Num_hist,String DNI_Pac);
    public List<Especialidades> listarEspecialidades();
    public boolean GenerarCita(Citas c);
    public boolean GenerarBoleta(Paciente pa);
    public boolean Filtrar1(Paciente pa);
    public Citas Citas(int ID_Cita);
    public boolean CancelarCita(int ID_Cita);
}
