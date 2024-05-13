package com.example.pixelapi.controllers;

import com.example.pixelapi.entity.*;
import com.example.pixelapi.models.ProfileModel;
import com.example.pixelapi.security.Crypt;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.swing.text.DateFormatter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.time.temporal.TemporalUnit;
import java.util.*;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@RestController
@RequestMapping("/api/teacher")
public class TeacherController {
    private DBController db = new DBController();
    Logger logger = Logger.getLogger("Teacher");


    @GetMapping("/getCources")
    public List<Cource> getCources() throws SQLException {
        ResultSet set = db.selectFromTable("Cource", Cource.class);
        List<Cource> cources = new ArrayList<>();
        if(set != null)
            while (set.next()){
                cources.add( new Cource(set.getInt(1), set.getString(2)));
            }
        db.connection.close();
        return cources;
    }
    @GetMapping("/getAppointments")
    public ResponseEntity<List<Appointment>> getAllSchedule(@RequestParam(name = "date", required = false) String date, @RequestParam("id") int id) throws Exception {
        List<Appointment> list = new ArrayList<>();
        HashMap<String,String> map = new HashMap<>();
        if(date != null){
            map.put("date", "WEEK(date) = WEEK('"+date+"') and YEAR(date) = YEAR('"+date+"')");
        }
        ResultSet set = db.selectFromTable("fullappointment", Appointment.class, map);
        if(set != null)
            while (set.next()){
                logger.info(set.getInt(9)+"");
                if(set.getInt(9) == id)
                    list.add(new Appointment(
                            set.getInt(1),
                            set.getString(2),
                            set.getInt(3),
                            set.getString(4),
                            set.getString(5),
                            set.getString(6),
                            set.getDate(7),
                            set.getInt(8),
                            set.getInt(9),
                            set.getInt(10),
                            set.getString(11),
                            set.getInt(12)
                ));
            }
        db.connection.close();
        return ResponseEntity.ok(list);
    }
    @GetMapping("/getAppointmentsById")
    public Appointment getAppointmentsById(@RequestParam("id") String id) throws SQLException {
        logger.info("here");
        List<Appointment> list = new ArrayList<>();
        HashMap<String,String> map = new HashMap<>();
        map.put("id","id_appointment = "+id);
        ResultSet set = db.selectFromTable("fullappointment", Appointment.class, map);
        logger.info("ID - "+id);
        if(set != null)
            while (set.next()){
                logger.info(set.getInt(1)+"");
                if(set.getInt(1) == Integer.parseInt(id))
                    list.add(new Appointment(
                            set.getInt(1),
                            set.getString(2),
                            set.getInt(3),
                            set.getString(4),
                            set.getString(5),
                            set.getString(6),
                            set.getDate(7),
                            set.getInt(8),
                            set.getInt(9),
                            set.getInt(10),
                            set.getString(11),
                            set.getInt(12)
                    ));
            }
        db.connection.close();
        return list.get(0);
    }
    @GetMapping("/getGroups")
    public List<Sgroups> getGroups() throws SQLException {
        ResultSet set = db.selectFromTable("Sgroups", Sgroups.class);
        List<Sgroups> groups = new ArrayList<>();
        if(set != null)
            while (set.next()){
                groups.add(new Sgroups(set.getInt(1),set.getString(2),set.getInt(3), set.getInt(4) ));
            }
        try {
            db.connection.close();
        } catch (SQLException e) {
            Logger.getLogger(this.getClass().getName()).info(e.getMessage());
        }
        db.connection.close();
        return groups;
    }
    @PostMapping("/AddGroup")
    public Sgroups AddGroup(@RequestParam(name = "ids") int[] ids,
                            @RequestBody Sgroups group) throws SQLException {
        int id = db.addToTable("Sgroups", group);
        group.setId_group(id);
        for (int pIds:
             ids) {
            db.runQuery("Update Student set group_id="+id+" where id_student = "+pIds);
        }
        db.connection.close();
        return group;
    }
    @PostMapping("/UpdateGroup")
    public Sgroups UpdateGroup(@RequestParam(name = "ids", required = false) int[] ids,
                            @RequestBody Sgroups group) throws SQLException {
        db.updateTable("Sgroups", group);
        if (ids != null)
            db.runQuery("Update Student set group_id = null where group_id = "+group.getId_group());
            for (int pIds:
                    ids) {
                db.runQuery("Update Student set group_id="+group.getId_group()+" where id_student = "+pIds);
            }
        db.connection.close();
        return group;
    }
    @PostMapping("/AddStudent")
    public Student AddStudent(@RequestBody Student student) throws SQLException {
        db.addToTable("Student",student);
        db.connection.close();
        return student;
    }
    @PostMapping("/AddEmployee")
    public Employee AddEmployee(@RequestBody Employee employee) throws Exception {
        employee.setPassword(Crypt.hashPassword(employee.getPassword()));
        employee.setEmail(Crypt.encrypt(employee.getEmail()));
        employee.setLogin(Crypt.encrypt(employee.getLogin()));
        db.addToTable("Employee",employee);
        db.connection.close();
        return employee;
    }

