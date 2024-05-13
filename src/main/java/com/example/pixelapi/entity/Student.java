package com.example.pixelapi.entity;

public class Student {
    private int id_student;
    private String name;
    private String second_name;
    private String middle_name;
    private String student_email;
    private String phone_num;
    private String group_id;

    public Student(int id_student, String name, String second_name, String middle_name, String student_email, String phone_num, String group_id) {
        this.id_student = id_student;
        this.name = name;
        this.second_name = second_name;
        this.middle_name = middle_name;
        this.student_email = student_email;
        this.phone_num = phone_num;
        this.group_id = group_id;
    }

    public int getId_student() {
        return id_student;
    }

    public void setId_student(int id_student) {
        this.id_student = id_student;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSecond_name() {
        return second_name;
    }

    public void setSecond_name(String second_name) {
        this.second_name = second_name;
    }

    public String getMiddle_name() {
        return middle_name;
    }

    public void setMiddle_name(String middle_name) {
        this.middle_name = middle_name;
    }

    public String getStudent_email() {
        return student_email;
    }

    public void setStudent_email(String student_email) {
        this.student_email = student_email;
    }

    public String getPhone_num() {
        return phone_num;
    }

    public void setPhone_num(String phone_num) {
        this.phone_num = phone_num;
    }

    public String getGroup_id() {
        return group_id;
    }

    public void setGroup_id(String group_id) {
        this.group_id = group_id;
    }
}
