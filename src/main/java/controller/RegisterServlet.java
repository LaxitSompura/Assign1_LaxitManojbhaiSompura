package controller;

import java.io.IOException;

import dao.RegisterDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Registration;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.sendRedirect(req.getContextPath() + "/index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Registration r = new Registration();
        r.setUserId(req.getParameter("userid"));
        r.setPassword(req.getParameter("passid"));
        r.setName(req.getParameter("username"));
        r.setAddress(req.getParameter("address"));
        r.setCountry(req.getParameter("country"));
        r.setZip(req.getParameter("zip"));
        r.setEmail(req.getParameter("email"));
        r.setSex(req.getParameter("sex"));
        r.setLanguage(req.getParameterValues("language"));
        r.setAbout(req.getParameter("about"));

        RegisterDao dao = new RegisterDao();
        int status = dao.register(r);

        if (status == -1) {
            req.setAttribute("useridError", "User id already exists. Choose another.");
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
            return;
        }

        if (status == -2) {
            req.setAttribute("emailError", "Email already exists. Use another email.");
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
            return;
        }

        if (status > 0) {
            req.setAttribute("reg", r);
            req.getRequestDispatcher("/success.jsp").forward(req, resp);
        } else {
            req.setAttribute("generalError", "Registration failed. Please try again.");
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
        }
    }
}
