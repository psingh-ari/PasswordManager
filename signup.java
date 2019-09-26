import java.sql.*;

public class signup {

	public static void main(String[] args) throws SQLException {

		Connection myConn = null;
		Statement myStmt = null;
		ResultSet myRs = null;
		
		String dbUrl = "jdbc:mysql://localhost:3306/passwordmanager";
		String dbusername = "root";
		String dbpassword = "lmps2806";

		try {
			// 1. Get a connection to database
			myConn = DriverManager.getConnection(dbUrl, dbusername , dbpassword);
			
			// 2. Create a statement
			myStmt = myConn.createStatement();

			// 3. Insert a new user
			System.out.println("Inserting a new user to database\n");
			
			int rowsAffected = myStmt.executeUpdate(
				"INSERT INTO users " +
				"(name,email,password) " + 
				"VALUES " + 
				"('admin1','admin1@admin.com','admin1')");
			
			// 4. Verify this by getting a list of users
			myRs = myStmt.executeQuery("select * from users");
			
			// 5. Process the result set
			while (myRs.next()) {
				System.out.println(myRs.getString("name") + ", " + myRs.getString("email"));
			}
		}
		catch (Exception exc) {
			exc.printStackTrace();
		}
		finally {
			if (myRs != null) {
				myRs.close();
			}
			
			if (myStmt != null) {
				myStmt.close();
			}
			
			if (myConn != null) {
				myConn.close();
			}
		}
	}

}



