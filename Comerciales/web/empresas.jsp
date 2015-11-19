<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="es.almerimatik.datos.Configuracion"%>
<%@page import="org.apache.tomcat.dbcp.pool.impl.GenericKeyedObjectPool.Config"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="es.almerimatik.comerciales.Empresa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="check.jsp" %>
<%
    ArrayList<Empresa> listado = new ArrayList<Empresa>();
    int pagina;
    try{
        pagina = Integer.parseInt(request.getParameter("pag"));
    }
    catch(NumberFormatException n){
        pagina = 0;
    }
    catch(Exception e){
        pagina = 0;
    }
    listado = Empresa.listado(pagina, 10);
    // OBTENEMOS EL NUMERO DE EMPRESAS
    Connection cnt = (new Configuracion()).conectar();
    Statement st = cnt.createStatement();
    ResultSet rs = st.executeQuery("SELECT count(id) from empresas");
    rs.next();            
    int nEmpresas = rs.getInt(1);
    int nPaginas = (nEmpresas / 10 );
    if ( nEmpresas % 10 != 0 ) nPaginas++;
    rs.close();
    st.close();
    cnt.close();
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Comerciales - Gestión de Empresas.</title>
        <link rel="shortcut icon" href="./favicon.ico" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/estilos.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/forms.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/iconos.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/posicionamiento.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/nyroModal.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/ui/jquery-ui-1.8.21.custom.css" />
        <script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>        
        <script type="text/javascript" src="js/jquery-ui-1.8.21.custom.min.js"></script>
        <script type="text/javascript" src="js/jquery.nyroModal.custom.min.js"></script>
        <script type="text/javascript" src="js/jquery.nyroModal-ie6.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function(){
               $(".nyroModal").nyroModal();
               $("input:submit").button();
               $("#frmBuscar").dialog({autoOpen:false, modal:true,resizable:false});
               <%
                if ( request.getParameter("error") != null &&
                     request.getParameter("error").equals("4") ) { %>
                 $("#error4").dialog({show: "Scale" , hide: "Flod", autoOpen: true, modal: true, width: 350, height: 'auto', resizable:false, 
                     buttons:{"Aceptar" : 
                                function(){
                                            $(this).dialog('close');
                                          }  
                              }
                          });
               <%}%>
            });
            function Confirmar(){
                return confirm('¿Estas seguro que deseas borrar la empresa?');
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
                                <a href="nueva-empresa.jsp">
                                    <span class="icono-32-add"></span>
                                    Añadir
                                </a>
                            </li>
                            <li>
                                <a href="#" onclick="$('#frmBuscar').dialog('open');">
                                    <span class="icono-32-buscar"></span>
                                    Buscar
                                </a>
                            </li>                            
                            <li>
                                <a href="menu.jsp">
                                    <span class="icono-32-volver"></span>
                                    Volver
                                </a>                                
                            </li>
                        </ul>
                        <div class="limpiar"></div>
                    </div>
                    <div class="toolbar_titulo icono-48-empresas">
                        <h2>Empresas</h2>
                    </div>                    
                </div>
            </div>
            <div id="content">
                <table class="listado">
                    <thead>
                        <tr>
                            <th style="display:none">Id</th>
                            <th width="80p">C.I.F.</th>
                            <th>Nombre</th>
                            <th width="80p">Tlf</th>
                            <th width="200p">Per.Contacto</th>
                            <th width="80p">Alta</th>
                            <th width="80p">Oper.</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(Empresa e : listado){ %>
                           <tr>
                               <td style="display:none"><%=e.getId()%></td>
                               <td><%=e.getCif()%></td>
                               <td><%=e.getNombre()%></td>
                               <td align="center"><%=e.getTlf()%></td>
                               <td><%=e.getContacto()%></td>
                               <td align="center"><% 
                               SimpleDateFormat fecha = new SimpleDateFormat("dd/MM/yyyy");
                               out.print(fecha.format(e.getFechaAlta().getTime())); %></td>
                               <td align="center">
                                   <a href="nueva-empresa.jsp?edit=<%=e.getId()%>">
                                       <img src="img/icono16/editar.png" alt="editar" title="Editar la empresa" />
                                   </a>
                                   <a href="acciones/borrarEmpresa.action.jsp?idEmpresa=<%=e.getId()%>" onclick="return Confirmar();">
                                       <img src="img/icono16/borrar.png" alt="editar" title="Borrar la empresa" />
                                   </a>
                                   <a class="nyroModal" href="verEmpresa.jsp?idEmpresa=<%=e.getId()%>">
                                       <img src="img/icono16/ver.png" alt="editar" title="Ver ficha de empresa" />
                                   </a>
                               </td>
                           </tr>
                        <% }
                        %>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="2">
                                <h5>NºEmpresas: <%=nEmpresas%></h5>
                            </td>
                            <td colspan="5">
                                <ul class="paginar">
                                    <% for (int i = nPaginas-1 ; i >= 0; i-- ){ %>
                                        <li><a href="empresas.jsp?pag=<%=i%>"><%=(i+1)%></a></li>
                                    <% } %>
                                </ul>                                
                                <span class="limpiar"></span>
                            </td>
                        </tr>
                    </tfoot>
                </table>
                <div class="limpiar"></div>
            </div>
        </div>
        <jsp:directive.include file="pie.jsp" />
<div id="frmBuscar" title="Buscar Empresa">
    <form method="POST" action="acciones/buscarEmpresa.action.jsp">
        <table style="padding: 20px">
            <tr>
                <td width="100">C.I.F.:</td>
                <td width="400"><input type="text" name="cif" /></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="Buscar Empresa"/>
                </td>
            </tr>

        </table>
    </form>
</div>
<%
 if ( request.getParameter("error") != null &&
    request.getParameter("error").equals("4") ) { %>
<div id="error4" title="Error al buscar">
<p class="ui-state-error ui-corner-all" 
    style="padding: 0.7em; font-size: 1.1em; text-align: center">
    No existe ninguna empresa con el C.I.F. facilitado
</p>    
</div>
<% } %>
    </body>
</html>
