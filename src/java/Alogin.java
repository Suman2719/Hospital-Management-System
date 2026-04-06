import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class Alogin extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String email = request.getParameter("email").trim().toLowerCase();
        String password = request.getParameter("password");

        try {
            // Load Oracle JDBC driver
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:XE", "system", "SUMAN");

            String q = "SELECT * FROM admin WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(q);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                // Valid admin, create session
                HttpSession session = request.getSession();
                session.setAttribute("adminEmail", email);
                session.setAttribute("adminName", rs.getString("name"));
                response.sendRedirect("adash.jsp");
            } else {
                out.println("<h3 style='color:red;'>Invalid Admin Credentials!</h3>");
                out.println("<a href='alogin.jsp'>Try Again</a>");
            }

            rs.close();
            ps.close();
            con.close();
        } catch(Exception e) {
            out.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
