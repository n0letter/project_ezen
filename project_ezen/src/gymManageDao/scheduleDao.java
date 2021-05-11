
package gymManageDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;

import gymManageDto.scheduleDto;
import project_ezen.DBConnection;


public class scheduleDao {

//	컨텐츠 페이지
	public static scheduleDto scheduleView(HttpServletRequest request) {
		Connection conn = null; 
	    PreparedStatement pstmt = null; 
		scheduleDto dto = null;
        String schedule_idx = request.getParameter("member_idx");//매개변수 입력 편하게 함. 
        ResultSet rs = null;    
        System.out.println("관리자 번호 : " + schedule_idx);
       
        try {
        	conn = DBConnection.getConnection();
        	String query = "select * from gym_schedule where gym_schedule_idx=?";
        	System.out.println(query);
        	pstmt = conn.prepareStatement( query  );
        	pstmt.setInt(1, Integer.parseInt( schedule_idx )); //첫번째 인자(물음표)
        	rs = pstmt.executeQuery(); //select
        	
        	
        	while( rs.next() ) {	
        		int gym_schedule_idx = rs.getInt("gym_schedule_idx");
	            int gym_schedule_contents = rs.getInt("gym_schedule_content");
	            String gym_mon101 = rs.getString("gym_mon101");
	            String gym_mon102 = rs.getString("gym_mon102");
	            String gym_mon103 = rs.getString("gym_mon103");
	            String gym_mon104 = rs.getString("gym_mon104");
	            String gym_tue101 = rs.getString("gym_tue101");
	            String gym_tue102 = rs.getString("gym_tue102");
	            String gym_tue103 = rs.getString("gym_tue103");
	            String gym_tue104 = rs.getString("gym_tue104");
	            String gym_wed101 = rs.getString("gym_wed101");
	            String gym_wed102 = rs.getString("gym_wed102");
	            String gym_wed103 = rs.getString("gym_wed103");
	            String gym_wed104 = rs.getString("gym_wed104");
	            String gym_thu101 = rs.getString("gym_thu101");
	            String gym_thu102 = rs.getString("gym_thu102");
	            String gym_thu103 = rs.getString("gym_thu103");
	            String gym_thu104 = rs.getString("gym_thu104");
	            String gym_fri101 = rs.getString("gym_fri101");
	            String gym_fri102 = rs.getString("gym_fri102");
	            String gym_fri103 = rs.getString("gym_fri103");
	            String gym_fri104 = rs.getString("gym_fri104");
	            String gym_sat101 = rs.getString("gym_sat101");
	            String gym_sat102 = rs.getString("gym_sat102");
	            String gym_sat103 = rs.getString("gym_sat103");
	            String gym_sat104 = rs.getString("gym_sat104");
	            String gym_sun101 = rs.getString("gym_sun101");
	            String gym_sun102 = rs.getString("gym_sun102");
	            String gym_sun103 = rs.getString("gym_sun103");
	            String gym_sun104 = rs.getString("gym_sun104");
	    
	            System.out.println("schedule_content : " + gym_schedule_contents);
	            
	            dto = new scheduleDto( gym_schedule_idx, gym_schedule_contents,gym_mon101,gym_mon102,gym_mon103,gym_mon104,gym_tue101,gym_tue102,gym_tue103,gym_tue104,gym_wed101,gym_wed102,gym_wed103,gym_wed104,gym_thu101,gym_thu102,gym_thu103,gym_thu104,gym_fri101,gym_fri102,gym_fri103,gym_fri104,gym_sat101,gym_sat102,gym_sat103,gym_sat104,gym_sun101,gym_sun102,gym_sun103,gym_sun104 );
        	}
        
        	int result = pstmt.executeUpdate();
        }
        catch( Exception e ) {
        	
    		e.printStackTrace();
    		
        }
		return dto;
	}

