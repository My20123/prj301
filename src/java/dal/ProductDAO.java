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
import model.Products;

/**
 *
 * @author tra my
 */
public class ProductDAO {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Products> getAllProductsByCategories(String cid) {
        if (cid == null) {
            throw new IllegalArgumentException("CategoryId không được null");
        }
        if (!cid.matches("\\d+")) { // Kiểm tra nếu không phải số
            throw new IllegalArgumentException("CategoryId phải là số nguyên dương");
        }
        List<Products> list = new ArrayList<>();
        String query = "select * from products where cateID=?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, cid);
            rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Products(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6)));
            }
        } catch (Exception e) {
        }
        return list;
    }
}
