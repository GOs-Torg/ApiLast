package com.example.pixelapi.controllers;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.lang.reflect.Field;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.Map;
public class DBController {
//    private static final String url = "jdbc:mysql://monorail.proxy.rlwy.net:32421/railway";
//    protected static final String user = "root";
//    private static final String password = "wyEIYbLZRMGdwTiyIVNzyfBgyAJxafly";
    private static final String url = "jdbc:mysql://${MYSQL_HOST:localhost}:3306/PixelSchool";
    protected static final String user = "root";
    private static final String password = "";
    protected static Statement state;
    public Connection connection;
    private Logger logger = LoggerFactory.getLogger(this.getClass().getName());


    public void initDB(){
        try {
            Connection con = DriverManager.getConnection("jjdbc:mysql://${MYSQL_HOST:localhost}:3306/", user, password);
            state = con.createStatement();
            state.execute("CREATE DATABASE IF NOT EXISTS PixelSchool");
        }
        catch (Exception e){
            logger.error(e.getMessage());
        }
    }
    public Connection getConnections(){
        try {
            Connection con = DriverManager.getConnection(url, user, password);
            return con;
        }
        catch (Exception e){}
        return null;
    }
    public ResultSet runQuery(String query) throws SQLException {
        connection = getConnections();
        if(connection != null) {
            try {
                state = connection.createStatement();
                if (query.toLowerCase().indexOf("select") == 0) {
                    ResultSet set = state.executeQuery(query);
                    return  set;
                } else if (query.toLowerCase().indexOf("insert") == 0 ||
                        query.toLowerCase().indexOf("update") == 0 ||
                        query.toLowerCase().indexOf("delete") == 0) {
                    state.executeUpdate(query);
                }
            } catch (SQLException e) {
                logger.info(e.getMessage());
            }
        }
        return null;
    }
    public <T> int addToTable(String tableName, T object){
        int id = 1;
        Class<?> newClass = object.getClass();
        try {
            try {
                String fieldName = "";
                String fieldValue = "";
                Field[] field = newClass.getDeclaredFields();
                field[0].setAccessible(true);
                String querySel = "SELECT " + field[0].getName() + " FROM " + tableName + " ORDER BY " + field[0].getName() + " DESC";
                ResultSet resSet = runQuery(querySel);
                if (resSet.next()){
                    id = resSet.getInt(1) + 1;
                }
                int i = 0;
                field[0].set(object, id);
                for (Field fields : field) {
                    fields.setAccessible(true);
                    fieldName += fields.getName() + ",";
                    /*if(fields.getName().toLowerCase().contains("email") ||
                            fields.getName().toLowerCase().contains("login")) {
                        fieldValue += "'" + Crypt.encrypt(fields.get(object).toString()) +"'" + ",";
                    }
                    else if (fields.getName().toLowerCase().contains("password")){
                        fieldValue += "'" + Crypt.hashPassword(fields.get(object).toString()) +"'" + ",";
                    }
                    else*/
                    if(isInfected(fields.get(object).toString())) return -1;

                    fieldValue += "'" + fields.get(object) + "'" + ",";
                    i++;
                }
                fieldName = fieldName.substring(0, fieldName.length() - 1);
                fieldValue = fieldValue.substring(0, fieldValue.length() - 1);
                logger.info(field.length + "");
                String query = "INSERT INTO " + tableName + " (" + fieldName + ")" + " VALUES (" + fieldValue + ")";
                query = query.replace("'null'","null");
                logger.info(query);
                runQuery(query);
                //Loggers log = new Loggers(0l, query.replace('(', ' ').replace(')', ' ').replace(',', ' ').replace('\'', ' '),LocalDateTime.now().toLocalDate().toString());
                //addToTableNoLogs("Loggers", log);
                return id;
            }
            catch (SQLException e) {logger.error(e.getMessage());}
        }
        catch (Exception e){logger.error(e.getMessage());}
        finally {

        }
        return -1;
    }
    public <T> int addToTableNoLogs(String tableName, T object){
        int id = 1;
        Class<?> newClass = object.getClass();
        try {
            try {
                String fieldName = "";
                String fieldValue = "";
                Field[] field = newClass.getDeclaredFields();
                field[0].setAccessible(true);
                String querySel = "SELECT " + field[0].getName() + " FROM " + tableName + " ORDER BY " + field[0].getName() + " DESC";
                ResultSet resSet = runQuery(querySel);
                if (resSet.next()){
                    id = resSet.getInt(1) + 1;
                }
                int i = 0;
                field[0].set(object, id);
                for (Field fields : field) {
                    fields.setAccessible(true);
                    fieldName += fields.getName() + ",";

                    /*if(fields.getName().toLowerCase().contains("email") ||
                            fields.getName().toLowerCase().contains("login")) {
                        fieldValue += "'" + Crypt.encrypt(fields.get(object).toString()) +"'" + ",";
                    }
                    else if (fields.getName().toLowerCase().contains("password")){
                        fieldValue += "'" + Crypt.hashPassword(fields.get(object).toString()) +"'" + ",";
                    }
                    else*/
                    if(isInfected(fields.get(object).toString())) return -1;
                        fieldValue += "'" + fields.get(object) + "'" + ",";
                    i++;
                }
                fieldName = fieldName.substring(0, fieldName.length() - 1);
                fieldValue = fieldValue.substring(0, fieldValue.length() - 1);
                logger.info(field.length + "");
                String query = "INSERT INTO " + tableName + " (" + fieldName + ")" + " VALUES (" + fieldValue + ")";
                query = query.replace("'null'","null");
                logger.info(query);
                runQuery(query);
                return id;
            }
            catch (SQLException e) {logger.error(e.getMessage());}
        }
        catch (Exception e){logger.error(e.getMessage());}
        finally {

        }
        return -1;
    }

