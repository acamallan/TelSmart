<%@ page import="wAYA.Logout"%>
<%@include file="functions/was_function.jsp"%>
<%@include file="functions/classes.jsp"%>
<%
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
    <title>TelSMART - Unauthorized Access</title>
    
    <link href="<%= baseURL()%>styles/style.css" rel="stylesheet" type="text/css" media="all">
    
</head>
<body class="modal" >
    <div class="header">
	<div style="float:left;"><p style="font-size:20px; padding:10px; margin:0px; font-weight: bold; letter-spacing: 1px; ">Fin<span style="color:#000000;">SMART</span></p></div>
    </div>
    <p style="padding:250px; text-align: center">
    Unauthorized Access  <a href="<%= baseURL()%>index.jsp">Login again</a></p>
</body>
</html>