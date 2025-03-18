/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dal;

import dal.DBContext;
import model.Categories;
import model.Products;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Accounts;
import model.Order_details;
import model.Orders;


public class DAO {
    private DBContext dbContext;
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public DAO() {
        this.dbContext = new DBContext();
    }
    public DAO(DBContext dbContext) {
        this.dbContext = dbContext;
    }
    
    public List<Products> getAllProducts() {
        List<Products> list = new ArrayList<>();
        String query = "select * from products";
        try {
            con = new DBContext().getConnection();//mo ket noi voi sql
            ps = con.prepareStatement(query);
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

    public List<Products> getAllProductsByCategories(String cid) {
        List<Products> list = new ArrayList<>();
        String query = "select * from products where cateID=?";
        try {
            con = new DBContext().getConnection();//mo ket noi voi sql
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
    public List<Products> searchByName(String txtSearch) {
        List<Products> list = new ArrayList<>();
        String query = "select * from products where name like ?";
        try {
            con = new DBContext().getConnection();//mo ket noi voi sql
            ps = con.prepareStatement(query);
            ps.setString(1, "%" + txtSearch + "%");
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
    public Products getAllProductsByID(String id) {
        List<Products> list = new ArrayList<>();
        String query = "select * from products where id = ?";
        try {
            con = new DBContext().getConnection();//mo ket noi voi sql
            ps = con.prepareStatement(query);
            ps.setString(1, id);
            rs = ps.executeQuery();

            while (rs.next()) {
                 return new Products(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6));
            }
        } catch (Exception e) {
        }
       return null;
    }
    public List<Products> getProductByCID(String cid) {
        List<Products> list = new ArrayList<>();
        String query = "select * from products\n"
                + "where cateID = ?";
        try {
            con = new DBContext().getConnection();//mo ket noi voi sql
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
        con = new DBContext().getConnection(); // Mở kết nối với SQL
        ps = con.prepareStatement(query);
        ps.setInt(1, category.getCid());      // Truyền ID danh mục
        ps.setString(2, category.getCname()); // Truyền tên danh mục
        ps.executeUpdate(); 
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}
    public Products getLast() {
        String query = "select top 1 * from products\n"
                + "order by id desc";
        try {
            con = new DBContext().getConnection();//mo ket noi voi sql
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Products(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6));
            }
        } catch (Exception e) {
        }
        return null;
    }
  public Accounts login(String user, String pass){
      String query = "select * from accounts where [user] = ? and pass =?";
      try{
          con = new DBContext().getConnection();
          ps=con.prepareStatement(query);
          ps.setString(1,user);
          ps.setString(2, pass);
          rs = ps.executeQuery();
          while(rs.next()){
              return  new Accounts(rs.getInt(1),
                      rs.getString(2),
                      rs.getString(3),
                      rs.getInt(4), 
                      rs.getInt(5));
          }
      }catch(Exception e){
          
      }
      return null;
  }
  public Accounts checkAccountExist(String user){
      String query = "select * from accounts where [user] = ?";
      try{
          con = new DBContext().getConnection();
          ps=con.prepareStatement(query);
          ps.setString(1,user);
          
          rs = ps.executeQuery();
          while(rs.next()){
              return  new Accounts(rs.getInt(1),
                      rs.getString(2),
                      rs.getString(3),
                      rs.getInt(4), 
                      rs.getInt(5));
          }
      }catch(Exception e){
          
      }
      return null;
  }
  public void singup(String user, String pass){
      String query="insert into accounts values(?,?,0,0)";
      try{
             con = new DBContext().getConnection();
          ps=con.prepareStatement(query);
          ps.setString(1,user);
          ps.setString(2,pass);
          ps.executeUpdate();
      }catch(Exception e){
          
      }
  }
  public void deleteProduct(String pid) {
        String query = "delete from products\n"
                + "where id = ?";
        try {
            con = new DBContext().getConnection();//mo ket noi voi sql
            ps = con.prepareStatement(query);
            ps.setString(1, pid);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }
  public void insertProduct(String name, String image, String price,
            String title, String description, String category, int sid) {
        String query = "INSERT [dbo].[products] \n"
                + "([name], [image], [price], [title], [description], [cateID], [sell_ID])\n"
                + "VALUES(?,?,?,?,?,?,?)";
        try {
            con = new DBContext().getConnection();//mo ket noi voi sql
            ps = con.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, image);
            ps.setString(3, price);
            ps.setString(4, title);
            ps.setString(5, description);
            ps.setString(6, category);
            ps.setInt(7, sid);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public static void main(String[] args) {
        DAO dao = new DAO();
        
        List<Categories> listC = dao.getAllCategories();
        List<Products> list = dao.getAllProductsByCategories("cid");

        for (Categories o : listC) {
            System.out.println(o);
        }
    }
    public List<Products> getProductBySellID(int id){
        List<Products> list= new ArrayList<>();
        String query="select * from products where sell_ID=?";
        try {
           con = new DBContext().getConnection();
          ps=con.prepareStatement(query);
          ps.setInt(1, id);
          rs=ps.executeQuery();
          while(rs.next()){
              list.add(new Products(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getDouble(4), rs.getString(5), rs.getString(6)));
          }
            
        } catch (Exception e) {
        }
        return list;
    }
 public void editProduct(String name, String image, String price,
            String title, String description, String category, String pid) {
        String query = "update products\n"
                + "set [name] = ?,\n"
                + "[image] = ?,\n"
                + "price = ?,\n"
                + "title = ?,\n"
                + "[description] = ?,\n"
                + "cateID = ?\n"
                + "where id = ?";
        try {
            con = new DBContext().getConnection();//mo ket noi voi sql
            ps = con.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, image);
            ps.setString(3, price);
            ps.setString(4, title);
            ps.setString(5, description);
            ps.setString(6, category);
            ps.setString(7, pid);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }
 
    public List<Orders> getAllOrders() {
        List<Orders> list = new ArrayList<>();
        String sql = "SELECT * FROM ORDERS";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Orders(
                        rs.getInt("id"),
                        rs.getInt("account_id"),
                        rs.getLong("total_price"),
                        rs.getString("delivery_address"),
                        rs.getString("receiver_name"),
                        rs.getString("receiver_phone"),
                        rs.getString("status"),
                        rs.getString("note")
                ));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public int saveOrder(Orders order) {
        String sql = "INSERT INTO Orders ([uID], [total_price], [address], [receiver_name], [receiver_phone],[status] ,[note])\n"
                + "VALUES (\n"
                + order.getAccount_id() + ", "
                + order.getTotal_price() + ", "
                + "'" + order.getDelivery_address() + "', "
                + "'" + order.getReceiver_name() + "', "
                + "'" + order.getReceiver_phone()+ "', "
                + "'Processing', \n"
                + "'" + order.getNote()+ "'"
                + ");";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1); // Return generated order ID
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return -1;
    }
    public List<Order_details> getAllOrderDetails() {
        List<Order_details> list = new ArrayList<>();
        String sql = "SELECT * FROM ORDER_DETAILS";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Order_details(
                        rs.getInt("id"),
                        rs.getInt("product_id"),
                        rs.getInt("order_id"),
                        rs.getInt("quantity"),
                        rs.getLong("price")
                ));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public String saveOrderDetail(Order_details orderDetail) {
        String sql = "INSERT INTO Order_details ([pid], [oid], [quantity], [price])\n"
                + "VALUES(\n"
                + orderDetail.getProduct_id() + ", \n"
                + orderDetail.getOrder_id() + ", \n"
                + orderDetail.getQuantity() + ", \n"
                + orderDetail.getPrice() + " \n"
                + ");";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
            return "Database error!";
        }
        return "";
    }
}
