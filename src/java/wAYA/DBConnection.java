package wAYA;

/**
 *
 * @author acamallan
 */
import java.sql.*;
public class DBConnection {
    Connection conn = null;
    Logs WAS = new Logs();
    encrypt_decrypt dec = new encrypt_decrypt();
    public  DBConnection(String url, String username, String password)  throws Exception {
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url,username,dec.decrypt(password));
        } catch (ClassNotFoundException | SQLException err) {
            WAS.Logger("error", err.getMessage());
            throw err;
        }
    }
    
    public Connection getConnection(){
        return conn;
    }  
}
