/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Lenovo
 */
public class Orders {

    int id;
    int account_id;
    long total_price;
    String delivery_address;
    String receiver_name;
    String receiver_phone;
    String status;
    String note;

    public Orders() {
    }

    public Orders(int id, int account_id, long total_price, String delivery_address, String receiver_name, String receiver_phone, String status, String note) {
        this.id = id;
        this.account_id = account_id;
        this.total_price = total_price;
        this.delivery_address = delivery_address;
        this.receiver_name = receiver_name;
        this.receiver_phone = receiver_phone;
        this.status = status;
        this.note = note;
    }

    public Orders(int account_id, long total_price, String delivery_address, String receiver_name, String receiver_phone, String status, String note) {
        this.account_id = account_id;
        this.total_price = total_price;
        this.delivery_address = delivery_address;
        this.receiver_name = receiver_name;
        this.receiver_phone = receiver_phone;
        this.status = status;
        this.note = note;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAccount_id() {
        return account_id;
    }

    public void setAccount_id(int account_id) {
        this.account_id = account_id;
    }

    public long getTotal_price() {
        return total_price;
    }

    public void setTotal_price(long total_price) {
        this.total_price = total_price;
    }

    public String getDelivery_address() {
        return delivery_address;
    }

    public void setDelivery_address(String delivery_address) {
        this.delivery_address = delivery_address;
    }

    public String getReceiver_name() {
        return receiver_name;
    }

    public void setReceiver_name(String receiver_name) {
        this.receiver_name = receiver_name;
    }

    public String getReceiver_phone() {
        return receiver_phone;
    }

    public void setReceiver_phone(String receiver_phone) {
        this.receiver_phone = receiver_phone;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

   

    @Override
    public String toString() {
        return "Order{" + "id=" + id + ", account_id=" + account_id + ", total_price=" + total_price + ", delivery_address=" + delivery_address + ", receiver_name=" + receiver_name + ", receiver_phone=" + receiver_phone + ", status=" + status + ", note=" + note + '}';
    }

}
