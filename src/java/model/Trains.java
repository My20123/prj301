/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author tra my
 */
public class Trains {
    private String tid;
    private int status,number_seats,number_cabins;

    public Trains() {
    }

    public Trains(String tid, int status, int number_seats, int number_cabins) {
        this.tid = tid;
        this.status = status;
        this.number_seats = number_seats;
        this.number_cabins = number_cabins;
    }

    public String getTid() {
        return tid;
    }

    public void setTid(String tid) {
        this.tid = tid;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getNumber_seats() {
        return number_seats;
    }

    public void setNumber_seats(int number_seats) {
        this.number_seats = number_seats;
    }

    public int getNumber_cabins() {
        return number_cabins;
    }

    public void setNumber_cabins(int number_cabins) {
        this.number_cabins = number_cabins;
    }
    
    
}
