<%@page import="java.sql.*,java.util.*"%>
<% Class.forName("com.mysql.jdbc.Driver"); %>  
<%!

public class DBConnection{
    String URL = "jdbc:mysql://localhost:3306/wasystem";
    String USERNAME = "root";
    String PASSWORD = "";
    Connection conn = null;
    
    public  DBConnection(){
        try{
            conn = DriverManager.getConnection(URL,USERNAME,PASSWORD);
        } catch(SQLException e){
            e.printStackTrace();
        }
    }
    
    public Connection getConnection(){
        return conn;
    }
}

%>