import java.io.*;

import javax.servlet.*;

import javax.servlet.http.*;
import newpackage1.*;

public class Pl2 extends HttpServlet{

public void doPost(HttpServletRequest req,

HttpServletResponse res) throws IOException,

ServletException
{
res.setContentType("text/html");

PrintWriter pw1=res.getWriter();
String email=req.getParameter("n1");
String pass=req.getParameter("n2");

email = email.trim().toLowerCase();

javabean2 ob=new javabean2();
ob.setEmail(email);
ob.setPass(pass);
boolean result= ob.ViewMethod();
if(result==true){
  
            HttpSession session = req.getSession();
            session.setAttribute("patientEmail", email);

            
            res.sendRedirect("pdash.jsp");
}
else{
    pw1.println("<h3 style='color:red;'>Invalid Email or Password!</h3>");
    pw1.println("<a href='patientlogin.jsp'>Try Again</a>");
}}}
