package controller;

//import com.google.gson.Gson;
//import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.BufferedReader;

@WebServlet(name = "UpdateSeatSession", urlPatterns = {"/UpdateSeatSession"})
public class UpdateSeatSession extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            // Read JSON data from request body
            BufferedReader reader = request.getReader();
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
            
            // Parse JSON
//            Gson gson = new Gson();
//            JsonObject seatInfo = gson.fromJson(sb.toString(), JsonObject.class);
            
            // Get seat information
//            String seatNumber = seatInfo.get("seatNumber").getAsString();
//            String price = seatInfo.get("price").getAsString();
            
            // Store in session
//            HttpSession session = request.getSession();
//            session.setAttribute("selectedSeatNumber", seatNumber);
//            session.setAttribute("selectedSeatPrice", price);
            
            // Send success response
////            JsonObject jsonResponse = new JsonObject();
//            jsonResponse.addProperty("success", true);
//            out.println(jsonResponse.toString());
        } catch (Exception e) {
            // Send error response
//            JsonObject jsonResponse = new JsonObject();
//            jsonResponse.addProperty("success", false);
//            jsonResponse.addProperty("error", e.getMessage());
//            response.getWriter().println(jsonResponse.toString());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet to update seat selection in session";
    }
}
