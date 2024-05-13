package com.example.pixelapi.entity;


public class Role {
    private Integer id_role;
    private String name;

    public Role(){}
    public Role(Integer id_role, String name) {
        this.id_role = id_role;
        this.name = name;
    }

    public Integer getId_role() {
        return id_role;
    }

    public void setId_role(Integer id_role) {
        this.id_role = id_role;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}