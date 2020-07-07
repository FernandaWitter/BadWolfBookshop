package config;

import domain.AccessCredential;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import java.security.SecureRandom;
import java.security.spec.KeySpec;
import java.util.Base64;

public class HashPw {

    public String generateHash(AccessCredential ac){
        try {
            SecureRandom random = new SecureRandom();
            byte[] salt = new byte[16];
            random.nextBytes(salt);
            String[] hashSalt = Password.getSaltedHash(ac.getPassword()).split("$");
            if(hashSalt.length > 1) {
                ac.setSalt(hashSalt[0]);
                ac.setPwHash(hashSalt[1]);
            }
            return hashSalt.toString();
        } catch (Exception e){
            return null;
        }
    }

    public String generateHash(String password, String salt){
        try {
            SecureRandom random = new SecureRandom();
            KeySpec spec = new PBEKeySpec(password.toCharArray(), salt.getBytes(), 65536, 128);
            SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
            byte[] hash = factory.generateSecret(spec).getEncoded();
            return hash.toString();
        } catch (Exception e){
            return null;
        }
    }

}
