<%@page import="es.almerimatik.comerciales.Empresa"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="es.almerimatik.datos.Configuracion"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="check.jsp" %> 
<%
String error = request.getParameter("error");
boolean inicializa = false;
Empresa e = null;
int edit = -1;
    
    if ( error != null && (error.equals("1")) ){
        inicializa = true;
        error = ((Exception) session.getAttribute("error")).getMessage() ;
        e = (Empresa) session.getAttribute("empresa");
        session.removeAttribute("error");        
        session.removeAttribute("empresa");
    }
   else {
       try{
           edit = Integer.parseInt(request.getParameter("edit"));
           e = new Empresa();
           e.leer((new Configuracion()).conectar(), edit);
           inicializa = true;
       }
       catch(Exception errEd){
           edit = -1;
           e = null;
       }
   }

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Comerciales - Alta Nueva empresa.</title>
        <link rel="shortcut icon" href="./favicon.ico" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/estilos.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/forms.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/iconos.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/posicionamiento.css" />
        <script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
        <script type="text/javascript" src="js/jquery.validate.min.js"></script>
        <script type="text/javascript" src="js/additional-methods.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function(){
                $('#altaempresa').submit(function(){
                    if ( confirm("¿Estas Seguro?") ) return true;
                    else return false;
                });
                $('#altaempresa').validate({
                    rules:{                        
                        "nombre": {
                            "required": true,
                            "maxlength": 80
                        },
                        "direccion": {
                            "required": true,
                            "maxlength": 80 
                        },
                        "provincia":{
                            "required": true,
                            "maxlength": 30 
                        },
                        "poblacion":{
                            "required": true,
                            "maxlength": 30 
                        },                            
                        "cp":{
                               "required": true,
                               "digits": true,
                               "minlength": 5,
                               "maxlength": 5
                             },
                        "tlf": {
                               "required": true,
                               "digits": true,
                               "minlength": 9,
                               "maxlength": 9
                        },
                        "contacto":{maxlength: 50}
                        },
                   messages:{
                        "nombre": {
                            "required": "Debe de escribir el nombre de la empresa",
                            "maxlength": "El numero maximo de caracteres es 80"
                        },
                        "direccion": {
                            "required": "Debe escribir una direccion",
                            "maxlength": "Tamaño maximo de caracteres es 80."
                        },
                        "provincia":{
                            "required": "Debe de escribir la Provincia",
                            "maxlength": 30 
                        },
                        "poblacion":{
                            "required": "Debe de escribir la Población",
                            "maxlength": 30 
                        },                            
                        "cp":{
                               "required": "Debe de escribir un Codigo Postal",
                               "digits": "Solo se permiten numeros.",
                               "minlength": "Codigo postal no valido",
                               "maxlength": "Codigo postal no valido"
                             },
                        "tlf": {
                               "required": "Este campo es obligatorio",
                               "digits": "Telefono incorrecto",
                               "minlength": "Telefono incorrecto",
                               "maxlength": "Telefono incorrecto"
                        },
                        "contacto":{maxlength: "Numero maximo de caracteres es de 50",}                            
                        }
                    });                
            });
            function EnviarFormulario(){               
               if ( $("#altaempresa").valid() )   document.forms[0].submit();
            }
        </script>
                
    </head>
    <body>
        <div id="pagina">
            <jsp:directive.include file="header.jsp" />
            <div id="toolbar">      
                <div class="m_tootlbar">                    
                    <div id="toolbar_botones">
                        <ul>
                            <li>
                                <a href="#" onclick="EnviarFormulario();">
                                    <span class="icono-32-aceptar"></span>
                                    Aceptar
                                </a>
                            </li>
                            <li>
                                <a href="empresas.jsp">
                                    <span class="icono-32-cancelar"></span>
                                    Cancelar
                                </a>                                
                            </li>
                        </ul>
                        <div class="limpiar"></div>
                    </div>
                    <div class="toolbar_titulo icono-48-empresas">
                        <h2>Nueva Empresa</h2>
                    </div>                    
                </div>
            </div>
            <div id="content">
                <% if (inicializa && error != null && (!error.isEmpty()) ) { %>
                <div class="marcoError">
                    <p><%=error%></p>
                </div>
             <% }%>
             <form id="altaempresa" method="POST" action="<%
                    if ( e == null || e.getId() == -1 ) out.print("acciones/altaempresa.action.jsp");
                  else out.print("acciones/editarempresa.action.jsp");
                   
               %>">
               <% if ( e != null && e.getId() != -1 ){  %>
                   <input type="hidden" name="id" value="<%=e.getId()%>" />
                <% } %>
                <table class="altaEmpresa">
                    <tr>
                        <td width="130"><label>C.I.F.:</label></td>
                        <td><input type="text" name="cif" value="<%=inicializa ? e.getCif():""%>" /></td>
                    </tr>
                    <tr>
                        <td><label>Nombre:</label></td>
                        <td><input type="text" name="nombre" value="<%=inicializa ? e.getNombre():""%>" /></td>
                    </tr>
                    <tr>
                        <td><label>Direccion:</label></td>
                        <td><input type="text" name="direccion" value="<%=inicializa ? e.getDireccion():""%>"/></td>
                    </tr>
                    <tr>
                        <td><label>Provincia:</label></td>
                        <td><input type="text" name="provincia" value="<%=inicializa ? e.getProvincia():""%>"/></td>
                    </tr>
                    <tr>
                        <td><label>Población:</label></td>
                        <td><input type="text" name="poblacion" value="<%=inicializa ? e.getPoblacion():""%>"/></td>
                    </tr>
                    <tr>
                        <td><label>Cod.Postal:</label></td>
                        <td><input type="text" name="cp" value="<%=inicializa ? e.getCp():""%>"/></td>
                    </tr>
                    <tr>
                        <td><label>Telefono:</label></td>
                        <td><input type="text" name="tlf" value="<%=inicializa ? e.getTlf():""%>"/></td>
                    </tr>
                    <tr>
                        <td><label>Per.Contacto:</label></td>
                        <td><input type="text" name="contacto" value="<%=inicializa ? e.getContacto():""%>"/></td>
                    </tr>
                    <tr>
                        <td><label>Comercial :</label></td>
                        <td>
                            <select name="comercial">
                                <option value="-1">----Seleccione Comercial------</option>
                                <%
                                Configuracion conf = new Configuracion();
                                Connection cnt = conf.conectar();
                                Statement s = cnt.createStatement();
                                String sql = "SELECT * FROM usuarios ORDER BY apellidos,nombre";
                                ResultSet rs = s.executeQuery(sql);
                                while( rs.next()){
                                %>
                                <option value="<%=rs.getInt("id")%>">
                                    <%=rs.getString("apellidos") + " " + 
                                       rs.getString("nombre")%>
                                </option>
                                <%
                                }
                                %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><label>Fecha Alta:</label></td>
                        <td><input type="text" name="falta" readonly="readonly" 
                                   value="<%
                                   SimpleDateFormat fecha = new SimpleDateFormat("dd/MM/yyyy");
                                   out.print(fecha.format(new Date()));
                                            %>"/></td>
                    </tr>                                                            
                </table>
             </form>
            </div>
        </div>
            <jsp:directive.include file="pie.jsp" />
        
    </body>
</html>
