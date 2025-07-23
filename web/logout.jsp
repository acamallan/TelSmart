<%@ page import="wAYA.Logout"%>
<%@include file="functions/was_function.jsp"%>
<%@include file="functions/classes.jsp"%>
<%
if(session.getAttribute("userid") == null) {  
    response.sendRedirect(baseURL()+"index.jsp");
    return;
}

Connection conn = DBConnection();
new Logout((Integer)session.getAttribute("userid"),conn);
session.invalidate();
%>


<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="Cache-control" content="no-cache">
    <meta http-equiv="Expires" content="-1">
    <title>System Logout</title>
    
    <link href="<%= baseURL()%>styles/style.css" rel="stylesheet" type="text/css" media="all">
    <script type="text/javascript" src="<%= baseURL()%>scripts/jquery_1.9.1.js"></script>
    <script type="text/javascript" src="<%= baseURL()%>scripts/jquery-idleTimeout.js"></script>
    <script type="text/javascript" src="<%= baseURL()%>scripts/store.min.js"></script>
    <% 
    String msg = "";    
    if(request.getParameter("logout") != null){
        msg = "You successfully logout.";
    %>
        <script> sessionStorage.setItem('logout', true); </script>
    <%
    } else {
        msg = "Session expired.";
    }
    %>
    <script>
        $(function() {
            sessionStorage.setItem('logout', true);
            $.fn.idleTimeout().logout();
        });
        </script>
</head>
<body class="modal" >
    <div class="header">
	<div style="float:left;"><p style="font-size:20px; padding:10px; margin:0px; font-weight: bold; letter-spacing: 1px; ">Fin<span style="color:#000000;">SMART</span></p></div>
    </div>
    <p style="padding:250px; text-align: center">
    <%= msg %> <a href="<%= baseURL()%>index.jsp">Login again</a></p>
</body>
</html>