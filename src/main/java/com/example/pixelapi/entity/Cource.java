package com.example.pixelapi.entity;

public class Cource {
    private int id_cource;
    private String name;

    public Cource(int id_cource, String name) {
        this.id_cource = id_cource;
        this.name = name;
    }

    public int getId_cource() {
        return id_cource;
    }

    public void setId_cource(int id_cource) {
        this.id_cource = id_cource;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
