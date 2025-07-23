package wAYA;

/**
 *
 * @author acamallan
 */
import java.security.Key;
import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import org.apache.commons.codec.binary.Base64;

public class encrypt_decrypt {
    String key1 = "5588130697142472"; // 128 bit key
    String key2 = "066e377785c1ccfb";
    public String encrypt(String toEncrypt) {
        try {    
            IvParameterSpec iv = new IvParameterSpec(key2.getBytes("UTF-8"));
            SecretKeySpec skeySpec = new SecretKeySpec(key1.getBytes("UTF-8"), "AES");
            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
            cipher.init(Cipher.ENCRYPT_MODE, skeySpec, iv);
            byte[] encrypted = cipher.doFinal(toEncrypt.getBytes());
            return Base64.encodeBase64String(encrypted);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public String decrypt(String toDecrypt) {
        try {
            IvParameterSpec iv = new IvParameterSpec(key2.getBytes("UTF-8"));
            SecretKeySpec skeySpec = new SecretKeySpec(key1.getBytes("UTF-8"), "AES");
            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
            cipher.init(Cipher.DECRYPT_MODE, skeySpec, iv);
            byte[] original = cipher.doFinal(Base64.decodeBase64(toDecrypt));

            return new String(original);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    } 
    
    //JS encryption and decryption
    private static final byte[] keyValue =  new byte[] { '5', '5', '8', '8', '1', '3', '0', '6', '9', '7', '1','4', '2', '4', '7', '2'};

    public String encryptJS(String Data) {
        try{
            Key key = new SecretKeySpec(keyValue, "AES");
            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.ENCRYPT_MODE, key);
            byte[] encVal = cipher.doFinal(Data.getBytes());
            return Base64.encodeBase64String(encVal);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }
    
    public String decryptJS(String Data) {
        try{
            Key key = new SecretKeySpec(keyValue, "AES");
            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.DECRYPT_MODE, key);
            byte[] original = cipher.doFinal(Base64.decodeBase64(Data.replace(" ","+")));
            return new String(original);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }    
    
    
    /*
    * Javacript function
    function encryptJS(string){
        var base64Key = "NTU4ODEzMDY5NzE0MjQ3Mg==";
        var key = CryptoJS.enc.Base64.parse(base64Key);
        var encryptedData = CryptoJS.AES.encrypt(string, key, {
            mode: CryptoJS.mode.ECB,
            padding: CryptoJS.pad.Pkcs7
        });
        return encryptedData.toString();

    }

    function decryptJS(string){
        var base64Key = "NTU4ODEzMDY5NzE0MjQ3Mg==";
        var key = CryptoJS.enc.Base64.parse(base64Key);
        var decryptedData = CryptoJS.AES.decrypt(string, key, {
            mode: CryptoJS.mode.ECB,
            padding: CryptoJS.pad.Pkcs7
        } );
        var decryptedText = decryptedData.toString( CryptoJS.enc.Utf8 );
        return decryptedText;
    }
    */
    //end here
}
