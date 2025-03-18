/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Categories;

/**
 *
 * @author Admin
 */
public class CategoriesDAO {

    public Connection con;
    private PreparedStatement ps;
    private ResultSet rs;

    public CategoriesDAO(Connection con) {
        this.con = con;
    }

    public CategoriesDAO() {
        try {
            this.con = new DBContext().getConnection(); // Mặc định kết nối database thật
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Categories> getAllCategories() {
        List<Categories> list = new ArrayList<>();
        String query = "select * from Categories";
        try {
            con = new DBContext().getConnection();//mo ket noi voi sql
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Categories(rs.getInt(1),
                        rs.getString(2)));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public boolean addCategory(Categories category) {
        String query = "INSERT INTO Categories (cid, cname) VALUES (?, ?)";
        try {
            ps = con.prepareStatement(query);  // Sử dụng kết nối mock
            ps.setInt(1, category.getCid());
            ps.setString(2, category.getCname());
            return ps.executeUpdate() > 0;  // Trả về true khi thêm thành công
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteCategory(int cid) {
        String query = "DELETE FROM Categories WHERE cid = ?";
        try {
            ps = con.prepareStatement(query);  // Sử dụng kết nối mock
            ps.setInt(1, cid);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateCategory(Categories category) {
        String query = "UPDATE Categories SET cname = ? WHERE cid = ?";
        try {
            ps = con.prepareStatement(query);  // Sử dụng kết nối mock
            ps.setString(1, category.getCname());
            ps.setInt(2, category.getCid());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
