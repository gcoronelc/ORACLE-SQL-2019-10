package pe.egcc.eureka.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class AccesoDB {

  private AccesoDB() {
  }

  public static Connection getConnection() throws SQLException {
    Connection cn = null;
    try {
      // Parámetros
      String driver = "oracle.jdbc.OracleDriver";
      String urlDB = "jdbc:oracle:thin:@localhost:1521/EGCC";
      String user = "eureka";
      String pass = "admin";
      // Cargar el driver
      Class.forName(driver).newInstance();
      // Establecer la conexión
      cn = DriverManager.getConnection(urlDB, user, pass);
    } catch (SQLException e) {
      throw e;
    } catch (ClassNotFoundException e) {
      throw new SQLException("No se ha encontrado el driver.");
    } catch (Exception e) {
      String msg = "Error, no se puede establecer la conexión.";
      if (e.getMessage() != null && !e.getMessage().isEmpty()) {
        msg += " " + e.getMessage();
      }
      throw new SQLException(msg);
    }
    return cn;
  }

}
