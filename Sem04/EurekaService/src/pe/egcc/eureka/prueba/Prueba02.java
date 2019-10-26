package pe.egcc.eureka.prueba;

import java.util.List;
import pe.egcc.eureka.dto.ClienteDto;
import pe.egcc.eureka.service.impl.ClienteService;

public class Prueba02 {

  public static void main(String[] args) {
    ClienteService service = new ClienteService();
    List<ClienteDto> lista = service.getClientes("", "", "");
    if(service.getCodigo() == -1 ){
      System.err.println(service.getMensaje());
      return;
    }
    for (ClienteDto dto : lista) {
      System.out.println(dto.getNombre());
    }
  }

}
