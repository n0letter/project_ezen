package gymManageDao;

import java.sql.Connection;



import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import gymManageDto.TrainnerDto;
import project_ezen.DBConnection;

public class TrainnerDao {

	public static ArrayList<TrainnerDto> list() {
		ArrayList<TrainnerDto> list = new ArrayList<TrainnerDto>();
		Connection conn = null; // 데이터 접근을 위한 객체
		Statement stmt = null; // 쿼리문 실행을 위한 객체
		ResultSet rs = null; // 데이터를 가져와 결과값을 얻기 위한 객체
		
        try {
        	conn = DBConnection.getConnection(); //DB커넥션 객체
	        stmt = conn.createStatement(); //쿼리문 객체
	        String query = "select * from gym_trainner order by trainner_idx desc";
			rs = stmt.executeQuery(query); //쿼리문 실행
			
			while( rs.next() ) {
	            int trainner_idx = rs.getInt("trainner_idx");
	            String trainner_int = rs.getString("trainner_int");
	            String trainner_content = rs.getString("trainner_content");
	            String trainner_img = rs.getString("trainner_img");
	            
	            TrainnerDto dto = new TrainnerDto(trainner_idx,trainner_int, trainner_content, trainner_img);
	            
	            list.add(dto);
	        }
			
		} catch (Exception e) {
	
		}
		return list;
	}
	
//	컨텐츠 페이지
	public static TrainnerDto trainner_modifyView(String trainner_idx) {
		TrainnerDto dto = null;
		Connection conn = null;    
        PreparedStatement pstmt = null;    //매개변수 입력 편하게 함. 
        ResultSet rs = null;    
        
        try {
        	conn = DBConnection.getConnection();
        	String query = "select * from gym_trainner where trainner_idx=?";
        	pstmt = conn.prepareStatement( query  );
        	pstmt.setInt(1, Integer.parseInt( trainner_idx )); //첫번째 인자(물음표)
        	rs = pstmt.executeQuery(); //select
        	
        	while( rs.next() ) {
        		int trainner_idx_int = rs.getInt("trainner_idx");
	            String trainner_int = rs.getString("trainner_int");
	            String trainner_content = rs.getString("trainner_content");
	            String trainner_img = rs.getString("trainner_img");
	            
	            dto = new TrainnerDto(trainner_idx_int, trainner_int, trainner_content, trainner_img);
        		
        	}
        }
        catch( Exception e ) {
        	
        }
		
		return dto;
	}	
	
	
	
	
//	글쓰기
	public static void trainner_write(String trainner_int, String trainner_content, String trainner_img ) {
		Connection conn = null;    
        PreparedStatement pstmt = null;    //매개변수 입력 편하게 함.
        
        try {
			conn = DBConnection.getConnection();
			
			String query = "INSERT INTO gym_trainner(trainner_idx, trainner_int, trainner_content, trainner_img) VALUES (board_seq.nextval, ?, ?, ?)";
			pstmt = conn.prepareStatement( query );
			pstmt.setString(1, trainner_int);
			pstmt.setString(2, trainner_content);
			pstmt.setString(3, trainner_img);
			
			int result = pstmt.executeUpdate(); //insert, update, delete
			System.out.println("insert result:" + result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public static void trainner_delete(String trainner_idx) {
	Connection conn = null;    
    PreparedStatement pstmt = null;    //매개변수 입력 편하게 함. 
    
    try {
		conn = DBConnection.getConnection();
		String query = "DELETE FROM gym_trainner where trainner_idx=?";
		pstmt = conn.prepareStatement( query );
		pstmt.setInt(1, Integer.parseInt( trainner_idx ) );
		
		int result = pstmt.executeUpdate(); //insert, update, delete
		System.out.println("reply delete result:" + result);
		
	} catch (Exception e) {
		e.printStackTrace();
	}
}

//	글쓰기 수정
	public static void trainner_modify( String trainner_idx, String trainner_int, 
			                   String trainner_content, String trainner_img ) {
		
		Connection conn = null;    
        PreparedStatement pstmt = null;    //매개변수 입력 편하게 함. 
        
        try {
        	
			conn = DBConnection.getConnection();
			String query = "UPDATE gym_trainner SET trainner_int=?, trainner_content=? ,trainner_img=? WHERE trainner_idx=?";
													
					       
			pstmt = conn.prepareStatement( query );
			pstmt.setString(1, trainner_int); //1부터 시작
			pstmt.setString(2, trainner_content);
			pstmt.setString(3, trainner_img);
			pstmt.setInt(4, Integer.parseInt( trainner_idx ) );
			
			int result = pstmt.executeUpdate(); //insert, update, delete
			System.out.println("update result:" + result); //0 결과없음 
			                                               //1이상 수정된 열갯수
			
		} catch (Exception e) {
			e.printStackTrace();
		}
        
	}
}