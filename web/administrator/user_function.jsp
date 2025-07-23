<%@page import="java.sql.*"%>
<%@include file="../functions/was_function.jsp"%>
<%@include file="../functions/classes.jsp"%>

<%! 
public String checkUsername(String username){
    try{
        Connection conn = DBConnection();

        PreparedStatement qrySelect = conn.prepareStatement("SELECT * from was_user_info where username='"+username+"'");
        ResultSet qryUser = qrySelect.executeQuery();
        qryUser.next();
        return qryUser.getString("username");
    } catch(Exception err){
        Logger("error", err.getMessage());
    }
 return null;
} 

%>

<%
if(request.getParameter("username_add") != null){
    out.println(checkUsername(request.getParameter("username_add")));
}
%>