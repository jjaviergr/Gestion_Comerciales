<%@page import="es.almerimatik.comerciales.Empresa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../check.jsp" %>
<%
    String cif = request.getParameter("cif");
    Empresa emp = new Empresa();
    try{
        emp.leer(cif);
        response.sendRedirect("../nueva-empresa.jsp?edit="+ emp.getId());
    }
    catch(Exception e){
        response.sendRedirect("../empresas.jsp?error=4");
    }
%>