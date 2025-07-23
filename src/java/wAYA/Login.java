package wAYA;
import java.sql.*;
import java.util.Calendar;
/**
 *
 * @author acamallan
 */
public class Login {
    Connection conn = null;
    PreparedStatement strSelect = null;
    ResultSet strResult = null;
    
    Logs WAS = new Logs();
    generateHash hash = new generateHash();
    public ResultSet CheckPassword(String username, String password, Connection conn){
        try{
            Calendar calendar = Calendar.getInstance();
            java.sql.Timestamp timeStamp = new java.sql.Timestamp(calendar.getTime().getTime());
            String pass = hash.generateHash(username+password);
            PreparedStatement qrySelect = conn.prepareStatement("select current_login from was_user_info where username='"+username+"' and password='"+pass+"'");
            ResultSet isValid = qrySelect.executeQuery();
            while (isValid.next()){
                PreparedStatement qryUpdate = conn.prepareStatement("update was_user_info set current_login ='"+timeStamp+"', last_login ='"+isValid.getString("current_login") +"', password_failed = 0 where username='"+username+"' and password='"+pass+"'");
                qryUpdate.executeUpdate();
            }
            
            strSelect = conn.prepareStatement("select userid, username, lastname, firstname, role, groups, institution_id, current_login, last_login, modules from was_user_info where username='"+username+"' and password='"+pass+"'");
            ResultSet strReturn = strSelect.executeQuery();
            return strReturn;
        } catch(SQLException err){
            WAS.Logger("error", "CheckPassword Function: " + err.getMessage());
        }
        return null;
    }
    
    public String CheckStatus(String username, Connection conn){
        try{
            String strReturn = "";
            strSelect = conn.prepareStatement("select password_status,password_failed from was_user_info where username='"+username+"'");
            ResultSet PasswordStatus = strSelect.executeQuery();
            while (PasswordStatus.next()){
                strReturn = PasswordStatus.getInt("password_status")+","+PasswordStatus.getInt("password_failed");
            }
            return strReturn;
        } catch(SQLException err){
            WAS.Logger("error", "CheckStatus Function: " + err.getMessage());
        }
        return null;
    }
    
    public void UpdatePasswordFailed(String username, Integer num,  Connection conn){
        try{
            PreparedStatement qryUpdate = conn.prepareStatement("update was_user_info set password_failed ="+num+" where username='"+username+"'");
            qryUpdate.executeUpdate();
        } catch(SQLException err){
            WAS.Logger("error", "UpdatePasswordFailed Function: " + err.getMessage());
        }
    }
    
    public void UpdatePasswordStatus(String username,  Connection conn){
        try{
            PreparedStatement qryUpdate = conn.prepareStatement("update was_user_info set password_failed =0, password_status=2 where username='"+username+"'");
            qryUpdate.executeUpdate();
        } catch(SQLException err){
            WAS.Logger("error", "UpdatePasswordStatus Function: " + err.getMessage());
        }
    }
    
    
}
