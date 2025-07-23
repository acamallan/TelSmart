package wAYA;

/**
 *
 * @author acamallan
 */
import java.io.UnsupportedEncodingException;
import java.sql.*;
import java.security.NoSuchAlgorithmException;
import java.security.MessageDigest;

public class generateHash {
    public String generateHash(String toHash) {
        MessageDigest md = null;
        byte[] hash = null;
        try {
            md = MessageDigest.getInstance("SHA-512");
            hash = md.digest((toHash+"wAYA042015").getBytes("UTF-8"));
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return convertToHex(hash).toUpperCase();
    }

    /**
    * Converts the given byte[] to a hex string.
    * @param raw the byte[] to convert
    * @return the string the given byte[] represents
    */
    private String convertToHex(byte[] raw) {
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < raw.length; i++) {
            sb.append(Integer.toString((raw[i] & 0xff) + 0x100, 16).substring(1));
        }
        return sb.toString();
    } 
}
