package com.crowdfunding.crowdfunding;

import com.crowdfunding.crowdfunding.utils.DatabaseConnector;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "login", value = "/login")
public class LoginServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        this.getServletContext().getRequestDispatcher("/login_page.jsp").forward(request, response);
    }

    public void destroy() {
    }
}