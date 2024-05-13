package com.example.pixelapi.entity;

public class Appointment_Students {
    private int id_appointment_student;
    private int appointment_id;
    private int student_id;
    private String state;

    public Appointment_Students(int id_appointment_student, int appointment_id, int student_id, String state) {
        this.id_appointment_student = id_appointment_student;
        this.appointment_id = appointment_id;
        this.student_id = student_id;
        this.state = state;
    }

    public int getId_appointment_student() {
        return id_appointment_student;
    }

    public void setId_appointment_student(int id_appointment_student) {
        this.id_appointment_student = id_appointment_student;
    }

    public int getAppointment_id() {
        return appointment_id;
    }

    public void setAppointment_id(int appointment_id) {
        this.appointment_id = appointment_id;
    }

    public int getStudent_id() {
        return student_id;
    }

    public void setStudent_id(int student_id) {
        this.student_id = student_id;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }
}
