package com.example.pixelapi.security;

import org.mindrot.jbcrypt.BCrypt;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;
import java.util.logging.Logger;

public class Crypt {
    private static final String ALGORITHM = "AES";

    public static String hashPassword(String plainTextPassword) {
        String salt = "$2a$10$8M3JyV5zQ7.mQJd8LVxA6u";

        return BCrypt.hashpw(plainTextPassword, salt);
    }
    public static String encrypt(String data) throws Exception {
        SecretKey secretKey = generateSecretKey();

        // Шифруем строку
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.ENCRYPT_MODE, secretKey);

        byte[] encryptedBytes = cipher.doFinal(data.getBytes());

        String encryptedString = Base64.getEncoder().encodeToString(encryptedBytes) + ":" +
                Base64.getEncoder().encodeToString(secretKey.getEncoded());

        return encryptedString;
    }

    public static String decrypt(String encryptedData) {

        String[] parts = encryptedData.split(":");
        String encryptedString = parts[0];
        String keyString = parts[1];


        byte[] keyBytes = Base64.getDecoder().decode(keyString);
        SecretKey secretKey = new SecretKeySpec(keyBytes, ALGORITHM);


        byte[] decryptedBytes = new byte[0];
        try {
            Cipher cipher = Cipher.getInstance(ALGORITHM);
            cipher.init(Cipher.DECRYPT_MODE, secretKey);

            byte[] encryptedBytes = Base64.getDecoder().decode(encryptedString);
            decryptedBytes = cipher.doFinal(encryptedBytes);
        } catch (Exception e) {
            Logger.getLogger("CryptErrors").info(e.getMessage());
        }


        return new String(decryptedBytes);
    }
    private static SecretKey generateSecretKey()  {
        try {
            KeyGenerator keyGenerator = KeyGenerator.getInstance(ALGORITHM);
            keyGenerator.init(128); // Размер ключа (может быть 128, 192 или 256 бит)
            return keyGenerator.generateKey();
        }catch (Exception e){
            Logger.getLogger("CryptErrors").info(e.getMessage());
            return null;
        }
    }
}
