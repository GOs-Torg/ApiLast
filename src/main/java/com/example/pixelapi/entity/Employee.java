package com.example.pixelapi.entity;

public class Employee {
 private int id_employee;
 private String first_name;
 private String second_name;
 private String middle_name;
 private String password;
 private String login;
 private String email;
 private int role_id;
 private int region_id;

    public Employee(int id_employee, String first_name, String second_name, String middle_name, String password, String login, String email, int role_id, int region_id) {
        this.id_employee = id_employee;
        this.first_name = first_name;
        this.second_name = second_name;
        this.middle_name = middle_name;
        this.password = password;
        this.login = login;
        this.email = email;
        this.role_id = role_id;
        this.region_id = region_id;
    }

    public int getId_employee() {
        return id_employee;
    }

    public void setId_employee(int id_employee) {
        this.id_employee = id_employee;
    }

    public String getFirst_name() {
        return first_name;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getRole_id() {
        return role_id;
    }

    public void setRole_id(int role_id) {
        this.role_id = role_id;
    }

    public int getRegion_id() {
        return region_id;
    }

    public void setRegion_id(int region_id) {
        this.region_id = region_id;
    }
}
