package pe.egcc.eureka.controller;

import com.google.gson.Gson;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import pe.egcc.eureka.dto.ClienteDto;
import pe.egcc.eureka.service.impl.ClienteService;
import pe.egcc.eureka.service.impl.CuentaService;
import pe.egcc.eureka.util.RptaJSON;

@WebServlet(name = "CuentaController", 
        urlPatterns = {"/ProcRetiro","/TraerSaldo"})
public class CuentaController extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        switch(path){
            case "/ProcRetiro":
                procRetiro(request,response);
                break;
            case "/TraerSaldo":
                traerSaldo(request,response);
                break;
        }
    
    }

  protected void procRetiro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // Datos
    String cuenta = request.getParameter("cuenta");
    double importe = Double.parseDouble(request.getParameter("importe"));
    String clave = request.getParameter("clave");
    String empleado = "0005";
    // Proceso
    CuentaService cuentaService = new CuentaService();
    double saldo = cuentaService.procRetiro(cuenta, importe, clave, empleado);
    // Respuesta
    Gson gson = new Gson();
    RptaJSON rpta = new RptaJSON();
    if( cuentaService.getCodigo() == 1){
      rpta.setCodigo(1);
      rpta.setMensaje("<p>" + cuentaService.getMensaje() + "</p>"
              + "<p>Nuevo Saldo: " + saldo + "</p>");
    } else {
      rpta.setCodigo(-1);
      rpta.setMensaje(cuentaService.getMensaje());
    }
    // Enviar respuesta
    UtilController.responseJson(response, rpta);
  }

    private void traerSaldo(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Datos
    String cuenta = request.getParameter("cuenta");
    // Proceso
    CuentaService cuentaService = new CuentaService();
    double saldo = cuentaService.traerSaldo(cuenta);
    // Respuesta
    Gson gson = new Gson();
    RptaJSON rpta = new RptaJSON();
    if( cuentaService.getCodigo() == 1){
      rpta.setCodigo(1);
      rpta.setMensaje("" + saldo);
    } else {
      rpta.setCodigo(-1);
      rpta.setMensaje(cuentaService.getMensaje());
    }
    // Enviar respuesta
    UtilController.responseJson(response, rpta);
    }

  
  
}