	public static scheduleDto scheduleViewmain(HttpServletRequest request) {
		Connection conn = null; 
	    PreparedStatement pstmt = null; 
		scheduleDto dto = null;
        ResultSet rs = null;    
       
        try {
        	conn = DBConnection.getConnection();
        	String query = "select * from gym_schedule where gym_schedule_content=10";
        	System.out.println(query);
        	pstmt = conn.prepareStatement( query  );
        	rs = pstmt.executeQuery(); //select
        	
        	while( rs.next() ) {	
        		int gym_schedule_idx = rs.getInt("gym_schedule_idx");
	            int gym_schedule_contents = rs.getInt("gym_schedule_content");
	            String gym_mon101 = rs.getString("gym_mon101");
	            String gym_mon102 = rs.getString("gym_mon102");
	            String gym_mon103 = rs.getString("gym_mon103");
	            String gym_mon104 = rs.getString("gym_mon104");
	            String gym_tue101 = rs.getString("gym_tue101");
	            String gym_tue102 = rs.getString("gym_tue102");
	            String gym_tue103 = rs.getString("gym_tue103");
	            String gym_tue104 = rs.getString("gym_tue104");
	            String gym_wed101 = rs.getString("gym_wed101");
	            String gym_wed102 = rs.getString("gym_wed102");
	            String gym_wed103 = rs.getString("gym_wed103");
	            String gym_wed104 = rs.getString("gym_wed104");
	            String gym_thu101 = rs.getString("gym_thu101");
	            String gym_thu102 = rs.getString("gym_thu102");
	            String gym_thu103 = rs.getString("gym_thu103");
	            String gym_thu104 = rs.getString("gym_thu104");
	            String gym_fri101 = rs.getString("gym_fri101");
	            String gym_fri102 = rs.getString("gym_fri102");
	            String gym_fri103 = rs.getString("gym_fri103");
	            String gym_fri104 = rs.getString("gym_fri104");
	            String gym_sat101 = rs.getString("gym_sat101");
	            String gym_sat102 = rs.getString("gym_sat102");
	            String gym_sat103 = rs.getString("gym_sat103");
	            String gym_sat104 = rs.getString("gym_sat104");
	            String gym_sun101 = rs.getString("gym_sun101");
	            String gym_sun102 = rs.getString("gym_sun102");
	            String gym_sun103 = rs.getString("gym_sun103");
	            String gym_sun104 = rs.getString("gym_sun104");
	    
	            System.out.println("schedule_content : " + gym_schedule_contents);
	            
	            dto = new scheduleDto( gym_schedule_idx, gym_schedule_contents,gym_mon101,gym_mon102,gym_mon103,gym_mon104,gym_tue101,gym_tue102,gym_tue103,gym_tue104,gym_wed101,gym_wed102,gym_wed103,gym_wed104,gym_thu101,gym_thu102,gym_thu103,gym_thu104,gym_fri101,gym_fri102,gym_fri103,gym_fri104,gym_sat101,gym_sat102,gym_sat103,gym_sat104,gym_sun101,gym_sun102,gym_sun103,gym_sun104 );
        	}
        
        	int result = pstmt.executeUpdate();
        }
        catch( Exception e ) {
        	
    		e.printStackTrace();
        }
		
		return dto;
	}
	
	
	//	스케쥴 수정
	public static void schedule_update(HttpServletRequest request) 
	{
//        String schedule_idx = request.getParameter("member_idx");//매개변수 입력 편하게 함. 
//        System.out.println("member_idx:" + schedule_idx);
        Connection conn = null; 
	    PreparedStatement pstmt = null; 
     
//        String gym_schedule_idx = request.getParameter("gym_schedule_idx");
        String gym_schedule_content = request.getParameter("gym_schedule_content");
        String gym_mon101 = request.getParameter("gym_mon101");
        String gym_mon102 = request.getParameter("gym_mon102");
        String gym_mon103 = request.getParameter("gym_mon103");
        String gym_mon104 = request.getParameter("gym_mon104");
        String gym_tue101 = request.getParameter("gym_tue101");
        String gym_tue102 = request.getParameter("gym_tue102");
        String gym_tue103 = request.getParameter("gym_tue103");
        String gym_tue104 = request.getParameter("gym_tue104");
        String gym_wed101 = request.getParameter("gym_wed101");
        String gym_wed102 = request.getParameter("gym_wed102");
        String gym_wed103 = request.getParameter("gym_wed103");
        String gym_wed104 = request.getParameter("gym_wed104");
        String gym_thu101 = request.getParameter("gym_thu101");
        String gym_thu102 = request.getParameter("gym_thu102");
        String gym_thu103 = request.getParameter("gym_thu103");
        String gym_thu104 = request.getParameter("gym_thu104");
        String gym_fri101 = request.getParameter("gym_fri101");
        String gym_fri102 = request.getParameter("gym_fri102");
        String gym_fri103 = request.getParameter("gym_fri103");
        String gym_fri104 = request.getParameter("gym_fri104");
        String gym_sat101 = request.getParameter("gym_sat101");
        String gym_sat102 = request.getParameter("gym_sat102");
        String gym_sat103 = request.getParameter("gym_sat103");
        String gym_sat104 = request.getParameter("gym_sat104");
        String gym_sun101 = request.getParameter("gym_sun101");
        String gym_sun102 = request.getParameter("gym_sun102");
        String gym_sun103 = request.getParameter("gym_sun103");
        String gym_sun104 = request.getParameter("gym_sun104");
//        System.out.println(gym_schedule_idx);
        System.out.println(gym_schedule_content);
        System.out.println(gym_mon101);
        try 
        {
			conn = DBConnection.getConnection();
			String query = "update gym_schedule set gym_mon101 = ?, gym_mon102 = ?, gym_mon103 = ?, gym_mon104 = ?, gym_tue101 = ?, gym_tue102 = ?, gym_tue103 = ?, gym_tue104 = ?, gym_wed101 = ?, gym_wed102 = ?, gym_wed103 = ?, gym_wed104 = ?, gym_thu101 = ?, gym_thu102 = ?, gym_thu103 = ?, gym_thu104 = ?, gym_fri101 = ?, gym_fri102 = ?, gym_fri103 = ?, gym_fri104 = ?, gym_sat101 = ?, gym_sat102 = ?, gym_sat103 = ?, gym_sat104 = ?, gym_sun101 = ?, gym_sun102 = ?, gym_sun103 = ?, gym_sun104 = ? where gym_schedule_content=?";
			pstmt = conn.prepareStatement( query );
			
			pstmt.setString(1, gym_mon101);
			pstmt.setString(2, gym_mon102);
			pstmt.setString(3, gym_mon103);
			pstmt.setString(4, gym_mon104);
			pstmt.setString(5, gym_tue101);
			pstmt.setString(6, gym_tue102);
			pstmt.setString(7, gym_tue103);
			pstmt.setString(8, gym_tue104);
			pstmt.setString(9, gym_wed101);
			pstmt.setString(10, gym_wed102);
			pstmt.setString(11, gym_wed103);
			pstmt.setString(12, gym_wed104);
			pstmt.setString(13, gym_thu101);
			pstmt.setString(14, gym_thu102);
			pstmt.setString(15, gym_thu103);
			pstmt.setString(16, gym_thu104);
			pstmt.setString(17, gym_fri101);
			pstmt.setString(18, gym_fri102);
			pstmt.setString(19, gym_fri103);
			pstmt.setString(20, gym_fri104);
			pstmt.setString(21, gym_sat101);
			pstmt.setString(22, gym_sat102);
			pstmt.setString(23, gym_sat103);
			pstmt.setString(24, gym_sat104);
			pstmt.setString(25, gym_sun101);
			pstmt.setString(26, gym_sun102);
			pstmt.setString(27, gym_sun103);
			pstmt.setString(28, gym_sun104);
			pstmt.setInt(29, Integer.parseInt(gym_schedule_content));
			int result = pstmt.executeUpdate();
			System.out.println(result);
		} 
        catch (Exception e) 
        {
			e.printStackTrace();
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
        
}

