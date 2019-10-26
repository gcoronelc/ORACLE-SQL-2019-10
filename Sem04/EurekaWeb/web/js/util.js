function cargarPagina( pagina ){
  var divWork = $("#divWork");
  showEsperaAjax(divWork);
  $.get(pagina, function(response){
    divWork.html(response);
  });
}


function showEsperaAjax( objDiv){
  var html = "";
  html += "<div id='fountainG'>";
  html += "	<div id='fountainG_1' class='fountainG'></div>";
  html += "	<div id='fountainG_2' class='fountainG'></div>";
  html += "	<div id='fountainG_3' class='fountainG'></div>";
  html += "	<div id='fountainG_4' class='fountainG'></div>";
  html += "	<div id='fountainG_5' class='fountainG'></div>";
  html += "	<div id='fountainG_6' class='fountainG'></div>";
  html += "	<div id='fountainG_7' class='fountainG'></div>";
  html += "	<div id='fountainG_8' class='fountainG'></div>";
  html += "</div>";
  objDiv.html(html);
}

function mostrarTablaDesdeJson(arregloObjetos, divResultado, idTabla) {
    var campos = Object.keys(arregloObjetos[0]);
    crearTablaDesdeJson(campos, arregloObjetos, divResultado, idTabla);
}

function crearTablaDesdeJson(campos, json, divResultado, idTabla) {
    var nRegistros = json.length;
    var fila;
    var nCampos = campos.length;
    var col;
    var contenido = "<table id='" + idTabla + "'><thead><tr>";
    for (var j = 0; j < nCampos; j++) {
        col = campos[j];
        contenido += "<th>"; 
        contenido += col;
        contenido += "</th>";
    }
    contenido += "</tr></thead><tbody>";
    for (var i = 0; i < nRegistros; i++) {
        fila = json[i];
        contenido += "<tr>";
        for (var j = 0; j < nCampos; j++) {
            col = fila[campos[j]];
            contenido += "<td>";
            contenido += col;
            contenido += "</td>";
        }
        contenido += "</tr>";
    }
    contenido += "</tbody></table>";
    divResultado.html(contenido);
        
}


