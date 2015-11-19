<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Comerciales - Iniciar Sesion.</title>
        <link rel="shortcut icon" href="./favicon.ico" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/estilos.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/forms.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/iconos.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/posicionamiento.css" />
    </head>
    <body>
        <div id="pagina">
            <div id="header">                
            </div>
            <div id="toolbar">      
                <div class="m_tootlbar">                    
                    <div id="toolbar_botones">
                        <ul>
                            
                        </ul>
                        <div class="limpiar"></div>
                    </div>
                    <div class="toolbar_titulo icono-48-login">
                        <h2>Iniciar Sesión</h2>
                    </div>                    
                </div>
            </div>
            <div id="content">                
                <form method="GET" action="acciones/login.action.jsp">
                    <table class="tablaLogin">
                        <thead>
                        </thead>
                        <tbody>
                            <tr>
                                <td><label>Usuario:</label></td>
                                <td><input type="text" name="usuario" /></td>
                            </tr>
                            <tr>
                                <td><label>Contraseña:</label></td>
                                <td><input type="password" name="pass" /></td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center"><input type="submit" value="Iniciar Sesión"</td>                                
                            </tr>                            
                        </tbody>
                        <tfoot></tfoot>
                    </table>
                </form>
                <%
                    String mensajeError;
                    if ( request.getParameter("error") != null){
                        int error = Integer.parseInt(request.getParameter("error")) ;
                        switch ( error ){
                           case 1:
                                mensajeError = "Debe escribir un usuario.";
                                break;
                            case 2:
                                mensajeError = "La contraseña no puede estar en blanco.";
                                break;
                            case 3:
                                mensajeError = "Usuario o contraseña incorrecta." ;
                                break;
                            case 4:
                                mensajeError = "No se puede conectar con la base de datos.";
                                break;
                            default:
                                mensajeError ="Error sin identificar";                                                                       
                        }                    
                %>
                        <div class="error">
                            <%=mensajeError%>
                        </div>
                <% 
                    }
                %>
                        
            </div>
        </div>
        <div id="pie">
            <div id="pie_izq">
                <h6>&copy; 2012</h6>
            </div>
            <div id="pie_dch">
                <h6>José A. Uclés</h6>
            </div>            
            <div class="limpiar"></div>
        </div>
        
    </body>
</html>
