
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="es.almerimatik.datos.Configuracion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="check.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Comerciales - Modificar Perfil Usuario</title>
        <link rel="shortcut icon" href="./favicon.ico" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/estilos.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/forms.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/iconos.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/posicionamiento.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/nyroModal.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/ui/jquery-ui-1.8.21.custom.css" />
        <script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>        
        <script type="text/javascript" src="js/jquery-ui-1.8.21.custom.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function(){                
               $("#fnac").datepicker({ dateFormat: "dd/mm/yy", 
               dayNames: ["Domingo,Lunes,Martes,Miercoles,Jueves,Viernes,Sabado"],
               dayNamesShort: ["Dom","Lun","Mar","Mie","Jue","Vie","Sab"],
               dayNamesMin: ["Do","Lu","Ma","Mi","Ju","Vi","Sa"],
               monthNames: ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"],
               monthNamesShort: ["Ene","Feb","Mar","Abr","May","Jun","Jul","Ago","Sep","Oct","Nov","Dic"],
               changeMonth: true,
               changeYear: true,
               firstDay: 1
           });
            });
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
                                <a href="#">
                                    <span class="icono-32-aceptar"></span>
                                    Aceptar
                                </a>
                            </li>
                            <li>
                                <a href="menu.jsp">
                                    <span class="icono-32-cancelar"></span>
                                    Cancelar
                                </a>                                
                            </li>
                        </ul>
                        <div class="limpiar"></div>
                    </div>
                    <div class="toolbar_titulo icono-48-comercial">
                        <h2>Perfil de usuario</h2>
                    </div>                    
                </div>
            </div>
            <div id="content">
                <form id="perfil" method="POST" action="acciones/perfil.action.jsp">                    
                <table class="altaEmpresa">
                    <tr>
                        <td width="180"><label>Nombre Usuario:</label></td>
                        <td><input type="text" name="username" readonly="readonly" value="<%=usr.getUserName()%>" /></td>
                    </tr>
                    <tr>
                        <td><label>Nombre:</label></td>
                        <td><input type="text" name="nombre" value="<%=usr.nombre%>" /></td>
                    </tr>
                    <tr>
                        <td><label>Apellidos:</label></td>
                        <td><input type="text" name="direccion" value="<%=usr.apellidos%>"/></td>
                    </tr>                    
                    <tr>
                        <td><label>Fecha Nacimiento:</label></td>
                        <td><input id="fnac" type="text" name="fnac"  
                                   value="<%
                                   SimpleDateFormat fecha = new SimpleDateFormat("dd/MM/yyyy");
                                   out.print(fecha.format(usr.getFechaNacimiento().getTime()));
                                            %>"/>
                        </td>
                    </tr>
                    <tr>
                        <td><label>Ultimo Acceso:</label></td>
                        <td>
                            <input type="text" name="fu" readonly="readonly" value="<%=usr.getUltimoAcceso()%>"/>
                        </td>
                    </tr>
                    <tr>
                        <td><label>Contraseña:</label></td>
                        <td><input type="password" name="pass" value="<%=usr.getPassword()%>"/></td>
                    </tr>
                    <tr>
                        <td><label>Repetir Contraseña:</label></td>
                        <td><input type="password" name="repass" value="<%=usr.getPassword()%>"/></td>
                    </tr>                  
                </table>
             </form>                
            </div>
        </div>
        <jsp:directive.include file="pie.jsp" />
        
    </body>
</html>
