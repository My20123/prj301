/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;
import java.util.Date;

/**
 *
 * @author tra my
 */
public class Schedules {
    private int id, rid;
    private String trid;
    private Date from_time;

    public Schedules() {
    }

    public Schedules(int id, int rid, String trid, Date from_time) {
        this.id = id;
        this.rid = rid;
        this.trid = trid;
        this.from_time = from_time;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getRid() {
        return rid;
    }

    public void setRid(int rid) {
        this.rid = rid;
    }

    public String getTrid() {
        return trid;
    }

    public void setTrid(String trid) {
        this.trid = trid;
    }

    public Date getFrom_time() {
        return from_time;
    }

    public void setFrom_time(Date from_time) {
        this.from_time = from_time;
    }

    @Override
    public String toString() {
        return "Schedules{" + "id=" + id + ", rid=" + rid + ", trid=" + trid + ", from_time=" + from_time + '}';
    }
    

}
