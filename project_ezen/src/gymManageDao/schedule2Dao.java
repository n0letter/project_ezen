package gymManageDao;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;

import gymManageDto.schedule2Dto;
import project_ezen.DBConnection;


public class schedule2Dao {

//	컨텐츠 페이지
	public static schedule2Dto scheduleView2(HttpServletRequest request) {
		Connection conn = null;  
		PreparedStatement pstmt = null; 
		schedule2Dto dto2 = null;
        String schedule2_idx = request.getParameter("member_idx");//매개변수 입력 편하게 함. 
        ResultSet rs = null;    
        System.out.println("관리자 번호 : " + schedule2_idx);
        try {
        	conn = DBConnection.getConnection();
        	String query = "select * from gym_schedule2 where gym_schedule2_idx=?";
        	System.out.println(query);
        	pstmt = conn.prepareStatement( query  );
        	pstmt.setInt(1, Integer.parseInt( schedule2_idx )); //첫번째 인자(물음표)
        	rs = pstmt.executeQuery(); //select
        	
        	
        	while( rs.next() ) {	
        		int gym_schedule2_idx = rs.getInt("gym_schedule2_idx");
        		int gym_schedule2_content = rs.getInt("gym_schedule2_content");
	            String gym_mon201 = rs.getString("gym_mon201");
	            String gym_mon202 = rs.getString("gym_mon202");
	            String gym_mon203 = rs.getString("gym_mon203");
	            String gym_mon204 = rs.getString("gym_mon204");
	            String gym_tue201 = rs.getString("gym_tue201");
	            String gym_tue202 = rs.getString("gym_tue202");
	            String gym_tue203 = rs.getString("gym_tue203");
	            String gym_tue204 = rs.getString("gym_tue204");
	            String gym_wed201 = rs.getString("gym_wed201");
	            String gym_wed202 = rs.getString("gym_wed202");
	            String gym_wed203 = rs.getString("gym_wed203");
	            String gym_wed204 = rs.getString("gym_wed204");
	            String gym_thu201 = rs.getString("gym_thu201");
	            String gym_thu202 = rs.getString("gym_thu202");
	            String gym_thu203 = rs.getString("gym_thu203");
	            String gym_thu204 = rs.getString("gym_thu204");
	            String gym_fri201 = rs.getString("gym_fri201");
	            String gym_fri202 = rs.getString("gym_fri202");
	            String gym_fri203 = rs.getString("gym_fri203");
	            String gym_fri204 = rs.getString("gym_fri204");
	            String gym_sat201 = rs.getString("gym_sat201");
	            String gym_sat202 = rs.getString("gym_sat202");
	            String gym_sat203 = rs.getString("gym_sat203");
	            String gym_sat204 = rs.getString("gym_sat204");
	            String gym_sun201 = rs.getString("gym_sun201");
	            String gym_sun202 = rs.getString("gym_sun202");
	            String gym_sun203 = rs.getString("gym_sun203");
	            String gym_sun204 = rs.getString("gym_sun204");
	            
	            dto2 = new schedule2Dto( gym_schedule2_idx, gym_schedule2_content, gym_mon201,gym_mon202,gym_mon203,gym_mon204,gym_tue201,gym_tue202,gym_tue203,gym_tue204,gym_wed201,gym_wed202,gym_wed203,gym_wed204,gym_thu201,gym_thu202,gym_thu203,gym_thu204,gym_fri201,gym_fri202,gym_fri203,gym_fri204,gym_sat201,gym_sat202,gym_sat203,gym_sat204,gym_sun201,gym_sun202,gym_sun203,gym_sun204);
        	}
        	int result = pstmt.executeUpdate();
        }
        catch( Exception e ) {
        	e.printStackTrace();
        }
		
		return dto2;
	}	
	
