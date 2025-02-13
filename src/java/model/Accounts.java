/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author tra my
 */
public class Accounts {
    private int id;

    @Override
    public String toString() {
        return "Accounts{" + "id=" + id + ", uname=" + uname + ", umail=" + umail + ", pass=" + pass + ", uphone=" + uphone + ", isStaff=" + isStaff + ", isAdmin=" + isAdmin + '}';
    }
    private String uname;
    private String umail;
    private String pass;
    private String uphone;    
    private int isStaff;
    private int isAdmin;

    public Accounts() {
    }

    public Accounts(int id, String uname, String umail, String pass, String uphone, int isStaff, int isAdmin) {
        this.id = id;
        this.uname = uname;
        this.umail = umail;
        this.pass = pass;
        this.uphone = uphone;
        this.isStaff = isStaff;
        this.isAdmin = isAdmin;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public String getUmail() {
        return umail;
    }

    public void setUmail(String umail) {
        this.umail = umail;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public String getUphone() {
        return uphone;
    }

    public void setUphone(String uphone) {
        this.uphone = uphone;
    }

    public int getIsStaff() {
        return isStaff;
    }

    public void setIsStaff(int isStaff) {
        this.isStaff = isStaff;
    }

    public int getIsAdmin() {
        return isAdmin;
    }

    public void setIsAdmin(int isAdmin) {
        this.isAdmin = isAdmin;
    }
    
}
