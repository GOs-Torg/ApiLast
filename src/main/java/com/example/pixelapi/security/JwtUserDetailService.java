package com.example.pixelapi.security;


import com.example.pixelapi.controllers.DBController;
import com.example.pixelapi.entity.Employee;
import com.example.pixelapi.security.jwt.JwtUser;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

@Service
public class JwtUserDetailService implements UserDetailsService {
        private final DBController db = new DBController();
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Map<String, String> conditionMap = new HashMap<>();
        conditionMap.put("first", "login = '"+username+"'");
        ResultSet empSet = db.selectFromTable("Employee", Employee.class, conditionMap);
        JwtUser user = null;
        try{
            while (empSet.next()){
                List<String> roles = new ArrayList<>();
                roles.add("TEACHER");
                user = new JwtUser(empSet.getInt(1),
                        empSet.getString(6),
                        empSet.getString(5),
                        empSet.getString(7),
                        empSet.getString(2),
                        roles);
            }
        } catch (Exception e){
            Logger.getAnonymousLogger().info(e.getMessage());
        }
        try {
            db.connection.close();
        } catch (SQLException e) {
            Logger.getLogger(this.getClass().getName()).info(e.getMessage());
        }
        return user;
    }
}
