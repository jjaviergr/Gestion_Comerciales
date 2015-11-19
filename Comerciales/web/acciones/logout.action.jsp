
<%
    session.removeAttribute("userId");
    session.removeAttribute("isLogin");
    response.sendRedirect("../login.jsp");
%>
