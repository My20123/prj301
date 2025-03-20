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
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    private final DBContext dbContext;

    public ProductDAO(DBContext dbContext) { 
        this.dbContext = dbContext;
    }

    public List<Products> getAllProductsByCategories(int cid) throws Exception {
        if (cid < 0) { 
            throw new IllegalArgumentException("Category ID phải là số nguyên dương");
        }

        List<Products> list = new ArrayList<>();
        String query = "SELECT * FROM products WHERE cateID=?";
        try (Connection con = dbContext.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setInt(1, cid);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Products(
                            rs.getInt(1),
                            rs.getString(2),
                            rs.getString(3),
                            rs.getDouble(4),
                            rs.getString(5),
                            rs.getString(6)
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); 
        }
        return list;
    }

   
 public void deleteProduct(int pid) {
    if (pid < 0) { 
            throw new IllegalArgumentException("Product ID phải là số nguyên dương");
        }

    String query = "DELETE FROM products WHERE id = ?";
    try (Connection con = dbContext.getConnection();
             PreparedStatement ps = con.prepareStatement(query)){
        ps.setInt(1, pid);
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}

  public void insertProduct(String name, String image, double price,
            String title, String description, int category, int sid) {
      if (price < 0 || category < 0 || sid < 0) {
        throw new IllegalArgumentException("Số phải là số nguyên dương");
    }
    if (name == null || name.trim().isEmpty() ||
        image == null || image.trim().isEmpty() ||
        title == null || title.trim().isEmpty() ||
        description == null || description.trim().isEmpty()) {
        throw new IllegalArgumentException("Các giá trị chuỗi không được để trống");
    }
        String query = "INSERT [dbo].[products] \n"
                + "([name], [image], [price], [title], [description], [cateID], [sell_ID])\n"
                + "VALUES(?,?,?,?,?,?,?)";
        try(Connection con = dbContext.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, name);
            ps.setString(2, image);
            ps.setDouble(3, price);
            ps.setString(4, title);
            ps.setString(5, description);
            ps.setInt(6, category);
            ps.setInt(7, sid);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
  public void updateProduct(int id, String name, String image, double price,
                          String title, String description, int category, int sid) {
      if (id < 0 ||price < 0 || category < 0 || sid < 0) {
        throw new IllegalArgumentException("Số phải là số nguyên dương");
    }
    if (name == null || name.trim().isEmpty() ||
        image == null || image.trim().isEmpty() ||
        title == null || title.trim().isEmpty() ||
        description == null || description.trim().isEmpty()) {
        throw new IllegalArgumentException("Các giá trị chuỗi không được để trống");
    }
    String query = "UPDATE [dbo].[products] SET "
                 + "[name] = ?, [image] = ?, [price] = ?, [title] = ?, "
                 + "[description] = ?, [cateID] = ?, [sell_ID] = ? "
                 + "WHERE [id] = ?";
    try (Connection con = dbContext.getConnection();
          PreparedStatement ps = con.prepareStatement(query)){
        ps.setString(1, name);
        ps.setString(2, image);
        ps.setDouble(3, price);
        ps.setString(4, title);
        ps.setString(5, description);
        ps.setInt(6, category);
        ps.setInt(7, sid);
        ps.setInt(8, id); 
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace(); 
    }
}
}

