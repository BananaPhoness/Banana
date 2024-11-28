package ModeloDAO;

import Config.Conexion;
import Interfaces.CRUD;
import Modelo.Citas;
import Modelo.Especialidades;
import Modelo.Paciente;
import Modelo.Personaldeatencion;
import Modelo.Personalmedico;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * Implementación del CRUD utilizando múltiples tablas
 */
public class ModeloDAO implements CRUD {

    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    private static String nombrePersonalActual;

    @Override
    public Personaldeatencion verificar(String DNI_Perate, int ID_Perate) {
        Personaldeatencion personal = null;
        String sql = "SELECT * FROM personaldeatencion WHERE DNI_Perate = ? AND ID_Perate = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, DNI_Perate);
            ps.setInt(2, ID_Perate);
            rs = ps.executeQuery();

            if (rs.next()) {
                personal = new Personaldeatencion();
                personal.setID_Perate(rs.getInt("ID_Perate"));
                personal.setNombre(rs.getString("Nombre"));
                personal.setApellido(rs.getString("Apellido"));
                personal.setDNI_Perate(rs.getString("DNI_Perate"));

                nombrePersonalActual = personal.getNombre(); // Asignar nombre
            } else {
                System.out.println("No se encontró el usuario con DNI y contraseña proporcionados.");
            }
        } catch (Exception e) {
            System.err.println("Error en verificar: " + e.getMessage());
        } finally {
            closeResources();
        }
        return personal;
    }

    // Método para obtener el nombre del personal actual
    public static String getNombrePersonalActual() {
        return nombrePersonalActual;
    }

    @Override
    public List<Paciente> listar() {
        List<Paciente> lista = new ArrayList<>();
        String sql = "SELECT * FROM Paciente";
        try {
            con = cn.getConnection(); // Conexión a la base de datos
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Paciente paciente = new Paciente(); // Constructor vacío
                paciente.setNum_hist(rs.getInt("Num_hist"));
                paciente.setDNI_Pac(rs.getString("DNI_Pac"));
                paciente.setNom_Pac(rs.getString("Nom_Pac"));
                paciente.setApe_Pac(rs.getString("Ape_Pac"));
                paciente.setFechNac_Pac(rs.getTimestamp("FechNac_Pac"));
                paciente.setTelef_Pac(rs.getString("Telef_Pac"));
                paciente.setEstad_Civil_Pac(rs.getString("Estad_Civil_Pac"));
                paciente.setSex_Pac(rs.getString("Sex_Pac"));
                paciente.setDomicilio(rs.getString("Domicilio"));
                paciente.setCod_Distr(rs.getString("Cod_Distr"));
                lista.add(paciente); // Agregar el paciente a la lista
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(); // Cerrar los recursos
        }
        return lista; // Devolver la lista de pacientes
    }

    @Override
    public Paciente InicioCSM(Integer Num_hist, String DNI_Pac) {
        Paciente paciente = null; // Inicializa como null
        StringBuilder sql = new StringBuilder("SELECT * FROM Paciente WHERE "); // Inicio del SQL
        boolean hasNumHist = (Num_hist != null);
        boolean hasDniPac = (DNI_Pac != null && !DNI_Pac.trim().isEmpty());

        // Construir la consulta SQL condicionalmente
        if (hasNumHist) {
            sql.append("Num_hist = ? ");
        }
        if (hasDniPac) {
            if (hasNumHist) {
                sql.append("OR "); // Añadir OR si ambos están presentes
            }
            sql.append("DNI_Pac = ? ");
        }

        // Validar que al menos uno de los parámetros sea válido
        if (!hasNumHist && !hasDniPac) {
            System.err.println("Error: Debe proporcionar al menos un parámetro válido (Num_hist o DNI_Pac).");
            return null;
        }

        try {
            con = cn.getConnection(); // Conexión a la base de datos
            ps = con.prepareStatement(sql.toString());

            // Asignar los parámetros condicionalmente
            int index = 1;
            if (hasNumHist) {
                ps.setInt(index++, Num_hist);
            }
            if (hasDniPac) {
                ps.setString(index, DNI_Pac);
            }

            rs = ps.executeQuery();
            if (rs.next()) {
                // Usar constructor vacío y setters para asignar valores
                paciente = new Paciente();
                paciente.setNum_hist(rs.getInt("Num_hist"));
                paciente.setDNI_Pac(rs.getString("DNI_Pac"));
                paciente.setNom_Pac(rs.getString("Nom_Pac"));
                paciente.setApe_Pac(rs.getString("Ape_Pac"));
                paciente.setFechNac_Pac(rs.getTimestamp("FechNac_Pac"));
                paciente.setTelef_Pac(rs.getString("Telef_Pac"));
                paciente.setEstad_Civil_Pac(rs.getString("Estad_Civil_Pac"));
                paciente.setSex_Pac(rs.getString("Sex_Pac"));
                paciente.setDomicilio(rs.getString("Domicilio"));
                paciente.setCod_Distr(rs.getString("Cod_Distr"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(); // Liberar recursos
        }
        return paciente; // Devuelve el objeto o null si no se encuentra
    }

    @Override
    public List<Especialidades> listarEspecialidades() {
        List<Especialidades> lista = new ArrayList<>();
        String sql = "SELECT * FROM especialidades"; // SQL para obtener todas las especialidades
        try {
            con = cn.getConnection(); // Conexión a la base de datos
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Especialidades especialidad = new Especialidades(); // Crear un nuevo objeto especialidad
                especialidad.setID_Espec(rs.getString("ID_Espec"));
                especialidad.setNom_Espec(rs.getString("Nom_Espec"));
                lista.add(especialidad); // Añadir la especialidad a la lista
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(); // Liberar los recursos
        }
        return lista; // Devolver la lista de especialidades
    }

    @Override
    public boolean GenerarCita(Citas c) {
        String sql = "INSERT INTO Citas (Num_hist, ID_Per, ID_Espec, Fecha, Alergias, Enfermedad_Cronica, Sintomas) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);

            // Establecer los parámetros en la consulta
            ps.setInt(1, c.getNum_hist());  // Número de historia del paciente
            ps.setInt(2, c.getID_Per());    // ID del médico (de la instancia de Personalmedico)
            ps.setString(3, c.getID_Espec()); // ID de la especialidad (de la instancia de Especialidades)
            ps.setTimestamp(4, c.getFecha());
            ps.setString(5, c.getAlergias());   // Alergias del paciente
            ps.setString(6, c.getEnfermedad_Cronica()); // Enfermedad crónica del paciente
            ps.setString(7, c.getSintomas());    // Sintomas reportados

            ps.executeUpdate(); // Ejecutar la inserción de la cita
            return true;
        } catch (Exception e1) {
            e1.printStackTrace();
        } finally {
            closeResources(); // Cerrar recursos
        }
        return false;
    }

    @Override
    public boolean GenerarBoleta(Paciente pa) {
        return false; // Placeholder
    }

    @Override
    public boolean Filtrar1(Paciente pa) {
        return false; // Placeholder
    }

    @Override
    public Citas Citas(int ID_Cita) {
        Citas cita = null;
        String sql = "SELECT * FROM Citas WHERE ID_Cita = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, ID_Cita);
            rs = ps.executeQuery();
            if (rs.next()) {
                cita = new Citas(
                        rs.getInt("ID_Cita"),
                        rs.getInt("Num_hist"),
                        rs.getInt("ID_Per"),
                        rs.getString("ID_Espec"),
                        rs.getTimestamp("Fecha"),
                        rs.getString("Alergias"),
                        rs.getString("Enfermedad_Cronica"),
                        rs.getString("Sintomas")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return cita;
    }

    @Override
    public boolean CancelarCita(int ID_Cita) {
        String sql = "DELETE FROM Citas WHERE ID_Cita = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, ID_Cita);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return false;
    }

    private void closeResources() {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
