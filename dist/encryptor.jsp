<%@include file="functions/was_function.jsp"%>
<%@include file="functions/classes.jsp"%>
<%
if(request.getParameter("text") != null){
    out.println(encrypt(request.getParameter("text")));
}
%>
<form action="">
    <input type="text" name="text">
    <input type="submit" value="Encrypt">
</form>