	public static schedule2Dto scheduleViewmain2(HttpServletRequest request) {
		Connection conn = null;  
		PreparedStatement pstmt = null; 
		schedule2Dto dto2 = null;
        ResultSet rs = null;    
        try {
        	conn = DBConnection.getConnection();
        	String query = "select * from gym_schedule2 where gym_schedule2_content=20";
        	System.out.println(query);
        	pstmt = conn.prepareStatement( query  );
        	rs = pstmt.executeQuery(); //select
        	
        	
        	while( rs.next() ) {	
        		int gym_schedule2_idx = rs.getInt("gym_schedule2_idx");
        		int gym_schedule2_content = rs.getInt("gym_schedule2_content");
	            String gym_mon201 = rs.getString("gym_mon201");
	            String gym_mon202 = rs.getString("gym_mon202");
	            String gym_mon203 = rs.getString("gym_mon203");
	            String gym_mon204 = rs.getString("gym_mon204");
	            String gym_tue201 = rs.getString("gym_tue201");
	            String gym_tue202 = rs.getString("gym_tue202");
	            String gym_tue203 = rs.getString("gym_tue203");
	            String gym_tue204 = rs.getString("gym_tue204");
	            String gym_wed201 = rs.getString("gym_wed201");
	            String gym_wed202 = rs.getString("gym_wed202");
	            String gym_wed203 = rs.getString("gym_wed203");
	            String gym_wed204 = rs.getString("gym_wed204");
	            String gym_thu201 = rs.getString("gym_thu201");
	            String gym_thu202 = rs.getString("gym_thu202");
	            String gym_thu203 = rs.getString("gym_thu203");
	            String gym_thu204 = rs.getString("gym_thu204");
	            String gym_fri201 = rs.getString("gym_fri201");
	            String gym_fri202 = rs.getString("gym_fri202");
	            String gym_fri203 = rs.getString("gym_fri203");
	            String gym_fri204 = rs.getString("gym_fri204");
	            String gym_sat201 = rs.getString("gym_sat201");
	            String gym_sat202 = rs.getString("gym_sat202");
	            String gym_sat203 = rs.getString("gym_sat203");
	            String gym_sat204 = rs.getString("gym_sat204");
	            String gym_sun201 = rs.getString("gym_sun201");
	            String gym_sun202 = rs.getString("gym_sun202");
	            String gym_sun203 = rs.getString("gym_sun203");
	            String gym_sun204 = rs.getString("gym_sun204");
	            
	            dto2 = new schedule2Dto( gym_schedule2_idx, gym_schedule2_content, gym_mon201,gym_mon202,gym_mon203,gym_mon204,gym_tue201,gym_tue202,gym_tue203,gym_tue204,gym_wed201,gym_wed202,gym_wed203,gym_wed204,gym_thu201,gym_thu202,gym_thu203,gym_thu204,gym_fri201,gym_fri202,gym_fri203,gym_fri204,gym_sat201,gym_sat202,gym_sat203,gym_sat204,gym_sun201,gym_sun202,gym_sun203,gym_sun204);
        	}
        	int result = pstmt.executeUpdate();
        }
        catch( Exception e ) {
        	System.out.println("스케줄2 오류");
        	e.printStackTrace();
        }
		
		return dto2;
	}	
	
	
	
