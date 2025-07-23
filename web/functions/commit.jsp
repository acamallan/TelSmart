<%@include file="was_function.jsp"%>
<%@include file="classes.jsp"%>

<%!
public void InitializeCommit(){
    try{
        Connection conn = DBConnection();
        conn.setAutoCommit(false);
    }catch(SQLException se){
    }
}  

public void Rollback(){
    try{
        Connection conn = DBConnection();
        conn.rollback();
    }catch(SQLException se){
    }
} 

public void Commit(){
    try{
        Connection conn = DBConnection();
        conn.commit();
        conn.close();
    }catch(SQLException se){
    }
} 

%>

<%
if(request.getParameter("functionname").equals("InitializeCommit")){
    InitializeCommit();
}

if(request.getParameter("functionname").equals("Rollback")){
    Rollback();
}

if(request.getParameter("functionname").equals("Commit")){
    Commit();
}
%>