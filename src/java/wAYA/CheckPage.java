/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package wAYA;
/**
 *
 * @author acamallan
 */
public class CheckPage {
    Logs WAS = new Logs();
    UserAuthorization auth = new UserAuthorization();
    public Boolean Page(String uri, String userRole, String username){
        try{
            Boolean strReturn = true;
            Boolean isAdminFolder = uri.contains("administrator");
            String adminPage = "configuration.jsp,groups_authorization.jsp,password_policy.jsp,reset_password.jsp,table_maintenance.jsp,users_authorization.jsp";
            String pageName = uri.substring(uri.lastIndexOf("/")+1);
            String role = auth.DecryptRole(userRole);
            
            if(isAdminFolder){
                if(!auth.IsUserRoleValid(userRole,username)){ //Check if user role is valid
                    WAS.Logger("error", "User Role is not valid.");
                    return false;
                }
                if(!role.equals("1")){
                    Boolean isValidPage = adminPage.contains(pageName);
                    if(isValidPage){
                        WAS.Logger("error", "Unauthorized access page.");
                        strReturn = false;
                    }
                }
            }
            return strReturn;
        } catch(Exception err){
            WAS.Logger("error", "Page Function: " + err.getMessage());
        }
        return null;
    }
}