	//	스케쥴 수정
	public static void schedule2_update(HttpServletRequest request) 
	{
        Connection conn = null; 
	    PreparedStatement pstmt = null; 
     
        String gym_schedule2_content = request.getParameter("gym_schedule2_content");
        String gym_mon201 = request.getParameter("gym_mon201");
        String gym_mon202 = request.getParameter("gym_mon202");
        String gym_mon203 = request.getParameter("gym_mon203");
        String gym_mon204 = request.getParameter("gym_mon204");
        String gym_tue201 = request.getParameter("gym_tue201");
        String gym_tue202 = request.getParameter("gym_tue202");
        String gym_tue203 = request.getParameter("gym_tue203");
        String gym_tue204 = request.getParameter("gym_tue204");
        String gym_wed201 = request.getParameter("gym_wed201");
        String gym_wed202 = request.getParameter("gym_wed202");
        String gym_wed203 = request.getParameter("gym_wed203");
        String gym_wed204 = request.getParameter("gym_wed204");
        String gym_thu201 = request.getParameter("gym_thu201");
        String gym_thu202 = request.getParameter("gym_thu202");
        String gym_thu203 = request.getParameter("gym_thu203");
        String gym_thu204 = request.getParameter("gym_thu204");
        String gym_fri201 = request.getParameter("gym_fri201");
        String gym_fri202 = request.getParameter("gym_fri202");
        String gym_fri203 = request.getParameter("gym_fri203");
        String gym_fri204 = request.getParameter("gym_fri204");
        String gym_sat201 = request.getParameter("gym_sat201");
        String gym_sat202 = request.getParameter("gym_sat202");
        String gym_sat203 = request.getParameter("gym_sat203");
        String gym_sat204 = request.getParameter("gym_sat204");
        String gym_sun201 = request.getParameter("gym_sun201");
        String gym_sun202 = request.getParameter("gym_sun202");
        String gym_sun203 = request.getParameter("gym_sun203");
        String gym_sun204 = request.getParameter("gym_sun204");

        try 
        {
			conn = DBConnection.getConnection();
			String query = "update gym_schedule2 set gym_mon201 = ?, gym_mon202 = ?, gym_mon203 = ?, gym_mon204 = ?, gym_tue201 = ?, gym_tue202 = ?, gym_tue203 = ?, gym_tue204 = ?, gym_wed201 = ?, gym_wed202 = ?, gym_wed203 = ?, gym_wed204 = ?, gym_thu201 = ?, gym_thu202 = ?, gym_thu203 = ?, gym_thu204 = ?, gym_fri201 = ?, gym_fri202 = ?, gym_fri203 = ?, gym_fri204 = ?, gym_sat201 = ?, gym_sat202 = ?, gym_sat203 = ?, gym_sat204 = ?, gym_sun201 = ?, gym_sun202 = ?, gym_sun203 = ?, gym_sun204 = ? where gym_schedule2_content=?";
			pstmt = conn.prepareStatement( query );
			
			pstmt.setString(1, gym_mon201);
			pstmt.setString(2, gym_mon202);
			pstmt.setString(3, gym_mon203);
			pstmt.setString(4, gym_mon204);
			pstmt.setString(5, gym_tue201);
			pstmt.setString(6, gym_tue202);
			pstmt.setString(7, gym_tue203);
			pstmt.setString(8, gym_tue204);
			pstmt.setString(9, gym_wed201);
			pstmt.setString(10, gym_wed202);
			pstmt.setString(11, gym_wed203);
			pstmt.setString(12, gym_wed204);
			pstmt.setString(13, gym_thu201);
			pstmt.setString(14, gym_thu202);
			pstmt.setString(15, gym_thu203);
			pstmt.setString(16, gym_thu204);
			pstmt.setString(17, gym_fri201);
			pstmt.setString(18, gym_fri202);
			pstmt.setString(19, gym_fri203);
			pstmt.setString(20, gym_fri204);
			pstmt.setString(21, gym_sat201);
			pstmt.setString(22, gym_sat202);
			pstmt.setString(23, gym_sat203);
			pstmt.setString(24, gym_sat204);
			pstmt.setString(25, gym_sun201);
			pstmt.setString(26, gym_sun202);
			pstmt.setString(27, gym_sun203);
			pstmt.setString(28, gym_sun204);
			pstmt.setInt(29, Integer.parseInt(gym_schedule2_content));
			int result = pstmt.executeUpdate();
			System.out.println(result);
		} 
        catch (Exception e) 
        {
			e.printStackTrace();
		}
	}
	
	
	
	
	
	
	
}
