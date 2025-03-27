package controller;

import dal.DAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.Accounts;


@WebServlet(name = "EditAccountServlet", urlPatterns = {"/editA"})
public class EditAccount extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String user = request.getParameter("user");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        int isSell = request.getParameter("role").equals("seller") ? 1 : 0;
        int isAdmin = request.getParameter("role").equals("admin") ? 1 : 0;

        Accounts account = new Accounts(id, user,"123456", email, isSell, isAdmin, phone);
        DAO dao = new DAO();
        dao.updateAccount(account);

        response.sendRedirect("viewA");
    }
}