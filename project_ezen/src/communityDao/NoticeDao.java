package communityDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

import communityDto.NoticeDto;
import project_ezen.DBConnection;

public class NoticeDao {
	public static ArrayList<NoticeDto> notice_list(int page) {
		ArrayList<NoticeDto> notice_list = new ArrayList<NoticeDto>();
		
		Connection conn = null; // 데이터 접근을 위한 객체
		Statement stmt = null; // 쿼리문 실행을 위한 객체
		PreparedStatement pstmt = null; //매개변수 입력을 고려한 State클래스
		ResultSet rs = null; // 데이터를 가져와 결과값을 얻기 위한 객체
		
		try {
			conn = DBConnection.getConnection(); //DB커넥션 객체
			
	        String query = "SELECT * FROM (SELECT ROWNUM AS RNUM, gym_notice.* "
	        		+ "FROM gym_notice ORDER BY notice_idx desc) WHERE RNUM >= ? and RNUM <= ?";
	        pstmt = conn.prepareStatement( query  );
	        int pageSize = 5;// 한페이지에 나오는 게시물 개수
	        int startPage = (page - 1) * pageSize + 1; // 시작 게시물
			int endPage = startPage + pageSize - 1; // 끝 게시물
	        pstmt.setInt(1, startPage);
	        pstmt.setInt(2, endPage);
			System.out.println("query:"+query);
	        rs = pstmt.executeQuery(); //쿼리문 실행
			
			while( rs.next() ) {
	            int notice_idx = rs.getInt("notice_idx");
	            String notice_name = rs.getString("notice_name");
	            String notice_title = rs.getString("notice_title");
	            String notice_content = rs.getString("notice_content");
	            Date notice_date = rs.getTimestamp("notice_date");
	            int notice_hit = rs.getInt("notice_hit");
	            
	            System.out.println("notice_idx"+notice_idx);
	            System.out.println("notice_title"+notice_title);
	            System.out.println("notice_content"+notice_content);
	            
	            NoticeDto dto = new NoticeDto(notice_idx, notice_name, notice_title, notice_content, notice_date, notice_hit);
	            
	            notice_list.add(dto);
	        }
			
		}catch(Exception e) {
			System.out.println("공지사항 에러");
			e.printStackTrace();
		}
		
		return notice_list;
	}
	//공지사항 세부 내용 보기
	public static NoticeDto noticeview(String notice_idx) {
		NoticeDto dto = null;
		
		Connection conn = null;    
        PreparedStatement pstmt = null;    //매개변수 입력 편하게 함. 
        ResultSet rs = null;    
        
        try {
        	conn = DBConnection.getConnection();
        	String query = "select * from gym_notice where notice_idx=?";
        	pstmt = conn.prepareStatement( query  );
        	pstmt.setInt(1, Integer.parseInt( notice_idx )); //첫번째 인자(물음표)
        	rs = pstmt.executeQuery(); //select
        	
        	while( rs.next() ) {
        		int notice_idx_int = rs.getInt("notice_idx");
	            String notice_name = rs.getString("notice_name");
	            String notice_title = rs.getString("notice_title");
	            String notice_content = rs.getString("notice_content");
	            Date notice_date = rs.getTimestamp("notice_date");
	            int notice_hit = rs.getInt("notice_hit");
	            
	            dto = new NoticeDto(notice_idx_int, notice_name, notice_title, notice_content, notice_date, notice_hit);
        		
        	}
        }
        catch( Exception e ) {
        	System.out.println("공지사항 내용 에러");
			e.printStackTrace();
        }
		
		return dto;
	}
	//공지사항 조회수
	public static void noticeHit(String notice_idx) {
		Connection conn = null;    
        PreparedStatement pstmt = null;    //매개변수 입력 편하게 함. 
        
        try {
			conn = DBConnection.getConnection();
			String query = "UPDATE gym_notice SET notice_hit=notice_hit+1 WHERE notice_idx=?";       
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
	public static void modify( String notice_idx, String notice_name, 
        String notice_title, String notice_content ) {

		Connection conn = null;    
		PreparedStatement pstmt = null;    //매개변수 입력 편하게 함. 
		
		try {
		conn = DBConnection.getConnection();
		String query = "UPDATE gym_notice SET notice_name=?, notice_title=?, "
			+ "notice_content=? WHERE notice_idx=?";       
		pstmt = conn.prepareStatement( query );
		pstmt.setString(1, notice_name); //1부터 시작
		pstmt.setString(2, notice_title);
		pstmt.setString(3, notice_content);
		pstmt.setInt(4, Integer.parseInt( notice_idx ) );
		
		int result = pstmt.executeUpdate(); //insert, update, delete
		System.out.println("update result:" + result); //0 결과없음 
		                                        //1이상 수정된 열갯수
		
		} catch (Exception e) {
		e.printStackTrace();
		}
		
	}
	//공지사항 삭제
	public static void noticeDelete(String notice_idx) {
		Connection conn = null;    
        PreparedStatement pstmt = null;    //매개변수 입력 편하게 함. 
        
        try {
			conn = DBConnection.getConnection();
			String query = "DELETE FROM gym_notice where notice_idx=?";
			pstmt = conn.prepareStatement( query );
			pstmt.setInt(1, Integer.parseInt( notice_idx ) );
			
			int result = pstmt.executeUpdate(); //insert, update, delete
			System.out.println("delete result:" + result);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//공지사항 글쓰기
	public static void noticeWrite(String notice_name, String notice_title, String notice_content ) {
		Connection conn = null;    
        PreparedStatement pstmt = null;    //매개변수 입력 편하게 함.
        
        try {
			conn = DBConnection.getConnection();
			
			String query = "INSERT INTO gym_notice(notice_idx, notice_name, notice_title, notice_content, notice_date) VALUES (gym_notice_seq.nextval, ?, ?, ?, sysdate)";
			pstmt = conn.prepareStatement( query );
			pstmt.setString(1, notice_name);
			pstmt.setString(2, notice_title);
			pstmt.setString(3, notice_content);
			
			int result = pstmt.executeUpdate(); //insert, update, delete
			System.out.println("insert result:" + result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	//페이징 처리시 마지막 페이지를 연산하기 위한 함수
	public static int notice_count() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		String query = "select count(*) from gym_notice";
		
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
