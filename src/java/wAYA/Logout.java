/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package wAYA;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Calendar;

/**
 *
 * @author acamallan
 */
public class Logout {
    Logs WAS = new Logs();
    public Logout(Integer userid, Connection conn){
        try{
            Calendar calendar = Calendar.getInstance();
            java.sql.Timestamp timeStamp = new java.sql.Timestamp(calendar.getTime().getTime());
            PreparedStatement qryUpdate = conn.prepareStatement("update was_user_info set last_logoff ='"+timeStamp+"' where userid='"+userid.toString()+"'");
            qryUpdate.executeUpdate();
        } catch(SQLException err){
             WAS.Logger("error", "Logout Function: " + err.getMessage());
        } finally{
            try { 
                if(conn != null) {
                    conn.close();
                } 
            } catch (Exception e) {
        }
    }
    }
    
}
