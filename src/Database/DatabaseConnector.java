package Database;

import java.sql.*;

public class DatabaseConnector {
    static Connection con;
    public static Connection DatabaseConnector() {
        String url = "jdbc:mysql://localhost:3306/sharecalendar?&serverTimezone=Asia/Seoul";
        String userid = "root";
        String pwd = "root";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch(ClassNotFoundException e) {
            e.printStackTrace();
            return null;
        }

        try {
            con = DriverManager.getConnection(url, userid, pwd);
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String args[]) {
        new DatabaseConnector();
    }
}
