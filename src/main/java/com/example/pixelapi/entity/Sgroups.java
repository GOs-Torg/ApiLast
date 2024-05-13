package com.example.pixelapi.entity;

public class Sgroups {
    private int id_group;
    private String name;
    private int module_num;
    private int cource_id;

    public Sgroups(int id_group, String name, int module_num, int cource_id) {
        this.id_group = id_group;
        this.name = name;
        this.module_num = module_num;
        this.cource_id = cource_id;
    }

    public int getId_group() {
        return id_group;
    }

    public void setId_group(int id_group) {
        this.id_group = id_group;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getModule_num() {
        return module_num;
    }

    public void setModule_num(int module_num) {
        this.module_num = module_num;
    }

    public int getCource_id() {
        return cource_id;
    }

    public void setCource_id(int cource_id) {
        this.cource_id = cource_id;
    }
}
