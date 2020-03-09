package config;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private static Connection connection = null;

    private String DBConnection(){
        String driver = "org.postgresql.Driver";
        String url = "jdbc:postgresql://localhost:5432/badwolfbookshop";
        String user = "postgres";
        String password = "Witter13";
        try{
            Class.forName(driver);
            connection = DriverManager.getConnection(url, user, password);
            return null;
        } catch (Exception e){
            return e.getMessage();
        }
    }

    public Connection getConnection(){
        if(connection == null)
            DBConnection();
        return connection;
    }

//    public static Connection getConnection(){
//        String server = "localhost";
//        String db = "badwolfbookshop";
//        String user = "postgres";
//        String pw = "Witter13";
//        try {
//            Class.forName("org.postgresql.Driver");
//            String path = "jdbc:postgresql://"+server+"/"+db;
//            Connection conn = DriverManager.getConnection(
//                    path,user,pw
//            );
//            return conn;
//        } catch (Exception e) {
//            System.out.println(e.getMessage());
//            return null;
//        }
//    }
//    public static void close(Connection conn){
//        if(conn!=null){
//            try {
//                conn.close();
//            } catch (Exception e) {
//                System.err.println(e.getMessage());
//            }
//        }
//    }

}
