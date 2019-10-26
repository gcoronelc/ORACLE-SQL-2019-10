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
import pe.egcc.eureka.util.RptaJSON;

@WebServlet(name = "ClienteController", 
        urlPatterns = {"/TraerClientes"})
public class ClienteController extends HttpServlet {

  @Override
  protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // Datos
    String paterno = request.getParameter("paterno");
    String materno = request.getParameter("materno");
    String nombre = request.getParameter("nombre");
    // Proceso
    ClienteService clienteService = new ClienteService();
    List<ClienteDto> lista = clienteService.getClientes(paterno, materno, nombre);
    // Respuesta
    Gson gson = new Gson();
    RptaJSON rpta = new RptaJSON();
    if( clienteService.getCodigo() == 1){
      rpta.setCodigo(1);
      rpta.setMensaje(gson.toJson(lista));
    } else {
      rpta.setCodigo(-1);
      rpta.setMensaje(clienteService.getMensaje());
    }
    // Enviar respuesta
    UtilController.responseJson(response, rpta);
  }

  
  
}
