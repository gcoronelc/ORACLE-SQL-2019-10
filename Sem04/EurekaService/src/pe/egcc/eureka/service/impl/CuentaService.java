package pe.egcc.eureka.service.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import pe.egcc.eureka.db.AccesoDB;
import pe.egcc.eureka.service.espec.CuentaEspec;

public class CuentaService extends AbstractService implements CuentaEspec {

    @Override
    public double procRetiro(String cuenta, double importe, String clave, String empleado) {
        Connection cn = null;
        String sql = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        int filas = 0;
        double saldo = 0;
        int contMov = 0;
        try {
            cn = AccesoDB.getConnection();
            cn.setAutoCommit(false);
            // Inicio del proceso       
            // Paso 1: Verificar saldo
            sql = "select dec_cuensaldo from cuenta "
                    + "where chr_cuencodigo = ? and chr_cuenclave = ? "
                    + "for update ";
            pstm = cn.prepareStatement(sql);
            pstm.setString(1, cuenta);
            pstm.setString(2, clave);
            rs = pstm.executeQuery();
            if (!rs.next()) {
                throw new Exception("Cuenta o clave no existe.");
            }
            saldo = rs.getDouble("dec_cuensaldo");
            if (saldo < importe) {
                throw new Exception("Saldo es insuficiente.");
            }
            rs.close();
            pstm.close();
            // Retardo: Solo para la demostracion de concurrencia
            Thread.currentThread().sleep(3000);
            // Actualizar el saldo
            saldo -= importe;
            sql = "update cuenta set dec_cuensaldo = ?, "
                    + "int_cuencontmov = int_cuencontmov + 1 "
                    + "where chr_cuencodigo = ? ";
            pstm = cn.prepareStatement(sql);
            pstm.setDouble(1, saldo);
            pstm.setString(2, cuenta);
            filas = pstm.executeUpdate();
            if (filas != 1) {
                throw new Exception("Error en el proceso, revisar los datos.");
            }
            pstm.close();
            // Leer el número de operación
            sql = "select int_cuencontmov from cuenta where chr_cuencodigo = ?";
            pstm = cn.prepareStatement(sql);
            pstm.setString(1, cuenta);
            rs = pstm.executeQuery();
            if (!rs.next()) {
                throw new Exception("Cuenta no existe.");
            }
            contMov = rs.getInt("int_cuencontmov");
            // Registrar el movimiento
            sql = "insert into movimiento(chr_cuencodigo,int_movinumero,"
                    + "dtt_movifecha,chr_emplcodigo,chr_tipocodigo,"
                    + "dec_moviimporte) values(?,?,SYSDATE,?,'004',?)";
            pstm = cn.prepareStatement(sql);
            pstm.setString(1, cuenta);
            pstm.setInt(2, contMov);
            pstm.setString(3, empleado);
            pstm.setDouble(4, importe);
            pstm.executeUpdate();
            // Fin del proceso
            cn.commit();
            this.setCodigo(1);
            this.setMensaje("La operación de retiro se ejecuto correctamente.");
        } catch (Exception e) {
            try {
                cn.rollback();
            } catch (Exception e1) {
            }
            this.setCodigo(-1);
            this.setMensaje(e.getMessage());
        } finally {
            try {
                cn.close();
            } catch (Exception e) {
            }
        }
        return saldo;
    }

    @Override
    public double traerSaldo(String cuenta) {
        Connection cn = null;
        String sql = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        double saldo = 0;
        try {
            cn = AccesoDB.getConnection();
            sql = "select dec_cuensaldo from cuenta "
                    + "where chr_cuencodigo = ? ";
            pstm = cn.prepareStatement(sql);
            pstm.setString(1, cuenta);
            rs = pstm.executeQuery();
            if (!rs.next()) {
                throw new Exception("Cuenta no existe.");
            }
            saldo = rs.getDouble("dec_cuensaldo");
            rs.close();
            pstm.close();
            this.setCodigo(1);
            this.setMensaje("La consulta se ejecuto correctamente.");
        } catch (Exception e) {
            this.setCodigo(-1);
            this.setMensaje(e.getMessage());
        } finally {
            try {
                cn.close();
            } catch (Exception e) {
            }
        }
        return saldo;
    }

}
