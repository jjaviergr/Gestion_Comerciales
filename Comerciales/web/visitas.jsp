<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="check.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Comerciales - Gestión de Visitas.</title>
        <link rel="shortcut icon" href="./favicon.ico" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/estilos.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/forms.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/iconos.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/posicionamiento.css" />
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
                                    Botón
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <span class="icono-32-cancelar"></span>
                                    Botón
                                </a>                                
                            </li>
                        </ul>
                        <div class="limpiar"></div>
                    </div>
                    <div class="toolbar_titulo icono-48-login">
                        <h2>Iniciar Sesión</h2>
                    </div>                    
                </div>
            </div>
            <div id="content">
                
            </div>
        </div>
        <jsp:directive.include file="pie.jsp" />
        
    </body>
</html>
