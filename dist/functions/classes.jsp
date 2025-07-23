<%@page import="java.sql.*"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="wAYA.DBConnection"%>
<%@ page import="wAYA.Logs"%>
<%@ page import="wAYA.generateHash"%>
<%@ page import="wAYA.encrypt_decrypt"%>
<%@ page import="wAYA.generate_menu_tree"%>
<%@ page import="wAYA.db_function"%>
<%@ page import="wAYA.Chart"%>
<%@ page import="wAYA.CardNumberGenerator"%>
<%@ page import="wAYA.CheckPage"%>
<%@ page import="wAYA.UserAuthorization"%>

<%!

/*wAYA.DBConnection*/
public Connection DBConnection(){
     try {
    String hostname= getServletContext().getInitParameter("hostname");
    String port= getServletContext().getInitParameter("port");
    String dbname= getServletContext().getInitParameter("dbname");
    String username= getServletContext().getInitParameter("username");
    String password= getServletContext().getInitParameter("password");
    
    String url = "jdbc:mysql://"+hostname+":"+port+"/"+dbname;
    
    DBConnection conn = new DBConnection(url, username, password);
    Connection conn1 = conn.getConnection();
    return conn1;
    } catch (Exception err) {
        Logger("error", err.getMessage());
    }
     return null;
}
/*End here*/

/*wAYA.Logs*/
public String Logger(String action, String msg){
    Logs WAS = new Logs();
    WAS.Logger(action, msg);
    return "0";
}
/*End here*/

/*WASystem.generateHash*/
public String generateHash(String toHash) {
    generateHash hash = new generateHash();
    String password = hash.generateHash(toHash);
    return password;
}
/*End here*/

/*wAYA.encrypt_decrypt*/
public String encrypt(String toEncrypt) {
    encrypt_decrypt enc = new encrypt_decrypt();
    String encrypt = enc.encrypt(toEncrypt);
    return encrypt;
}

public String decrypt(String toDecrypt) {
    encrypt_decrypt dec = new encrypt_decrypt();
    String decrypt = dec.decrypt(toDecrypt);
    return decrypt;
}

public String encryptJS(String toEncrypt) {
    encrypt_decrypt dec = new encrypt_decrypt();
    String decrypt = dec.encryptJS(toEncrypt);
    return decrypt;
}

public String decryptJS(String toDecrypt) {
    encrypt_decrypt dec = new encrypt_decrypt();
    String decrypt = dec.decryptJS(toDecrypt);
    return decrypt;
}
/*End here*/

/*wAYA.generate_menu_tree*/
public String generate_user_menu(String usergroups){
    String baseURL = baseURL();
    Connection conn = DBConnection();
    String strReturn = "";
    try {
        generate_menu_tree menu = new generate_menu_tree();
        strReturn = menu.generate_user_menu(usergroups, baseURL, conn);
    } catch(Exception err){
    } finally{
        try { 
            if(conn != null) {
                conn.close();
            } 
        } catch (Exception e) {
        }
    }
    return strReturn;
}

public String generate_config_menu(Integer group_id){
    Connection conn = DBConnection();
    String strReturn = "";
    try{
    generate_menu_tree menu = new generate_menu_tree();
    strReturn = menu.generate_config_menu(group_id, conn);
    } catch(Exception err){
    } finally{
        try { 
            if(conn != null) {
                conn.close();
            } 
        } catch (Exception e) {
        }
    }
    return strReturn;
 }

public String generate_main_menu(String role, String uri, String baseURL){
    generate_menu_tree menu = new generate_menu_tree();
    return menu.generate_main_menu(role, uri, baseURL);
}
/*End here*/
 
/*wAYA.db_function*/
public Integer DB_Update(String table, String setValues, String where, String qryStmt){
    Connection conn = DBConnection();
    db_function db = new db_function();
    Integer strReturn = db.DB_Update(table, setValues, where, qryStmt, conn);
    return strReturn;
}
 
public Integer DB_Insert(String table, String fields, String values, String qryStmt){
    Connection conn = DBConnection();
    db_function db = new db_function();
    Integer strReturn = db.DB_Insert(table, fields, values, qryStmt, conn);
    return strReturn;
}

public Integer DB_Delete(String table, String where){
    Connection conn = DBConnection();
    db_function db = new db_function();
    Integer strReturn = db.DB_Delete(table, where, conn);
    return strReturn;
}

public ResultSet DB_Select(String fields, String table, String where, String orderby, String limit){
    Connection conn = DBConnection();
    db_function db = new db_function();
    ResultSet strReturn = db.DB_Select(fields, table, where, orderby, limit, conn);
    return strReturn;
}

public Integer Update_DB(String updateStmt){
    Connection conn = DBConnection();
    Integer strReturn = 0;
    try{
        db_function db = new db_function();
        strReturn = db.Update_DB(updateStmt, conn);
    } catch(Exception err){
    } finally{
        try { 
            if(conn != null) {
                conn.close();
            } 
        } catch (Exception e) {
        }
    }
    return strReturn;
}

public Integer Insert_DB(String insertStmt ){
    Connection conn = DBConnection();
    Integer strReturn = -1;
    try {
        db_function db = new db_function();
        strReturn = db.Insert_DB(insertStmt, conn);
    } catch(Exception err){
    } finally{
        try { 
            if(conn != null) {
                conn.close();
            } 
        } catch (Exception e) {
        }
    }
    return strReturn;
}

public Integer Delete_DB(String deleteStmt){
    Connection conn = DBConnection();
    Integer strReturn = 0;
    try {
        db_function db = new db_function();
        strReturn = db.Delete_DB(deleteStmt, conn);
    } catch(Exception err){
    } finally{
        try { 
            if(conn != null) {
                conn.close();
            } 
        } catch (Exception e) {
        }
    }
    return strReturn;
}

public String Select_DB(String selectStmt){
    Connection conn = DBConnection();
    String strReturn = "";
    try {
        
        db_function db = new db_function();
        strReturn = db.Select_DB(selectStmt, conn);
    } catch(Exception err){
    } finally{
        try { 
            if(conn != null) {
                conn.close();
            } 
        } catch (Exception e) {
        }
    }
    return strReturn;
}
 /*End here*/

/*wAYA.Chart*/
public String BarChart(){
    Connection conn = DBConnection();
    Chart chart = new Chart();
    String barChart = chart.BarChart(conn);
    return barChart;
}
/*End here*/

/*wAYA.CardNumberGenerator*/
public String GenerateCardNumber(String bin, Integer len){
    CardNumberGenerator Gen = new CardNumberGenerator();
    String strReturn = Gen.GenerateCardNumber(bin, len);
    return strReturn;
}
/*End here*/

/*wAYA.CheckPage*/
public Boolean CheckPage(String uri, String userRole, String username){
    CheckPage page = new CheckPage();
    Boolean isValid = page.Page(uri, userRole, username);
    Boolean strReturn = true;
    if(!isValid){
        strReturn = false;
    }
    return strReturn;
}
/*End here*/

/*wAYA.UserAuthorization*/
public String EncryptRole(String username, String role){
    UserAuthorization auth = new UserAuthorization();
    String strReturn = auth.EncryptRole(username,role);
    return strReturn;
}

public String DecryptRole(String toDecrypt){
    UserAuthorization auth = new UserAuthorization();
    String strReturn = auth.DecryptRole(toDecrypt);
    return strReturn;
}
/*End here*/
%>
