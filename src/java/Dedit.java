import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class Dedit extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String specialization = request.getParameter("specialization");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String degree = request.getParameter("degree");
         String fees = request.getParameter("fees");

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:XE", "system", "SUMAN");

            String q = "UPDATE doctor SET name=?, specialization=?, email=?, phone=?, degree=?, fees=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(q);
            ps.setString(1, name);
            ps.setString(2, specialization);
            ps.setString(3, email);
            ps.setString(4, phone);
            ps.setString(5, degree);
            ps.setString(6, fees);
            ps.setString(7, id);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("dview.jsp"); // Back to doctor list
            } else {
                out.println("Update failed!");
            }

            ps.close();
            con.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
