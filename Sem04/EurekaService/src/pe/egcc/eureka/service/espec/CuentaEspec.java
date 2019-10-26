package pe.egcc.eureka.service.espec;

public interface CuentaEspec {

    double traerSaldo(String cuenta);

    double procRetiro(String cuenta, double importe, String clave, String empleado);

}
