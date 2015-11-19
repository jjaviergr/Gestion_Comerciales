<%@page import="es.almerimatik.datos.Configuracion"%>
<%@page import="es.almerimatik.comerciales.Empresa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../check.jsp" %>
<%
    int idEmpresa ;
    Empresa emp ;
    try{
         idEmpresa = Integer.parseInt(request.getParameter("idEmpresa"));
         emp = new Empresa();
         emp.leer((new Configuracion()).conectar(), idEmpresa);
         emp.borrar(new Configuracion());         
    }
    catch( Exception e){
        idEmpresa = -1;
        emp = null;
    }
    response.sendRedirect("../empresas.jsp");
  
%>
