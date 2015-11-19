<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="check.jsp" %>
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
            <%@include file="header.jsp"%>
            <div id="toolbar">      
                <div class="m_tootlbar">                    
                    <div id="toolbar_botones">
                        <ul>
                            <li>
                                <a href="empresas.jsp">
                                    <span class="icono-32-empresas"></span>
                                    Empresas
                                </a>
                            </li>
                            <li>
                                <a href="visitas.jsp">
                                    <span class="icono-32-visitas"></span>
                                    Visitas
                                </a>                                
                            </li>
                            <li>
                                <a href="perfil.jsp">
                                    <span class="icono-32-perfil"></span>
                                    Perfil
                                </a>                                
                            </li>
                            <li>
                                <a href="acciones/logout.action.jsp">
                                    <span class="icono-32-salir"></span>
                                    Salir
                                </a>                                
                            </li>                            
                        </ul>
                        <div class="limpiar"></div>
                    </div>
                    <div class="toolbar_titulo icono-48-menu">
                        <h2>Menu Principal</h2>
                    </div>                    
                </div>
            </div>
            <div id="content">
                <h1>Bienvenido has conseguido entrar.</h1>
            </div>
        </div>
        <jsp:directive.include file="pie.jsp" />
        
    </body>
</html>
