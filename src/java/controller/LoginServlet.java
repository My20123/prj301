/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Accounts;

/**
 *
 * @author Nguyen Duc Tuan
 */
public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
         HttpSession session = request.getSession();
        String username = request.getParameter("user");
        String password = request.getParameter("pass");
        
        DAO dao = new DAO();
        Accounts a = dao.login(username, password);
        if(a==null){
            request.setAttribute("mess", "Wrong user or pass! Try again");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }else{
           session.setAttribute("acc", a);
             session.setMaxInactiveInterval(1000);
             response.sendRedirect("home");
        }
//         response.setContentType("text/html;charset=UTF-8");
//     PrintWriter pr = response.getWriter();
//     String xName = request.getParameter("user");
//     String xPass = request.getParameter("pass");
//     Accounts x;
//     DAO t = new DAO();
//     x = t.login(xName, xPass);
//     request.getSession().setAttribute("currUser", x);
//     String logResult = "";
//     if(x==null) { 
//       logResult = "Sorry, username and/or password are/is invalid!";  
//      }
//      else {
//       logResult = "Login is successful!";  
//     }
//     pr.print(logResult);  
//     response.sendRedirect("home");
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
