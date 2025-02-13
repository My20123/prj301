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


public class SignupServlet extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      String user = request.getParameter("user");
      String pass = request.getParameter("pass");
      String re_pass = request.getParameter("repass");
      if(!pass.equals(re_pass)){
          response.sendRedirect("Login.jsp");
      }else{
          DAO dao = new DAO();
          Accounts a = dao.checkAccountExist(user);
          if(a == null){
              //signup
              dao.singup(user, pass);
              response.sendRedirect("home");
          }else{
              request.setAttribute("error","Tài khoản đã tồn tại, vui lòng thử tài khoản khác.");
              response.sendRedirect("Login.jsp");
          }
      }
      
      
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       response.setContentType("text/html;charset=UTF-8");
        String user = request.getParameter("user");
      String pass = request.getParameter("pass");
      String re_pass = request.getParameter("repass");
      if(!pass.equals(re_pass)){
          response.sendRedirect("Login.jsp");
      }else{
          DAO dao = new DAO();
          Accounts a = dao.checkAccountExist(user);
          if(a == null){
              //signup
              dao.singup(user, pass);
              response.sendRedirect("home");
          }else{
              request.setAttribute("error","Tài khoản đã tồn tại, vui lòng thử tài khoản khác.");
              response.sendRedirect("Login.jsp");
          }
      }
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