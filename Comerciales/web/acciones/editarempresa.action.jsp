<%@page import="es.almerimatik.errores.CifRepetidoException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="es.almerimatik.comerciales.Usuarios"%>
<%@page import="es.almerimatik.comerciales.Empresa"%>
<%@page import="es.almerimatik.datos.Configuracion"%>
<%@include  file="../check.jsp" %> 

<%
    String cif = request.getParameter("cif");
    String nombreEmpresa = request.getParameter("nombre");
    String cp = request.getParameter("cp");
    String direccion = request.getParameter("direccion");
    String provincia = request.getParameter("provincia");
    String poblacion = request.getParameter("poblacion");
    String contacto = request.getParameter("contacto");
    int tlf,comercial,id;
    try{
        tlf = Integer.parseInt(request.getParameter("tlf"));
        comercial = Integer.parseInt(request.getParameter("comercial"));        
        id = Integer.parseInt(request.getParameter("id"));
    }
    catch(Exception e){
        tlf = 0;
        comercial = -1;
        id = -1;
    }
    Configuracion conf = new Configuracion();
    Connection cnt = conf.conectar();
    Usuarios com = new Usuarios("", "");
    com.leer(cnt, comercial);
    Empresa e = new Empresa();    
    e.leer(cnt, id);    
    e.setCif(cif);
    e.setComercial(com);
    e.setContacto(contacto);
    e.setCp(cp);
    e.setDireccion(direccion);
    e.setNombre(nombre);
    e.setPoblacion(poblacion);
    e.setProvincia(provincia);
    e.setTlf(tlf);
    try{
        e.guardar(conf);
        response.sendRedirect("../empresas.jsp");
    }
    catch( CifRepetidoException err){
        session.setAttribute("error", err);        
        session.setAttribute("empresa", e);
        response.sendRedirect("../nueva-empresa.jsp?error=1,edit="+id);
    }
    catch( Exception err){
        session.setAttribute("error", err);
        session.setAttribute("empresa", e);
        response.sendRedirect("../nueva-empresa.jsp?error=1,edit="+id);
    }
    finally{
        
    }
    
    
%>