    @PostMapping("/deleteGroup")
    public int deleteGroup(@RequestParam("id") int id){
        try{
            db.runQuery("Update Student set group_id=null where group_id = "+id);
            db.deleteTable("Sgroups",new Sgroups(id, "",0,0));
            return 200;
        } catch (Exception e){
            logger.info(e.getMessage());
            return -120;
        } finally {
            try {
                db.connection.close();
            } catch (SQLException e) {
                Logger.getLogger(this.getClass().getName()).info(e.getMessage());
            }
        }
    }

    @PostMapping("/AddAppointment")
        public AppointmentEntity AddAppointment(@RequestBody AppointmentEntity entity, @RequestParam("isMultiple") boolean isMultiple) throws SQLException {
        if(entity != null){
            if( isMultiple){
                LocalDate lastDate = LocalDate.parse(entity.getDate());

                if(entity.getName().contains("Группа")) entity.setMax_users(8);
                else entity.setMax_users(1);
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                for (int i = Integer.parseInt(entity.getLesson()); i<=12;i++) {
                    entity.setDate(lastDate.format(formatter));
                    entity.setDay(lastDate.getDayOfWeek().getValue()+"");
                    entity.setLesson(i+"");
                    int id = db.addToTable("Appointment", entity);
                    lastDate = lastDate.plus(7l, ChronoUnit.DAYS);
                    Map<String,String> conditionMap = new HashMap<>();
                    conditionMap.put("id", "group_id = "+entity.getSgroup_id());
                    ResultSet set = db.selectFromTable("Student", Student.class, conditionMap);
                    if(set == null) return null;
                    while (set.next()){
                        Appointment_Students student = new Appointment_Students(0,id,set.getInt(1),"await");
                        db.addToTable("Appointment_Students", student);
                    }
                }
            } else {
                entity.setDay(LocalDate.parse(entity.getDate()).getDayOfWeek().getValue()+"");
                if(entity.getName().contains("Группа")) entity.setMax_users(8);
                else entity.setMax_users(1);
                int id = db.addToTable("Appointment", entity);
                Map<String,String> conditionMap = new HashMap<>();
                conditionMap.put("id", "group_id = "+entity.getSgroup_id());
                ResultSet set = db.selectFromTable("Student", Student.class, conditionMap);
                if(set == null) return null;
                while (set.next()){
                    Appointment_Students student = new Appointment_Students(0,id,set.getInt(1),"await");
                    db.addToTable("Appointment_Students", student);
                }
            }
            try {
                db.connection.close();
            } catch (SQLException e) {
                Logger.getLogger(this.getClass().getName()).info(e.getMessage());
            }

            return entity;
        }
        return null;
    }
    @PostMapping("/UpdateAppointment")
    public AppointmentEntity UpdateAppointment(@RequestBody AppointmentEntity entity){
       try {
           DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
           LocalDate date = LocalDate.parse(entity.getDate());
           entity.setDay(date.getDayOfWeek().getValue()+"");
           if(entity.getName().contains("Группа")) entity.setMax_users(8);
           else entity.setMax_users(1);
           db.updateTable("Appointment", entity);
           try {
               db.connection.close();
           } catch (SQLException e) {
               Logger.getLogger(this.getClass().getName()).info(e.getMessage());
           }
           return entity;
       } catch (Exception e){
           return null;
       }
    }
    @PostMapping("/DeleteAppointment")
    public int DeleteAppointment(@RequestParam("id") int id){
        try{
            db.deleteCustomTable("appointment_students", "appointment_id = "+id);
            db.deleteCustomTable("Appointment", "id_appointment = "+id);
            return 200;
        } catch (Exception e){
            logger.info(e.getMessage());
            return -120;
        } finally {
            try {
                db.connection.close();
            } catch (SQLException e) {
                Logger.getLogger(this.getClass().getName()).info(e.getMessage());
            }
        }
    }

