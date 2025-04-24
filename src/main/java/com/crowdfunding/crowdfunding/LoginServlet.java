package com.crowdfunding.crowdfunding;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.crowdfunding.crowdfunding.dao.User;
import com.crowdfunding.crowdfunding.repository.AuthenticationRepository;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "login", value = "/login")
public class LoginServlet extends HttpServlet {
    private AuthenticationRepository repository;

    @Override
    public void init() throws ServletException {
        repository = new AuthenticationRepository();
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        this.getServletContext().getRequestDispatcher("/login_page.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            final User user = repository.findByEmail(email);

            if(user != null) {
                final BCrypt.Result result = BCrypt.verifyer().verify(password.toCharArray(), user.getPassword());

                if(result.verified) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);
                    request.getRequestDispatcher("/project-list.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Invalid email or password");
                    request.getRequestDispatcher("/login_page.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Invalid email or password");
                request.getRequestDispatcher("/login_page.jsp").forward(request, response);
            }
        } catch (Exception e) {
          e.printStackTrace();
          response.getWriter().println(e.getMessage());
        }
    }

    public void destroy() {
    }
}