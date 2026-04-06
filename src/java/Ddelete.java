import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class Ddelete extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String id = request.getParameter("id");

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:XE", "system", "SUMAN");

            String q = "DELETE FROM doctor WHERE id=?";
            PreparedStatement ps = con.prepareStatement(q);
            ps.setString(1, id);

            int rows = ps.executeUpdate();
            ps.close();
            con.close();

            if (rows > 0) {
                response.sendRedirect("dview.jsp?msg=Doctor+Deleted+Successfully");
            } else {
                response.sendRedirect("dview.jsp?msg=Doctor+Not+Found");
            }

        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
            e.printStackTrace(out);
        }
    }
}
