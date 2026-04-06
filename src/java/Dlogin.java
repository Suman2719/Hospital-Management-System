import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class Dlogin extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:XE", "system", "SUMAN");

            String q = "SELECT * FROM doctor WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(q);
            ps.setString(1, email.trim().toLowerCase());
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Save session
                HttpSession session = request.getSession();
                session.setAttribute("doctorEmail", email.trim().toLowerCase());
                session.setAttribute("doctorName", rs.getString("name"));

                response.sendRedirect("ddash.jsp");
            } else {
                out.println("<h3 style='color:red;'>Invalid Email or Password!</h3>");
                out.println("<a href='dlogin.jsp'>Try Again</a>");
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
