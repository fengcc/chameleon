<%@page import="java.sql.*" 
import ="java.util.*" 
import ="java.io.*" 
contentType="text/html;charset=UTF-8"
pageEncoding="UTF-8"
%> 

<%
    String mac1="";
    mac1=request.getParameter("mac");
    out.println("<table border=1>");
    if(request.getParameter("id")==null){
      response.sendRedirect("./Register.jsp?MSG="+"Please enter UserName"+"&"+"mac="+mac1);  
    }
   
    try{
    
      Class.forName("com.mysql.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ChameleonAC?user=root&password=52048436");
      Statement stmt = conn.createStatement();
      ResultSet rs = stmt.executeQuery("select * from account where ssid='"+request.getParameter("id")+"'"); 
      if(rs.next()){
        response.sendRedirect("./Register.jsp?MSG="+"UserName has been used "+"&"+"mac="+mac1);
      }else{
          try{
             int rs1=stmt.executeUpdate("insert into account(ssid, psw, mac) values('"+request.getParameter("id")+"','"+request.getParameter("password1")+"','"+mac1+"')");
             if(rs1!=0){
               response.sendRedirect("./RegisterSuccess.jsp?mac="+mac1); 
             }
           
          }catch(Exception e){
            e.printStackTrace();
            response.sendRedirect("./Register.jsp?MSG="+"failure"+"&"+"mac="+mac1);
          } 
      }

      out.println("</table>");
    }catch(Exception e){
            response.sendRedirect("./Register.jsp?MSG="+"failure"+"&"+"mac="+mac1);
    } 
     
%>   