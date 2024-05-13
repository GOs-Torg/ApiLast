package com.example.pixelapi.entity;

import java.util.Date;


public class Appointment {
     private int id_appointment;
     private String name;
     private int lesson;
     private String hours;
     private String minutes;
     private String day;
     private Date date;
     private int max_users;
     private int teacher_id;
     private int active_num;
     private String employee_name;
     private int sgroup_id;

    public Appointment(int id_appointment, String name, int lesson, String hours, String minutes, String day, Date date, int max_users, int teacher_id, int active_num, String employee_name, int sgroup_id) {
        this.id_appointment = id_appointment;
        this.name = name;
        this.lesson = lesson;
        this.hours = hours;
        this.minutes = minutes;
        this.day = day;
        this.date = date;
        this.max_users = max_users;
        this.teacher_id = teacher_id;
        this.active_num = active_num;
        this.employee_name = employee_name;
        this.sgroup_id = sgroup_id;
    }

    public int getId_appointment() {
        return id_appointment;
    }

    public void setId_appointment(int id_appointment) {
        this.id_appointment = id_appointment;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getLesson() {
        return lesson;
    }

    public void setLesson(int lesson) {
        this.lesson = lesson;
    }

    public String getHours() {
        return hours;
    }

    public void setHours(String hours) {
        this.hours = hours;
    }

    public String getMinutes() {
        return minutes;
    }

    public void setMinutes(String minutes) {
        this.minutes = minutes;
    }

    public String getDay() {
        return day;
    }

    public void setDay(String day) {
        this.day = day;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getMax_users() {
        return max_users;
    }

    public void setMax_users(int max_users) {
        this.max_users = max_users;
    }

    public int getTeacher_id() {
        return teacher_id;
    }

    public void setTeacher_id(int teacher_id) {
        this.teacher_id = teacher_id;
    }

    public int getActive_num() {
        return active_num;
    }

    public void setActive_num(int active_num) {
        this.active_num = active_num;
    }

    public String getEmployee_name() {
        return employee_name;
    }

    public void setEmployee_name(String employee_name) {
        this.employee_name = employee_name;
    }

    public int getSgroup_id() {
        return sgroup_id;
    }

    public void setSgroup_id(int sgroup_id) {
        this.sgroup_id = sgroup_id;
    }
}
