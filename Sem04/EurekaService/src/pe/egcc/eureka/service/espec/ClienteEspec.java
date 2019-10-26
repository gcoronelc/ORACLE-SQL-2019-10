package pe.egcc.eureka.service.espec;

import java.util.List;
import pe.egcc.eureka.dto.ClienteDto;

public interface ClienteEspec {
  
  List<ClienteDto> getClientes(String paterno, String materno, String nombre);
  
}
