<!DOCTYPE html>
<html>
<head>
    <title> Welcome </title>
    <link href='http://fonts.googleapis.com/css?family=Roboto:400'
              rel='stylesheet' type='text/css'>
        <link rel="stylesheet" type="text/css" href="welcome.css">
    <script src="welcome.js" type="text/javascript"></script>

<%@ page import ="java.sql.*" %>
</head>
<body>
    <p id="welcomeUser">Welcome <% out.println(session.getAttribute("name")); %> </p>
    <button id="storeButton" name="storeButton" onclick="showStorePass()">Store Passwords</button>
    <button id="viewBotton" id="viewBotton" onclick="showViewPass()" >View Passwords</button>
  
    <form id="storeForm" action="passwordManagerWelcome.jsp" method="POST">
        <legend id="storeLegend"> Store Passwords </legend>
        <input placeholder = "Username/UserID" name="uEmail" type="text" required />
        <input placeholder = "Password" type="password" name="uPassword" required />
        <button type="submit"> Store </button>
    </form>
    <%
    String dbUrl = "jdbc:mysql://localhost:3306/passwordmanager";
    String dbusername = "root";
    String dbpassword = "lmps2806";
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection(dbUrl, dbusername , dbpassword);
    int uid = Integer.parseInt(session.getAttribute("uid").toString());
    String username = request.getParameter("semail");
    String password = request.getParameter("spassword");

    String storepass = "insert into store(sid,semail,spassword) values(?,?,?)";
    PreparedStatement stmnt = conn.prepareStatement(storepass);
    stmnt.setInt(1,uid);
    stmnt.setString(2,username);
    stmnt.setString(3,password);
    int result = stmnt.executeUpdate();
    if(result>0)
    {
        out.println("<p> Saved</p>");   
    } else {
        out.println("<p> Not Saved</p>");
    }
   %>

    <table id="viewTable">
        <caption id="caption"> Stored Passwords </caption>
        <tr>
            <th>Username/UserID</th>
            <th>Password</th>

        </tr>
        <tr>
   <%
    int vuid = Integer.parseInt(session.getAttribute("uid").toString());
        
    String viewpass = "select semail,spassword from store where id=?";
    PreparedStatement vstmnt = conn.prepareStatement(viewpass);
    vstmnt.setInt(1,vuid);
    ResultSet vresult = vstmnt.executeQuery();
    
    while(vresult.next())
    {
        out.println("<tr> <td>"+ vresult.getString("semail")+"</td>" );
        out.println("<td>"+ vresult.getString("spassword")+"</td></tr>" );
    }
    %>        
    </table>

</body>
</html>
