<%@page import="java.text.SimpleDateFormat"%>
<%@page import="es.almerimatik.datos.Configuracion"%>
<%@page import="es.almerimatik.comerciales.Empresa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="check.jsp" %>
<%
    int idEmpresa ;
    Empresa emp ;
    try{
         idEmpresa = Integer.parseInt(request.getParameter("idEmpresa"));
         emp = new Empresa();
         emp.leer((new Configuracion()).conectar(), idEmpresa);          
    }
    catch( Exception e){
        idEmpresa = -1;
        emp = null;
    }
  
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ficha Empresa</title>
        <link rel="stylesheet" type="text/css" media="screen" href="css/estilos.css" />
    </head>
    <body>
        <% if ( emp != null ){ %>
            <h2>Ficha Empresa</h2>
            <ul class="fichaEmpresa">
                <li><strong>C.I.F.: </strong> <%=emp.getCif()%></li>
                <li><strong>Nombre: </strong> <%=emp.getNombre()%></li>
                <li><strong>Dirección </strong> <%=emp.getDireccion() %></li>
                <li><strong>Provincia: </strong> <%=emp.getProvincia()%></li>
                <li><strong>Población: </strong> <%=emp.getPoblacion()%></li>
                <li><strong>Cod.Postal: </strong> <%=emp.getCp()%></li>
                <li><strong>Telefono: </strong> <%=emp.getTlf()%></li>
                <li><strong>Contacto: </strong> <%=emp.getContacto()%></li>
                <li><strong>Alta: </strong> <%
                SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
                out.print(formato.format(emp.getFechaAlta().getTime()));
                %></li>
                <li><strong>Comercial: </strong> <%=emp.getComercial().getUserName() %></li>
            </ul>
        <% }
              else %> <h2>Empresa no existente.</h2>
    </body>
</html>
