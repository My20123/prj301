package controller;

import dal.DAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Schedules;
import model.Cabins;
import model.Accounts;

@WebServlet(name = "PaymentServlet", urlPatterns = {"/payment"})
public class PaymentServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        
        if (action == null) {
            // Display payment page
            showPaymentPage(request, response);
        } else if (action.equals("process")) {
            // Process payment
            processPayment(request, response);
        }
    }

    private void showPaymentPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            Accounts user = (Accounts) session.getAttribute("user");
            
            if (user == null) {
                response.sendRedirect("login");
                return;
            }
            
            // Get schedule and cabin information
            String scheduleId = request.getParameter("scheduleId");
            String cabinId = request.getParameter("cabinId");
            
            DAO dao = new DAO();
//            Schedules schedule = dao.getSchedulesById(scheduleId);
//            Cabins cabin = dao.getCabinsById(cabinId);
            
//            if (schedule == null || cabin == null) {
//                response.sendRedirect("search");
//                return;
//            }
//            
//            // Calculate total amount based on cabin price and any additional fees
//            double totalAmount = calculateTotalAmount(cabin);
//            
//            // Set attributes for the payment page
//            request.setAttribute("schedule", schedule);
//            request.setAttribute("cabin", cabin);
//            request.setAttribute("totalAmount", totalAmount);
            
            // Forward to payment page
            request.getRequestDispatcher("payment.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void processPayment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            Accounts user = (Accounts) session.getAttribute("user");
            
            if (user == null) {
                response.sendRedirect("login");
                return;
            }
            
            // Get payment details
            String scheduleId = request.getParameter("scheduleId");
            String cabinId = request.getParameter("cabinId");
            String paymentMethod = request.getParameter("paymentMethod");
            double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
            
            // Get contact information
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            
            // Validate payment information based on payment method
            boolean paymentValid = validatePayment(request, paymentMethod);
            
            if (!paymentValid) {
                request.setAttribute("error", "Invalid payment information");
                showPaymentPage(request, response);
                return;
            }
            
            // Process payment based on payment method
            boolean paymentSuccess = processPaymentTransaction(paymentMethod, totalAmount);
            
            if (paymentSuccess) {
                // Create booking record
                DAO dao = new DAO();
                boolean bookingSuccess = dao.createBooking(user.getId(), scheduleId, cabinId, 
                                                         totalAmount, paymentMethod, name, email, phone);
                
                if (bookingSuccess) {
                    // Redirect to success page
                    response.sendRedirect("booking-success.jsp");
                } else {
                    // Handle booking failure
                    request.setAttribute("error", "Failed to create booking");
                    showPaymentPage(request, response);
                }
            } else {
                // Handle payment failure
                request.setAttribute("error", "Payment failed");
                showPaymentPage(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
    
    private double calculateTotalAmount(Cabins cabin) {
        // Add logic to calculate total amount based on cabin price and any additional fees
//        return cabin.getPrice();
return 0;
    }
    
    private boolean validatePayment(HttpServletRequest request, String paymentMethod) {
        switch (paymentMethod) {
            case "credit":
                String cardNumber = request.getParameter("cardNumber");
                String expiry = request.getParameter("expiry");
                String cvv = request.getParameter("cvv");
                return validateCreditCard(cardNumber, expiry, cvv);
                
            case "banking":
                String bankName = request.getParameter("bankName");
                return bankName != null && !bankName.isEmpty();
                
            case "momo":
                // Add MoMo-specific validation if needed
                return true;
                
            default:
                return false;
        }
    }
    
    private boolean validateCreditCard(String cardNumber, String expiry, String cvv) {
        // Add credit card validation logic
        return cardNumber != null && !cardNumber.isEmpty() &&
               expiry != null && !expiry.isEmpty() &&
               cvv != null && !cvv.isEmpty();
    }
    
    private boolean processPaymentTransaction(String paymentMethod, double amount) {
        // Add actual payment processing logic based on the payment method
        // This is a placeholder that always returns true
        return true;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
