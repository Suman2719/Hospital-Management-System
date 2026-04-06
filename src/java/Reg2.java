import java.io.*;

import javax.servlet.*;

import javax.servlet.http.*;
import newpackage1.*;

public class Reg2 extends HttpServlet{

public void doPost(HttpServletRequest request,

HttpServletResponse res) throws IOException,

ServletException
{
res.setContentType("text/html");

PrintWriter pw1=res.getWriter();
        String name = request.getParameter("n1");
        String gender = request.getParameter("n2");
        String email = request.getParameter("n3");
        String pass = request.getParameter("n4");
        String cpass = request.getParameter("n5");
        String dob = request.getParameter("n6");
        String cno = request.getParameter("n7");
        String address = request.getParameter("n8");
        String sq = request.getParameter("n9");
        String sa = request.getParameter("n10");
        String bloodgrp = request.getParameter("n11");
        
        // Server-side confirm password check
if(pass == null || pass.trim().isEmpty() || !pass.equals(cpass)) {
    pw1.println("<html>");
    pw1.println("<head><title>Registration Error</title></head>");
    pw1.println("<body style='font-family:Arial; text-align:center;'>");
    pw1.println("<h3 style='color:red;'>Passwords do not match or are empty. Please try again.</h3>");
    pw1.println("<a href='register.jsp'>Go Back to Registration</a>");
    pw1.println("</body>");
    pw1.println("</html>");
    return;  // Stop further processing
}

        

bean1 ob=new bean1();
ob.setName(name);
ob.setGender(gender);
ob.setEmail(email);
ob.setPass(pass);
ob.setDob(dob);
ob.setCno(cno);
ob.setAddress(address);
ob.setSq(sq);
ob.setSa(sa);
ob.setBloodgrp(bloodgrp);
boolean result= ob.InsertMethod();
if(result==true){
     pw1.println("<h3 style='color:green;'>Registration Successful!</h3>");
    pw1.println("<a href='patientlogin.jsp'>Login Here</a>");
}
else{
   pw1.println("<h3 style='color:red;'>Registration Failed. Try again.</h3>");
    pw1.println("<a href='register.jsp'>Go Back</a>");
}}}
