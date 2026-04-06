package newpackage1;
import java.sql.*;
public class javabean2 {
   
    private String email;
 private String pass;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public boolean ViewMethod(){
     try{
            
             Class.forName("oracle.jdbc.driver.OracleDriver"); // Registering type4 driver, this linev also 
         Connection con = DriverManager.getConnection(
        "jdbc:oracle:thin:@localhost:1521:XE", "system", "SUMAN");//these two lines are for connection to the database
         Statement stmt = con.createStatement();
         
         email = email.trim().toLowerCase();

          String q1 = "select * from preg where email='"+email+"' and pass='"+pass+"'" ;// single qoutes are used only in varchar not in varint
        
        ResultSet rs=stmt.executeQuery(q1);
          if (rs.next()){
              return true;
          }
     else
          {
          return false;
          }
     }
     catch(Exception e){
         
     }
     return false;
    }    
}