    @GetMapping("/GetAllProfiles")
    public List<ProfileModel> GetAllProfiles() throws SQLException {
        ResultSet setStudent = db.selectFromTable("Student", Student.class);
        ResultSet setEmployee = db.selectFromTable("Employee", Employee.class);
        List<ProfileModel> resultList = new ArrayList<>();
        if(setStudent != null){
            while (setStudent.next()){
                resultList.add(new ProfileModel("S"+setStudent.getInt(1),
                        setStudent.getString(3)+" "+setStudent.getString(2)+" "+setStudent.getString(4)));
            }
        }
        if(setEmployee != null){
            while (setEmployee.next()){
                resultList.add(new ProfileModel("P"+setEmployee.getInt(1),
                        setEmployee.getString(3)+" "+setEmployee.getString(2)+" "+setEmployee.getString(4)));
            }
        }
        try {
            db.connection.close();
        } catch (SQLException e) {
            Logger.getLogger(this.getClass().getName()).info(e.getMessage());
        }
        return resultList;
    }
    @PostMapping("changePassword")
    public String changePassword(@RequestParam("oldPassword") String oldPassword, @RequestParam("password") String password, @RequestParam("id") String id) {
        logger.info(isPasswordValid(password)+"");
        if(!isPasswordValid(password)) return "1";

        Map<String, String> conditionMap = new HashMap<>();
        conditionMap.put("con1", "id_employee = "+id);
        ResultSet employees = db.selectFromTable("Employee", Employee.class, conditionMap);
        if(employees != null)
            try {
                while (employees.next()){
                    String oldpass =employees.getString(5);
                    String crypted = Crypt.hashPassword(oldPassword);
                    if( oldpass.equals(crypted) ){
                        db.updateTable("Employee", new Employee(
                                employees.getInt(1),
                                employees.getString(2),
                                employees.getString(3),
                                employees.getString(4),
                                Crypt.hashPassword(password),
                                employees.getString(6),
                                employees.getString(7),
                                employees.getInt(8),
                                employees.getInt(9)
                        ));
                        return "2";
                    } else {
                        return "3";
                    }
                }
            } catch (Exception e){
                logger.warning(e.getMessage());
                return  "4";
            }

        else return  "4";
        return "4";
    }

    public static boolean isPasswordValid(String password) {
        // Проверка наличия хотя бы одной заглавной буквы
        Pattern uppercasePattern = Pattern.compile("[A-Z]");
        Matcher uppercaseMatcher = uppercasePattern.matcher(password);

        // Проверка наличия хотя бы одной строчной буквы
        Pattern lowercasePattern = Pattern.compile("[a-z]");
        Matcher lowercaseMatcher = lowercasePattern.matcher(password);

        // Проверка наличия хотя бы одной цифры
        Pattern digitPattern = Pattern.compile("[0-9]");
        Matcher digitMatcher = digitPattern.matcher(password);

        // Проверка наличия хотя бы одного специального символа
        Pattern specialCharPattern = Pattern.compile("[!@#$%^&*()]");
        Matcher specialCharMatcher = specialCharPattern.matcher(password);

        // Проверка длины пароля (7 символов или больше)
        boolean isLengthValid = password.length() >= 7;

        // Все критерии должны быть выполнены
        return uppercaseMatcher.find() &&
                lowercaseMatcher.find() &&
                digitMatcher.find() &&
                specialCharMatcher.find() &&
                isLengthValid;
    }

}
