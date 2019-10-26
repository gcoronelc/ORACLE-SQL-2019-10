package pe.egcc.eureka.controller;

import com.google.gson.Gson;
import java.io.IOException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import pe.egcc.eureka.util.RptaJSON;

public  class UtilController {

  private UtilController() {
  }
  
  
  public static void responseJson(
          HttpServletResponse response,
          RptaJSON rpta ) throws IOException{
    //response.setContentType("text/plain");
    response.setContentType("application/json");
    ServletOutputStream out = response.getOutputStream();
    Gson gson = new Gson();
    out.println(gson.toJson(rpta));
    out.close();
    out.flush();
  }
}
