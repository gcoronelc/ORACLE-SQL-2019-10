package pe.egcc.eureka.prueba;

import pe.egcc.eureka.service.impl.CuentaService;

public class Prueba04 {

  public static void main(String[] args) {
    CuentaService service = new CuentaService();
    double saldo = service.traerSaldo("00100001");
    System.out.println("Saldo: " + saldo);
    System.out.println("Rpta: " + service.getCodigo());
    System.out.println("Mensaje: " + service.getMensaje());
  }

}
