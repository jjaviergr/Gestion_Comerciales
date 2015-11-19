<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Calendar"%>
<%@page import="es.almerimatik.comerciales.Usuarios"%>
<%
    
    String fUsuario = request.getParameter("usuario"); 
    String fPass = request.getParameter("pass");
    
    if ( fUsuario == null || fUsuario.isEmpty() ){
        response.sendRedirect("../login.jsp?error=1");
        return;
    }
    if ( fPass == null || fPass.isEmpty() ){
        response.sendRedirect("../login.jsp?error=2");        
        return;
    }    
    try{
        Class.forName("com.mysql.jdbc.Driver");
        String cadena = "jdbc:mysql://localhost/comercial";
        Connection cnt = DriverManager.getConnection(cadena,"comercial","aaa111...");
        Usuarios usr = Usuarios.load(fUsuario, cnt);
        if ( usr == null || (!usr.validar(fPass)) ){
            response.sendRedirect("../login.jsp?error=3");
            return;
        }
        session.setAttribute("userId", usr.getId() );
        session.setAttribute("isLogin", true);
        response.sendRedirect("../menu.jsp");
        return;
    }
    catch (Exception e){
        response.sendRedirect("../login.jsp?error=4");      
    }
    
%>
