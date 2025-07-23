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
public class UserAuthorization {
    Logs WAS = new Logs();
    encrypt_decrypt EncDec = new encrypt_decrypt();
    public String EncryptRole(String username, String role){
        try{
            return EncDec.encrypt(role+"^"+username+"wAYA042015");
        } catch(Exception err){
            WAS.Logger("error", "EncryptRole Function: " + err.getMessage());
        }
        return null;
    }
    
    public String DecryptRole(String toDecrypt){
        try{
            String[] decrypt = (EncDec.decrypt(toDecrypt)).split("\\^");
            String role = decrypt[0];
            return role;
        } catch(Exception err){
            WAS.Logger("error", "DecryptRole Function: Invalid user role.");
        }
        return null;
    }
    
    //Check if valid user role
    public Boolean IsUserRoleValid(String userRole, String username){
        try{
            String enc = EncDec.encrypt("1^"+username+"wAYA042015");
            Boolean strReturn = false;
            if(enc.equals(userRole)){
                strReturn = true;// valid
            }
            return strReturn;
        } catch(Exception err){
            WAS.Logger("error", "CheckRole Function: " + err.getMessage());
        }
        return null;
    }
}
