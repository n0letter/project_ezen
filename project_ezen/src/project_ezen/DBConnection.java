package project_ezen;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection 
{
	public static Connection getConnection() throws Exception {
			
    	Connection conn = null;
        try {
            String user = "userid"; //ezen
            String pw = "1234"; //1234
            String url = "jdbc:oracle:thin:@localhost:1521:xe"; //고정 xe:express버젼, orcl:일반버전
            
            Class.forName("oracle.jdbc.driver.OracleDriver");        
            conn = DriverManager.getConnection(url, user, pw);
            
            System.out.println("Database가 연결되었습니다.\n");
            
        } catch (ClassNotFoundException cnfe) {
            System.out.println("DB 연결실패(ClassNotFoundException):"+cnfe.toString());
        } catch (SQLException sqle) {
            System.out.println("DB 연결실패(SQLException): "+sqle.toString());
        } catch (Exception e) {
            System.out.println("Unkonwn error");
            e.printStackTrace();
        }
        return conn;     

	}
}