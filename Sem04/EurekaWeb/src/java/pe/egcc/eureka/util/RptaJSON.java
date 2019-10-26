package pe.egcc.eureka.util;

public class RptaJSON {

  private int codigo;
  private String mensaje;

  public RptaJSON() {
  }

  public RptaJSON(int codigo, String mensaje) {
    this.codigo = codigo;
    this.mensaje = mensaje;
  }

  public int getCodigo() {
    return codigo;
  }

  public void setCodigo(int codigo) {
    this.codigo = codigo;
  }

  public String getMensaje() {
    return mensaje;
  }

  public void setMensaje(String mensaje) {
    this.mensaje = mensaje;
  }

}
