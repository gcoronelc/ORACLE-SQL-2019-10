package pe.egcc.eureka.service.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import pe.egcc.eureka.db.AccesoDB;
import pe.egcc.eureka.dto.ClienteDto;
import pe.egcc.eureka.service.espec.ClienteEspec;

public class ClienteService extends AbstractService implements ClienteEspec {

  @Override
  public List<ClienteDto> getClientes(String paterno, String materno, String nombre) {
    List<ClienteDto> lista = null;
    Connection cn = null;
    paterno = "%" + paterno.toUpperCase() + "%";
    materno = "%" + materno.toUpperCase() + "%";
    nombre = "%" + nombre.toUpperCase() + "%";
    try {
      cn = AccesoDB.getConnection();
      String sql = "select chr_cliecodigo, vch_cliepaterno, "
              + "vch_cliematerno, vch_clienombre, chr_cliedni, "
              + "vch_clieciudad, vch_cliedireccion, vch_clietelefono, "
              + "vch_clieemail from cliente "
              + "where upper(vch_cliepaterno) like ? "
              + "and upper(vch_cliematerno) like ? "
              + "and upper(vch_clienombre) like ? ";
      PreparedStatement pstm = cn.prepareStatement(sql);
      pstm.setString(1, paterno);
      pstm.setString(2, materno);
      pstm.setString(3, nombre);
      ResultSet rs = pstm.executeQuery();
      lista = mapper(rs);
      rs.close();
      pstm.close();
      this.setCodigo(1);
    } catch (Exception e) {
      this.setCodigo(-1);
      this.setMensaje(e.getMessage());
    } finally {
      try {
        cn.close();
      } catch (Exception e) {
      }
    }
    return lista;
  }

  private List<ClienteDto> mapper(ResultSet rs) throws SQLException {
    List<ClienteDto> lista = new ArrayList<>();
    while(rs.next()){
      ClienteDto dto = new ClienteDto();
      dto.setCodigo(rs.getString("CHR_CLIECODIGO"));
      dto.setPaterno(rs.getString("VCH_CLIEPATERNO"));
      dto.setMaterno(rs.getString("VCH_CLIEMATERNO"));
      dto.setNombre(rs.getString("VCH_CLIENOMBRE"));
      dto.setDni(rs.getString("CHR_CLIEDNI"));
      dto.setCiudad(rs.getString("VCH_CLIECIUDAD"));
      dto.setDireccion(rs.getString("VCH_CLIEDIRECCION"));
      dto.setTelefono(rs.getString("VCH_CLIETELEFONO"));
      dto.setEmail(rs.getString("VCH_CLIEEMAIL"));
      lista.add(dto);
    }
    return lista;
  }


}
