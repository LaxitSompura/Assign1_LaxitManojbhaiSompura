package controller;

import java.io.IOException;
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

        req.setAttribute("reg", r);
        req.getRequestDispatcher("/success.jsp").forward(req, resp);
    }
}