    public <T> void updateTable(String tableName, T object){
        Class<?> newClass = object.getClass();
        try {
            String fieldName = "";
            Field[] field = newClass.getDeclaredFields();
            for (Field fields : field) {
                fields.setAccessible(true);
                if(isInfected(fields.get(object).toString())) return;
                fieldName += fields.getName() + "='" + fields.get(object) + "',";
            }
            fieldName = fieldName.substring(0, fieldName.length() - 1);
            logger.info(field.length + "");
            String query = "UPDATE " +  tableName + " SET " + fieldName + " WHERE " + field[0].getName() + " = " + field[0].get(object);
            query = query.replace("'null'","null");
            logger.info(query);
            runQuery(query);
            //Loggers log = new Loggers(0l, query.replace('(', ' ').replace(')', ' ').replace(',', ' ').replace('\'', ' '),LocalDateTime.now().toLocalDate().toString());
            //addToTableNoLogs("Loggers", log);
            // String queryLog = "INSERT INTO Loggers (id_Log, log_Name, date_Name) values (" + id + ", '" + query.replace('(', ' ').replace(')', ' ').replace(',', ' ').replace('\'', ' ') + "','" + LocalDateTime.now().toLocalDate().toString() + "')";
        }
        catch (Exception e){logger.error(e.getMessage());}
        finally {
        }
    }

    public <T> void deleteTable(String tableName, T object){
        Class<?> newClass = object.getClass();
        try {
            Field[] field = newClass.getDeclaredFields();
            logger.info(field.length + "");
            field[0].setAccessible(true);
            String query = "DELETE FROM " + tableName + " WHERE " + field[0].getName() + " = " + field[0].get(object);
            query = query.replace("'null'","null");
            logger.info(query);
            runQuery(query);
            //Loggers log = new Loggers(0l, query.replace('(', ' ').replace(')', ' ').replace(',', ' ').replace('\'', ' '),LocalDateTime.now().toLocalDate().toString());
            //addToTableNoLogs("Loggers", log);
        }
        catch (Exception e){logger.error(e.getMessage());}
        finally {
        }
    }
    public <T> void deleteCustomTable(String tableName, String condition){
        try {
            String query = "DELETE FROM " + tableName + " WHERE " + condition;
            query = query.replace("'null'","null");
            logger.info(query);
            runQuery(query);
        }
        catch (Exception e){logger.error(e.getMessage());}
        finally {
        }
    }

