<%@ page import ="java.sql.*" %>
<% 
String username = request.getParameter("email");
String password = request.getParameter("password");
String dbUrl = "jdbc:mysql://localhost:3306/passwordmanager";
String dbusername = "root";
String dbpassword = "lmps2806";

Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection(dbUrl, dbusername , dbpassword);
String login = "select uid,name from users where email=? and password=?";
PreparedStatement stmnt = conn.prepareStatement(login);
stmnt.setString(1,username);
stmnt.setString(2,password);

ResultSet result = stmnt.executeQuery();
    if(result.next())
    {
        session.setAttribute("uid",result.getString("uid"));
        session.setAttribute("name",result.getString("name"));
        response.sendRedirect("passwordManagerWelcome.jsp");   
    } else {
        response.sendRedirect("passwordManagerLogin.html");
    }
%>