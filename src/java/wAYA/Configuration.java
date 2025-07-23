/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package wAYA;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author acamallan
 */
public class Configuration {
    Connection conn = null;
    PreparedStatement config = null;
    ResultSet strResult = null;
    Logs WAS = new Logs();
    public ResultSet getConfig(Connection conn){
    try{
        config = conn.prepareStatement("select config_name, config_value, config_desc from was_configuration ");
         strResult = config.executeQuery();
     } catch(SQLException err){
        WAS.Logger("error", "getConfig Function: " + err.getMessage());
    }
    return strResult;
    }
    
    public ResultSet getClientInfo(Integer institution_id, Connection conn){
    try{
        config = conn.prepareStatement("select institution_id, institution_name from was_client_information where institution_id ='"+institution_id+"' ");
        strResult = config.executeQuery(); 
     } catch(SQLException err){
        WAS.Logger("error", "getClientInfo Function: " + err.getMessage());
    }
    return strResult;
    }
    
}
