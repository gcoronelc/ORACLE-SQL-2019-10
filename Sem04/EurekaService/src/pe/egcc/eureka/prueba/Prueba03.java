package pe.egcc.eureka.prueba;

import pe.egcc.eureka.service.impl.CuentaService;

public class Prueba03 {

  public static void main(String[] args) {
    CuentaService service = new CuentaService();
    double saldo = service.procRetiro("00100001", 10, "123456", "0005");
    System.out.println("Saldo: " + saldo);
    System.out.println("Rpta: " + service.getCodigo());
    System.out.println("Mensaje: " + service.getMensaje());
  }

}


