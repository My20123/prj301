/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author tra my
 */
public class Cabins {
    private String id;
    private int number_seat,status, trid;
    private String ctype;

    public Cabins() {
    }

    public Cabins(String id, int number_seat, int status, int trid, String ctype) {
        this.id = id;
        this.number_seat = number_seat;
        this.status = status;
        this.trid = trid;
        this.ctype = ctype;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getNumber_seat() {
        return number_seat;
    }

    public void setNumber_seat(int number_seat) {
        this.number_seat = number_seat;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getTrid() {
        return trid;
    }

    public void setTrid(int trid) {
        this.trid = trid;
    }

    public String getCtype() {
        return ctype;
    }

    public void setCtype(String ctype) {
        this.ctype = ctype;
    }
    
    
}
