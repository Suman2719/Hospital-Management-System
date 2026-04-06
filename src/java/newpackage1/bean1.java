package newpackage1;
import java.sql.*;
public class bean1 {
    private String name;
    private String gender;
    private String email;
    private String pass;
    private String dob;
    private String cno;
    private String address;
    private String sq;
    private String sa;
    private String bloodgrp;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

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

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getCno() {
        return cno;
    }

    public void setCno(String cno) {
        this.cno = cno;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getSq() {
        return sq;
    }

    public void setSq(String sq) {
        this.sq = sq;
    }

    public String getSa() {
        return sa;
    }

    public void setSa(String sa) {
        this.sa = sa;
    }

    public String getBloodgrp() {
        return bloodgrp;
    }

    public void setBloodgrp(String bloodgrp) {
        this.bloodgrp = bloodgrp;
    }

    
    
    public boolean InsertMethod(){
     try{
            
             Class.forName("oracle.jdbc.driver.OracleDriver"); // Registering type4 driver, this linev also 
         Connection con = DriverManager.getConnection(
        "jdbc:oracle:thin:@localhost:1521:XE", "system", "SUMAN");//these two lines are for connection to the database
         Statement stmt = con.createStatement();
         email = email.trim().toLowerCase();

          String q1 = "insert into preg values('"+name+"','"+gender+"','"+email+"','"
                    +pass+"',TO_DATE('"+dob+"','YYYY-MM-DD'),'"+cno+"','"
                    +address+"','"+sq+"','"+sa+"','"+bloodgrp+"')";
          int x=stmt.executeUpdate(q1);
          if(x>0){
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








