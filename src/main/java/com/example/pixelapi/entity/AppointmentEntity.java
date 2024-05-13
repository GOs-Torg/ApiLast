package com.example.pixelapi.entity;

public class AppointmentEntity {
    private int id_appointment;
    private String name;
    private String lesson;
    private String hours;
    private String minutes;
    private String day;
    private String date;
    private int max_users;
    private int teacher_id;
    private int sgroup_id;

    public AppointmentEntity() {
    }

    public AppointmentEntity(int id_appointment, String name, String lesson, String hours, String minutes, String day, String date, int max_users, int teacher_id, int sgroup_id) {
        this.id_appointment = id_appointment;
        this.name = name;
        this.lesson = lesson;
        this.hours = hours;
        this.minutes = minutes;
        this.day = day;
        this.date = date;
        this.max_users = max_users;
        this.teacher_id = teacher_id;
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

    public String getLesson() {
        return lesson;
    }

    public void setLesson(String lesson) {
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

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
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

    public int getSgroup_id() {
        return sgroup_id;
    }

    public void setSgroup_id(int sgroup_id) {
        this.sgroup_id = sgroup_id;
    }
}
