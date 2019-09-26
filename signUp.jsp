<%@ page import ="java.sql.*" %>
<% 
String name = request.getParameter("name");
String username = request.getParameter("email");
String password = request.getParameter("password");
String dbUrl = "jdbc:mysql://localhost:3306/passwordmanager";
String dbusername = "root";
String dbpassword = "lmps2806";

Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection(dbUrl, dbusername , dbpassword);
String signup = "insert into users(name,email,password) values(?,?,?)";
PreparedStatement stmnt = conn.prepareStatement(signup);
stmnt.setString(1,name);
stmnt.setString(2,username);
stmnt.setString(3,password);
int result = stmnt.executeUpdate();

    if(result>0)
    {
        String fetchId = "select uid from users where name=? and email=? and password=?";
        PreparedStatement prepareStmnt = conn.prepareStatement(fetchId);
        prepareStmnt.setString(1,name);
        prepareStmnt.setString(2,username);
        prepareStmnt.setString(3,password);
        ResultSet resultset = prepareStmnt.executeQuery();
        if(resultset.next())
            session.setAttribute("uid",resultset.getString("uid"));

        session.setAttribute("name",name);
        response.sendRedirect("passwordManagerWelcome.jsp");   
    } else {
        response.sendRedirect("passwordManagerLogin.html");
    }
%>