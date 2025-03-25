package controller;

import dal.DAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class AddAccountServlet
 */
@WebServlet(name = "AddAccount", urlPatterns = {"/addA"})
public class AddAccount extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy dữ liệu từ form
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String role = request.getParameter("role");
        String phone = request.getParameter("phone");

        // Xác định vai trò
        int isAdmin = 0;
        int isSell = 0;
        if ("admin".equals(role)) {
            isAdmin = 1;
        } else if ("seller".equals(role)) {
            isSell = 1;
        }

        // Thêm tài khoản vào cơ sở dữ liệu
        DAO dao = new DAO();
        dao.addAccount(name, "123456", email, isSell, isAdmin, phone);

        // Trả về trạng thái thành công
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().write("Tài khoản đã được thêm thành công!");
    }
}