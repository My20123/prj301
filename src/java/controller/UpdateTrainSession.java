package controller;

import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Routes;
import model.Schedules;

@WebServlet(name = "UpdateTrainSession", urlPatterns = {"/UpdateTrainSession"})
public class UpdateTrainSession extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException, Exception {
        response.setContentType("application/json;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String trainId = request.getParameter("trainId");
            
            if (trainId != null && !trainId.isEmpty()) {
                // Store trainId in session
                HttpSession session = request.getSession();
                session.setAttribute("trainId", trainId);
                
                // Send success response
                out.println("{\"success\": true}");
                
                 // Get DAO instance
            DAO dao = new DAO();
            
            // Get list of all stations for the form
            List<String> listS = dao.getAllStations();
            request.setAttribute("dao", dao);
            request.setAttribute("listS", listS);
            
            // Get form parameters
            String tripType = request.getParameter("trip_type");
            String fromStation = request.getParameter("from_station");
            String toStation = request.getParameter("to_station");
            String fromDate = request.getParameter("input_from");
            String returnDate = request.getParameter("input_to");
            
            // Set form values as attributes to maintain them after search
            request.setAttribute("trip_type", tripType);
            request.setAttribute("depart", fromStation);
            request.setAttribute("desti", toStation);
            request.setAttribute("from_date", fromDate);
            request.setAttribute("return_date", returnDate);
            
            // Validate input
            if (fromStation == null || toStation == null || fromDate == null || 
                fromStation.trim().isEmpty() || toStation.trim().isEmpty() || fromDate.trim().isEmpty() ||
                ("roundTrip".equals(tripType) && (returnDate == null || returnDate.trim().isEmpty()))) {
                request.setAttribute("error", "Please fill in all required fields");
                request.getRequestDispatcher("SearchResult.jsp").forward(request, response);
                return;
            }
            
            // Parse dates
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date departDate = sdf.parse(fromDate);
            Date returnDateObj = null;
            if ("roundTrip".equals(tripType) && returnDate != null && !returnDate.trim().isEmpty()) {
                returnDateObj = sdf.parse(returnDate);
            }
            // Search for departure routes and schedules
            List<Routes> departRoutes = dao.searchRoute(fromStation, toStation);
            List<Schedules> departSchedules = dao.searchSchedules(departRoutes, departDate);
            
            // Set departure schedules attribute
            request.setAttribute("departSchedules", departSchedules);
            } else {
                // Send error response
                out.println("{\"success\": false, \"error\": \"Invalid trainId\"}");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(UpdateTrainSession.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String trainId = request.getParameter("trainId");
            
            if (trainId != null && !trainId.isEmpty()) {
                // Store trainId in session
                HttpSession session = request.getSession();
                session.setAttribute("trainId", trainId);
                
                // Send success response
                out.println("{\"success\": true}");
                
                 // Get DAO instance
            DAO dao = new DAO();
            
            // Get list of all stations for the form
            List<String> listS = dao.getAllStations();
            request.setAttribute("dao", dao);
            request.setAttribute("listS", listS);
            
            // Get form parameters
            String tripType = request.getParameter("trip_type");
            String fromStation = request.getParameter("from_station");
            String toStation = request.getParameter("to_station");
            String fromDate = request.getParameter("input_from");
            String returnDate = request.getParameter("input_to");
            
            // Set form values as attributes to maintain them after search
            request.setAttribute("trip_type", tripType);
            request.setAttribute("depart", fromStation);
            request.setAttribute("desti", toStation);
            request.setAttribute("from_date", fromDate);
            request.setAttribute("return_date", returnDate);
            
            // Validate input
            if (fromStation == null || toStation == null || fromDate == null || 
                fromStation.trim().isEmpty() || toStation.trim().isEmpty() || fromDate.trim().isEmpty() ||
                ("roundTrip".equals(tripType) && (returnDate == null || returnDate.trim().isEmpty()))) {
                request.setAttribute("error", "Please fill in all required fields");
                request.getRequestDispatcher("SearchResult.jsp").forward(request, response);
                return;
            }
            
            // Parse dates
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date departDate = sdf.parse(fromDate);
            Date returnDateObj = null;
            if ("roundTrip".equals(tripType) && returnDate != null && !returnDate.trim().isEmpty()) {
                returnDateObj = sdf.parse(returnDate);
            }
            // Search for departure routes and schedules
            List<Routes> departRoutes = dao.searchRoute(fromStation, toStation);
            List<Schedules> departSchedules = dao.searchSchedules(departRoutes, departDate);
            
            // Set departure schedules attribute
            request.setAttribute("departSchedules", departSchedules);
            } else {
                // Send error response
                out.println("{\"success\": false, \"error\": \"Invalid trainId\"}");
            }
        } catch (Exception ex) {
            Logger.getLogger(UpdateTrainSession.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet to update train ID in session";
    }
}
