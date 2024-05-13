package com.example.pixelapi.controllers;

import com.example.pixelapi.entity.Employee;
import com.example.pixelapi.security.Crypt;
import com.example.pixelapi.util.LoginResponce;
import com.example.pixelapi.security.jwt.JwtTokenProvider;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

@RestController
@RequestMapping("/auth")
public class AuthorizationController {
    private final JwtTokenProvider jwtTokenProvider;
    private DBController db = new DBController();

    public AuthorizationController(JwtTokenProvider jwtTokenProvider){
        this.jwtTokenProvider = jwtTokenProvider;
    }

    @GetMapping("/LogIn")
    public ResponseEntity<LoginResponce> LogIn(@RequestParam("login") String login,
                                              @RequestParam("password") String password){
        ResultSet set = db.selectFromTable("Employee", Employee.class);
        LoginResponce responce = new LoginResponce();
        try {
            while (set.next()){
                if(set.getString(5).equals(Crypt.hashPassword(password)) && Crypt.decrypt(set.getString(6)).equals(login)){
                    List<String> roles = new ArrayList<>();
                    if(set.getInt(8) == 2) responce.id="P"+set.getInt(1);
                    else  {responce.id="M"+set.getInt(1); roles.add("MANAGER");}

                    roles.add("TEACHER");
                    responce.token = jwtTokenProvider.createToken(set.getString(6), roles);
                }
            }
        } catch (Exception e){
            responce.message = "Ошибка соеденении с сервером. Попробуйте повторить авторизацию позже";
        }
        if (responce.id == null) responce.message = "Неверные логин или пароль";
        try {
            db.connection.close();
        } catch (SQLException e) {
            Logger.getLogger(this.getClass().getName()).info(e.getMessage());
        }
        return ResponseEntity.ok(responce);
    }
}
