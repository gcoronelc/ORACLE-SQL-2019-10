package pe.egcc.eureka.service.impl;

public abstract class AbstractService {

  private int codigo;
  private String mensaje;

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
