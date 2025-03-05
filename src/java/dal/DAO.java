/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import model.*;

/**
 *
 * @author tra my
 */
public class DAO {

    private Connection connection;

    public DAO() {
        try {
            connection = new DBContext().getConnection();
        } catch (Exception e) {
            System.out.println("Error connecting to database: " + e.getMessage());
        }
    }

    public List<Accounts> getAllAccounts() {
        List<Accounts> list = new ArrayList<>();
        String query = "select * from accounts";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Accounts(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getInt(7),
                        rs.getString(8)));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public Accounts GetUserById(int id) {
        try {

            String query = "SELECT * FROM accounts WHERE uid = ?";
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Accounts(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getInt(7),
                        rs.getString(8));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateUser(int id, String uname, String uphone, String umail, String cccd) {
        String query = "UPDATE accounts SET uname = ?, uphone = ?, umail = ?, cccd = ? WHERE uid = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, uname);
            ps.setString(2, uphone);
            ps.setString(3, umail);
            ps.setString(4, cccd);
            ps.setInt(5, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List getAllStations() {
        List<String> list = new ArrayList<>();
        try {

            String query = "SELECT DISTINCT from_station FROM Routes UNION SELECT DISTINCT to_station FROM Routes ORDER BY from_station;";
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(rs.getString(1));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log the error instead of silently ignoring it
        }
        return list;
    }

    public List getAllRoutes() {
        List<Routes> routes = new ArrayList<>();
        List<Integer> listid = new ArrayList<>();

        try {

            String query = "SELECT * FROM Routes";
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String query1 = "select * from Routes_data where id=?";
                PreparedStatement ps1 = connection.prepareStatement(query1);

                ps1.setInt(1, id);
                ResultSet rs1 = ps1.executeQuery();
                LinkedHashMap< String, Integer> thr_stations = new LinkedHashMap<>();

                while (rs1.next()) {
                    thr_stations.put(rs1.getString("route_key"), rs1.getInt("value"));
                }
                routes.add(new Routes(id, rs.getString("from_station"), rs.getString("to_station"), thr_stations));
            }

        } catch (Exception e) {
        }

        return routes;
    }

    public List getAllTrains() {
        List<String> list = new ArrayList<>();
        try {

            String query = "SELECT id FROM Trains;";
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(rs.getString("route_key"));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public Accounts login(String user, String pass) {
        try {
            String query = "select * from accounts where uname = ? and pass =?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, user);
            ps.setString(2, pass);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Accounts(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getInt(7),
                        rs.getString(8));
            }
        } catch (Exception e) {

        }
        return null;
    }

    public List searchRoute(String depart, String desti) {
        List<Routes> list = new ArrayList<>();
        try {

            String query = "select id,from_station, to_station  from Routes where id in(SELECT rd1.id FROM Routes_data rd1 JOIN Routes_data rd2 ON rd1.id = rd2.id WHERE rd1.route_key = ?  AND rd1.value < rd2.value AND rd2.route_key = ?)";
            PreparedStatement ps = connection.prepareStatement(query);

            ps.setString(1, depart);
            ps.setString(2, desti);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int rid = rs.getInt(1);
                String from_station = rs.getString(2);
                String to_station = rs.getString(3);
                LinkedHashMap<String, Integer> thr_station = new LinkedHashMap<>();

                String query1 = "select route_key, value from Routes_data where id=?";
                PreparedStatement ps1 = connection.prepareStatement(query1);
                ps1.setInt(1, rid);

                ResultSet rs1 = ps1.executeQuery();
                while (rs1.next()) {
                    String route_key = rs1.getString("route_key");
                    int value = rs1.getInt("value");
                    thr_station.put(route_key, value);
                }
                list.add(new Routes(rid, from_station, to_station, thr_station));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public Accounts checkAccountExist(String user) {
        String query = "select * from accounts where uname = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, user);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Accounts(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getInt(7),
                        rs.getString(8));
            }
        } catch (Exception e) {

        }
        return null;
    }


    public void singup(String user, String email, String pass, String phone) {
        String query = "INSERT INTO Accounts ( uname, umail, pass, uphone , isStaff, isAdmin) VALUES ( ?,?,?,?, 0,0)";

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, user);
            ps.setString(2, email);
            ps.setString(3, pass);
            ps.setString(4, phone);
            ps.executeUpdate();
        } catch (Exception e) {

        }
    }


    public String searchTrainIDWithRid(int rid) {
        String trids = "";
        try {
            String query = "SELECT trid FROM Schedules where rid = ?;";
            PreparedStatement ps = connection.prepareStatement(query);

            ps.setInt(1, rid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                if (rs.isLast()) {
                    trids += rs.getString(1);
                } else {
                    trids += rs.getString(1) + "-";
                }
            }

        } catch (Exception e) {
        }
        return trids;
    }

    public List searchCabinsWithTrainID(String trid) {
        List<Cabins> list = new ArrayList();
        try {
            String query = "SELECT * FROM Cabins where trid = ?;";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, trid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Cabins(rs.getString(1), rs.getInt(2), rs.getInt(3),rs.getInt(4) ,rs.getString(5), rs.getString(6)));
            
            }
        } catch (Exception e) {
        }
         return list;
    }

    public int searchAvailSeatsOfTrainWithScheduleID(int sid) {
        int avail_seats;
        try {
            String query = "SELECT trid FROM Schedules where id = ?;";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, sid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String trid = rs.getString(1);
                String query1 = "SELECT avail_seats FROM Trains where id = ?;";
                PreparedStatement ps1 = connection.prepareStatement(query1);
                ps1.setString(1, trid);
                ResultSet rs1 = ps1.executeQuery();
                while (rs1.next()) {
                    avail_seats = rs1.getInt(1);
                    return avail_seats;
                }
            }

        } catch (Exception e) {
        }
        return 0;
    }
    public int searchAvailSeatsOfCabinWithCabinID(String cid){
        int avail_seats=0;
        try {
            String query = "SELECT avail_seat FROM Cabins where id = ?;";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, cid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
               avail_seats= rs.getInt(1);                
            }
        } catch (Exception e) {
        }
        return avail_seats;
    }


    public List searchSchedules(List<Routes> routes, Date date) throws Exception {
        List<Schedules> schedulesList = new ArrayList<>();
        String query = "SELECT id, rid, trid, from_time FROM Schedules WHERE DATE(from_time) = ? AND rid = ?";
        for (Routes route : routes) {
            int routeId = route.getId();
            try (PreparedStatement stmt = connection.prepareStatement(query)) {

                // Set parameters
                stmt.setDate(1, new java.sql.Date(date.getTime()));  // Convert java.util.Date to java.sql.Date
                stmt.setInt(2, routeId);

                // Execute query
                ResultSet rs = stmt.executeQuery();
              
              
                // Process the result set
                while (rs.next()) {
                    int id = rs.getInt("id");
                    int rid = rs.getInt("rid");
                    String trid = rs.getString("trid");
                    Date fromTime = rs.getTimestamp("from_time");

                    // Add the result to the list
                    schedulesList.add(new Schedules(id, rid, trid, fromTime));
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return schedulesList;
    }

    public List<Schedule> getAllSchedules() {
        List<Schedule> list = new ArrayList<>();
        String sql = "SELECT s.id, s.rid, s.trid, t.train_type, r.from_station, r.to_station, s.from_time, s.to_time " +
                    "FROM schedules s " +
                    "INNER JOIN routes r ON s.rid = r.id " +
                    "INNER JOIN trains t ON s.trid = t.id";
        try {
            con = new DBContext().getConnection();
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery();  
            while (rs.next()) {
                Schedule s = new Schedule();
                s.setId(rs.getInt("id"));
                s.setRid(rs.getInt("rid"));
                s.setTrid(rs.getString("trid"));
                s.setTrainType(rs.getString("train_type"));
                s.setFromStation(rs.getString("from_station"));
                s.setToStation(rs.getString("to_station"));
                s.setFromTime(rs.getTimestamp("from_time"));
                s.setToTime(rs.getTimestamp("to_time"));
                list.add(s);
            }
            rs.close();
            st.close();
            con.close();
        } catch (Exception e) {
            System.out.println("Error in getAllSchedules: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalSchedules() {
        String sql = "SELECT COUNT(*) FROM schedules s " +
                    "INNER JOIN trains t ON s.trid = t.id ";
        
        String trainType = null; //request.getParameter("type");
        if (trainType != null && !trainType.isEmpty()) {
            sql += "WHERE t.train_type = ?";
        }
        
        try {
            con = new DBContext().getConnection();
            PreparedStatement st = con.prepareStatement(sql);
            
            if (trainType != null && !trainType.isEmpty()) {
                st.setString(1, trainType);
            }
            
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            
            rs.close();
            st.close();
            con.close();
        } catch (Exception e) {
            System.out.println("Error in getTotalSchedules: " + e.getMessage());
        }
        return 0;
    }

    public List<Schedule> getSchedulesByPage(int page, int recordsPerPage, String trainType) {
        List<Schedule> list = new ArrayList<>();
        String sql = "SELECT s.id, s.rid, s.trid, t.train_type, r.from_station, r.to_station, s.from_time, s.to_time " +
                    "FROM schedules s " +
                    "INNER JOIN routes r ON s.rid = r.id " +
                    "INNER JOIN trains t ON s.trid = t.id ";
        
        if (trainType != null && !trainType.isEmpty()) {
            sql += "WHERE t.train_type = ? ";
        }
        
        sql += "ORDER BY s.from_time ASC LIMIT ? OFFSET ?";
        
        try {
            con = new DBContext().getConnection();
            PreparedStatement st = con.prepareStatement(sql);
            
            int paramIndex = 1;
            if (trainType != null && !trainType.isEmpty()) {
                st.setString(paramIndex++, trainType);
            }
            st.setInt(paramIndex++, recordsPerPage);
            st.setInt(paramIndex, (page - 1) * recordsPerPage);
            
            ResultSet rs = st.executeQuery();
            
            while (rs.next()) {
                Schedule s = new Schedule();
                s.setId(rs.getInt("id"));
                s.setRid(rs.getInt("rid"));
                s.setTrid(rs.getString("trid"));
                s.setTrainType(rs.getString("train_type"));
                s.setFromStation(rs.getString("from_station"));
                s.setToStation(rs.getString("to_station"));
                s.setFromTime(rs.getTimestamp("from_time"));
                s.setToTime(rs.getTimestamp("to_time"));
                list.add(s);
            }
            
            rs.close();
            st.close();
            con.close();
        } catch (Exception e) {
            System.out.println("Error in getSchedulesByPage: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }
public Schedules searchScheduleWithTridNDate(String trid, Date date) throws Exception {
        String query = "SELECT * FROM Schedules WHERE (Date)from_time = ? AND trid = ?";
       Schedules schedule=new Schedules();
       
            try (PreparedStatement stmt = connection.prepareStatement(query)) {

                // Set parameters
                stmt.setDate(1, new java.sql.Date(date.getTime()));  // Convert java.util.Date to java.sql.Date
                stmt.setString(2, trid);

                // Execute query
                ResultSet rs = stmt.executeQuery();

                // Process the result set
                while (rs.next()) {
                   schedule.setFrom_time(date);
                   schedule.setId(rs.getInt(1));
                   schedule.setRid(rs.getInt(2));
                   schedule.setTrid(trid);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        

        return schedule;
    }
    public boolean createBooking(int userId, String scheduleId, String cabinId, 
                               double totalAmount, String paymentMethod, 
                               String contactName, String contactEmail, String contactPhone) {
        String sql = "INSERT INTO Booking (user_id, schedule_id, cabin_id, total_amount, " +
                    "payment_method, payment_status, contact_name, contact_email, " +
                    "contact_phone, booking_time, status) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), ?)";
        
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            st.setString(2, scheduleId);
            st.setString(3, cabinId);
            st.setDouble(4, totalAmount);
            st.setString(5, paymentMethod);
            st.setString(6, "completed"); // Payment status
            st.setString(7, contactName);
            st.setString(8, contactEmail);
            st.setString(9, contactPhone);
            st.setString(10, "confirmed"); // Booking status
            
            int rowsAffected = st.executeUpdate();
            
            if (rowsAffected > 0) {
                // Update cabin availability or mark seats as booked
                return updateCabinAvailability(scheduleId, cabinId);
            }
            return false;
        } catch (SQLException e) {
            System.out.println("Error creating booking: " + e.getMessage());
            return false;
        }
    }
    
    private boolean updateCabinAvailability(String scheduleId, String cabinId) {
        String sql = "UPDATE Cabin SET available_seats = available_seats - 1 " +
                    "WHERE id = ? AND schedule_id = ? AND available_seats > 0";
        
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, cabinId);
            st.setString(2, scheduleId);
            
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error updating cabin availability: " + e.getMessage());
            return false;
        }
    }

    public int createTicket(Tickets ticket) {
        String query = "INSERT INTO Tickets (from_station, to_station, from_date, to_date, ttype, trid,sid,rid,cbid) "
                    + "VALUES (?, ?, ?, ?, ?)";
        Timestamp timestamp1 = Timestamp.valueOf(ticket.getFrom_time());
        Timestamp timestamp2 = Timestamp.valueOf(ticket.getTo_time());
        try {
            PreparedStatement ps = connection.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setString(1, ticket.getFrom_station());
            ps.setString(2, ticket.getTo_station());
            ps.setTimestamp(3, timestamp1);
            ps.setTimestamp(4, timestamp2);
            ps.setInt(5, ticket.getTtype());
            ps.setString(6, ticket.getTrid());
            ps.setInt(7, ticket.getSid());
            ps.setInt(8, ticket.getRid());
            ps.setString(9, ticket.getCbid());
            
            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) {
                return -1;
            }
            
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error creating ticket: " + e.getMessage());
        }
        return -1;
    }
    
    public boolean createOrder(Order_Details order) {
        String query = "INSERT INTO Order_Details (tid,cid,status,total_price,payment_type,payment_date) "
                    + "VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, order.getTid());
            ps.setInt(2, order.getCid());
            ps.setInt(3, order.getStatus());
            ps.setDouble(4, order.getTotal_price());
            ps.setInt(5, order.getPayment_type());
            ps.setTimestamp(6, new Timestamp(order.getPayment_date().getTime()));
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error creating order: " + e.getMessage());
        }
        return false;
    }
    
    public boolean checkSeatAvailability(int trainId, String cabinId, int seatNumber) {
        String query = "SELECT COUNT(*) FROM Tickets WHERE train_id = ? AND cabin_id = ? AND seat_number = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, trainId);
            ps.setString(2, cabinId);
            ps.setInt(3, seatNumber);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) == 0; // Return true if seat is available (count = 0)
            }
        } catch (SQLException e) {
            System.out.println("Error checking seat availability: " + e.getMessage());
        }
        return false;
    }

    public static void main(String[] args) throws ParseException, Exception {
        DAO dao = new DAO();

//        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//        List<Schedules> listS= dao.searchSchedules(dao.searchRoute("Hà Nội", "Sài Gòn"), sdf.parse("2025-03-03"));
//        for (Schedules schedules : listS) {
//            List<Cabins> cabins=dao.searchCabinsWithTrainID(schedules.getTrid());
//            System.out.println(dao.searchAvailSeatsOfTrainWithScheduleID(schedules.getId()));
//            
//        }
//        System.out.println(dao.searchRoute("Hà Nội", "Sài Gòn"));
dao.searchCabinsWithTrainID("SE1");
        System.out.println(dao.searchCabinsWithTrainID("SE1").toString());
      //  System.out.println(dao.searchSchedules(dao.searchRoute("Hà Nội", "Sài Gòn"), sdf.parse("2025-03-03")));
        
        
//        System.out.println(dao.searchTrainIDWithRid(1));
//        System.out.println(dao.searchCabinsWithTrainID("SE1").get(0).toString());
//        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//        String dateString = "2025-02-22";
//        Date parsedDate = sdf.parse(dateString);
//        List<Schedules> list = dao.searchSchedules(dao.searchRoute("Hà Nội", "Sài Gòn"), parsedDate);
//        for (Schedules s : list) {
//            System.out.println(s);
//        }
//        System.out.println(dao.login("My", "123456"));

//        System.out.println(list);
//List<Accounts> listA = dao.getAllAccounts();
//        for (Routes o : list) {
//            System.out.println(o);
//        }

    }
}
