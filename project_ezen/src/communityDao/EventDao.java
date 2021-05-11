package communityDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

import communityDto.EventDto;
import project_ezen.DBConnection;

public class EventDao {
	public static ArrayList<EventDto> event_list(int page) {
		ArrayList<EventDto> event_list = new ArrayList<EventDto>();
		
		Connection conn = null; // 데이터 접근을 위한 객체
		Statement stmt = null; // 쿼리문 실행을 위한 객체
		PreparedStatement pstmt = null; //매개변수 입력을 고려한 State클래스
		ResultSet rs = null; // 데이터를 가져와 결과값을 얻기 위한 객체
		
		try {
			conn = DBConnection.getConnection(); //DB커넥션 객체
			
	        String query = "SELECT * FROM (SELECT ROWNUM AS RNUM, gym_event.* "
	        		+ "FROM gym_event ORDER BY event_idx desc) WHERE RNUM >= ? and RNUM <= ?";
	        pstmt = conn.prepareStatement( query  );
	        int pageSize = 5;// 한페이지에 나오는 게시물 개수
	        int startPage = (page - 1) * pageSize + 1; // 시작 게시물
			int endPage = startPage + pageSize - 1; // 끝 게시물
	        pstmt.setInt(1, startPage);
	        pstmt.setInt(2, endPage);
			System.out.println("query:"+query);
	        rs = pstmt.executeQuery(); //쿼리문 실행
			
			while( rs.next() ) {
	            int event_idx = rs.getInt("event_idx");
	            String event_name = rs.getString("event_name");
	            String event_title = rs.getString("event_title");
	            String event_content = rs.getString("event_content");
	            Date event_date = rs.getTimestamp("event_date");
	            int event_hit = rs.getInt("event_hit");
	            
	            System.out.println("event_idx"+event_idx);
	            System.out.println("event_title"+event_title);
	            System.out.println("event_content"+event_content);
	            
	            EventDto dto = new EventDto(event_idx, event_name, event_title, event_content, event_date, event_hit);
	            
	            event_list.add(dto);
	        }
			
		}catch(Exception e) {
			System.out.println("이벤트 에러");
			e.printStackTrace();
		}
		
		return event_list;
	}
	//공지사항 세부 내용 보기
	public static EventDto eventview(String event_idx) {
		EventDto dto = null;
		
		Connection conn = null;    
        PreparedStatement pstmt = null;    //매개변수 입력 편하게 함. 
        ResultSet rs = null;    
        
        try {
        	conn = DBConnection.getConnection();
        	String query = "select * from gym_event where event_idx=?";
        	pstmt = conn.prepareStatement( query  );
        	pstmt.setInt(1, Integer.parseInt( event_idx )); //첫번째 인자(물음표)
        	rs = pstmt.executeQuery(); //select
        	
        	while( rs.next() ) {
        		int event_idx_int = rs.getInt("event_idx");
	            String event_name = rs.getString("event_name");
	            String event_title = rs.getString("event_title");
	            String event_content = rs.getString("event_content");
	            Date event_date = rs.getTimestamp("event_date");
	            int event_hit = rs.getInt("event_hit");
	            
	            dto = new EventDto(event_idx_int, event_name, event_title, event_content, event_date, event_hit);
        		
        	}
        }
        catch( Exception e ) {
        	System.out.println("이벤트 내용 에러");
			e.printStackTrace();
        }
		
		return dto;
	}
	//공지사항 조회수
	public static void eventHit(String notice_idx) {
		Connection conn = null;    
        PreparedStatement pstmt = null;    //매개변수 입력 편하게 함. 
        
        try {
			conn = DBConnection.getConnection();
			String query = "UPDATE gym_event SET event_hit=event_hit+1 WHERE event_idx=?";       
			pstmt = conn.prepareStatement( query );
			pstmt.setInt(1, Integer.parseInt(notice_idx) );
			
			int result = pstmt.executeUpdate(); //insert, update, delete
			System.out.println("update hit result:" + result); //0 결과없음 
			                                               //1이상 수정된 열갯수
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	//공지사항 수정
	public static void modify( String event_idx, String event_name, 
        String event_title, String event_content ) {

		Connection conn = null;    
		PreparedStatement pstmt = null;    //매개변수 입력 편하게 함. 
		
		try {
		conn = DBConnection.getConnection();
		String query = "UPDATE gym_event SET event_name=?, event_title=?, "
			+ "event_content=? WHERE event_idx=?";       
		pstmt = conn.prepareStatement( query );
		pstmt.setString(1, event_name); //1부터 시작
		pstmt.setString(2, event_title);
		pstmt.setString(3, event_content);
		pstmt.setInt(4, Integer.parseInt( event_idx ) );
		
		int result = pstmt.executeUpdate(); //insert, update, delete
		System.out.println("update result:" + result); //0 결과없음 
		                                        //1이상 수정된 열갯수
		
		} catch (Exception e) {
		e.printStackTrace();
		}
		
	}
	//공지사항 삭제
	public static void eventDelete(String event_idx) {
		Connection conn = null;    
        PreparedStatement pstmt = null;    //매개변수 입력 편하게 함. 
        
        try {
			conn = DBConnection.getConnection();
			String query = "DELETE FROM gym_event where event_idx=?";
			pstmt = conn.prepareStatement( query );
			pstmt.setInt(1, Integer.parseInt( event_idx ) );
			
			int result = pstmt.executeUpdate(); //insert, update, delete
			System.out.println("delete result:" + result);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//공지사항 글쓰기
	public static void eventWrite(String event_name, String event_title, String event_content ) {
		Connection conn = null;    
        PreparedStatement pstmt = null;    //매개변수 입력 편하게 함.
        
        try {
			conn = DBConnection.getConnection();
			
			String query = "INSERT INTO gym_event(event_idx, event_name, event_title, event_content, event_date) VALUES (gym_event_seq.nextval, ?, ?, ?, sysdate)";
			pstmt = conn.prepareStatement( query );
			pstmt.setString(1, event_name);
			pstmt.setString(2, event_title);
			pstmt.setString(3, event_content);
			
			int result = pstmt.executeUpdate(); //insert, update, delete
			System.out.println("insert result:" + result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	//페이징 처리시 마지막 페이지를 연산하기 위한 함수
	public static int event_count() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		String query = "select count(*) from gym_event";
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
		
	}
	
	
	
}