    public ResultSet selectFromTable(String tableName, Class<?> returnClass) {
        Class<?> newClass = returnClass;
        try {
            String fieldName = "";
            Field[] field = newClass.getDeclaredFields();
            for (Field fields : field) {
                fields.setAccessible(true);
                fieldName += fields.getName() + ",";
            }
            fieldName = fieldName.substring(0, fieldName.length() - 1);
            String query = "SELECT "+ fieldName +" FROM " + tableName;
            logger.info(query);
            ResultSet res = runQuery(query);
            return res;
        }
        catch (Exception e){logger.error(e.getMessage());}
        return null;
    }
    public ResultSet selectFromTable(String tableName, Class<?> returnClass, Map<String,String> conditions){
        Class<?> newClass = returnClass;
        try {
            String fieldName = "";
            Field[] field = newClass.getDeclaredFields();
            for (Field fields : field) {
                fields.setAccessible(true);
                fieldName += fields.getName() + ",";
            }
            fieldName = fieldName.substring(0, fieldName.length() - 1);
            String conditionString = "";
            for (String key:
                    conditions.keySet()) {
                if (!key.equals("lim") && !key.equals("ord"))
                    conditionString += " "+conditions.get(key) + " and";
            }
            logger.info(conditionString);
            if(!conditionString.isEmpty())
                conditionString = " Where ("+conditionString.substring(0, conditionString.length()-4)+")";
            if(conditions.containsKey("lim"))
                conditionString += " LIMIT 20 OFFSET "+ Long.parseLong(conditions.get("lim"))*10;
            if(conditions.containsKey("ord"))
                conditionString+= " ORDER BY "+conditions.get("ord");
            String query = "SELECT "+ fieldName +" FROM " + tableName + conditionString;
            if(tableName.equals("fullappointment")){
                query = "select `appointment`.`id_appointment` AS `id_appointment`,concat(`sgroups`.`name`,' ',`sgroups`.`module_num`) AS `name`,`appointment`.`lesson` AS `lesson`,`appointment`.`hours` AS `hours`,`appointment`.`minutes` AS `minutes`,`appointment`.`day` AS `day`,`appointment`.`date` AS `date`,`appointment`.`max_users` AS `max_users`,`appointment`.`teacher_id` AS `teacher_id`,(select count(`appointment_students`.`student_id`) from `appointment_students` where (`appointment_students`.`appointment_id` = `appointment`.`id_appointment`)) AS `active_num`,concat(`employee`.`second_name`,' ',`employee`.`first_name`,' ',`employee`.`middle_name`) AS `employee_name`,`appointment`.`sgroup_id` AS `sgroup_id` from (((`appointment` join `employee` on((`employee`.`id_employee` = `appointment`.`teacher_id`))) join `region` on((`region`.`id_region` = `employee`.`region_id`))) join `sgroups` on((`sgroups`.`id_group` = `appointment`.`sgroup_id`)))";
                query += conditionString;
            }
            logger.info(query);
            return runQuery(query);
        }
        catch (Exception e){logger.error(e.getMessage());}
        return null;
    }

    private boolean isInfected(String value){
        value = value.toLowerCase();
        return value.contains("insert") ||
                value.contains("select") ||
                value.contains("delete") ||
                value.contains("update") ||
                value.contains("create") ||
                value.contains("alter");
    }
}
//CREATE VIEW Appointment_Full AS
//SELECT `id_appointment`,Appointment.`name`,`lesson`,`hours`,`minutes`,`day`,`date`,`max_users`,`teacher_id`,
//(SELECT COUNT(appointment_students.student_id) FROM appointment_students WHERE appointment_students.appointment_id= Appointment.id_appointment) as 'active_num'
//FROM `Appointment`
//INNER JOIN Employee on Employee.id_employee = Appointment.teacher_id
//INNER JOIN Region on Region.id_region = Employee.region_id