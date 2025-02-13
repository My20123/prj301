/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author tra my
 */
public class Seats {
    private int id,status, price;
    private String cabinid;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getCabinid() {
        return cabinid;
    }

    public void setCabinid(String cabinid) {
        this.cabinid = cabinid;
    }

    public Seats(int id, int status, int price, String cabinid) {
        this.id = id;
        this.status = status;
        this.price = price;
        this.cabinid = cabinid;
    }

    public Seats() {
    }
}
