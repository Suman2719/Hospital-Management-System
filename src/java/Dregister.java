import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class Dregister extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String name = request.getParameter("name");
        String specialization = request.getParameter("specialization");
        String email = request.getParameter("email").trim().toLowerCase();
        String phone = request.getParameter("phone");
        String degree = request.getParameter("degree");
        String fees = request.getParameter("fees");
        String password = request.getParameter("password");

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:XE", "system", "SUMAN");

            // Insert into doctor table
            String insert = "INSERT INTO doctor(id, name, specialization, email, phone, fees, degree, password) " +
                            "VALUES (doctor_seq.nextval, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(insert);
            ps.setString(1, name);
            ps.setString(2, specialization);
            ps.setString(3, email);
            ps.setString(4, phone);
            ps.setString(5, fees);
            ps.setString(6, degree);
            ps.setString(7, password);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                out.println("<h3 style='color:green;'>Doctor registered successfully!</h3>");
            } else {
                out.println("<h3 style='color:red;'>Registration failed!</h3>");
            }

            ps.close();
            con.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
            e.printStackTrace();
        }

        out.println("<br><a href='adash.jsp'>Back to Dashboard</a>");
    }
}
