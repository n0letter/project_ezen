package communityDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

import communityDto.EventDto;
import communityDto.NoticeDto;
import communityDto.RecruitmentDto;
import project_ezen.DBConnection;

public class RecruitmentDao {
	public static ArrayList<RecruitmentDto> recruitment_list(int page) {
		ArrayList<RecruitmentDto> recruitment_list = new ArrayList<RecruitmentDto>();
		
		Connection conn = null; // 데이터 접근을 위한 객체
		Statement stmt = null; // 쿼리문 실행을 위한 객체
		PreparedStatement pstmt = null; //매개변수 입력을 고려한 State클래스
		ResultSet rs = null; // 데이터를 가져와 결과값을 얻기 위한 객체
		
		try {
			conn = DBConnection.getConnection(); //DB커넥션 객체
			
	        String query = "SELECT * FROM (SELECT ROWNUM AS RNUM, gym_recruitment.* "
	        		+ "FROM gym_recruitment ORDER BY recruitment_idx desc) WHERE RNUM >= ? and RNUM <= ?";
	        pstmt = conn.prepareStatement( query  );
	        int pageSize = 5;// 한페이지에 나오는 게시물 개수
	        int startPage = (page - 1) * pageSize + 1; // 시작 게시물
			int endPage = startPage + pageSize - 1; // 끝 게시물
	        pstmt.setInt(1, startPage);
	        pstmt.setInt(2, endPage);
			System.out.println("query:"+query);
	        rs = pstmt.executeQuery(); //쿼리문 실행
			

			while( rs.next() ) {
	            int recruitment_idx = rs.getInt("recruitment_idx");
	            String recruitment_name = rs.getString("recruitment_name");
	            String recruitment_title = rs.getString("recruitment_title");
	            String recruitment_content = rs.getString("recruitment_content");
	            Date recruitment_date = rs.getTimestamp("recruitment_date");
	            int recruitment_hit = rs.getInt("recruitment_hit");
	            
	            System.out.println("recruitment_idx"+recruitment_idx);
	            System.out.println("recruitment_title"+recruitment_title);
	            System.out.println("recruitment_content"+recruitment_content);
	            
                RecruitmentDto dto = new RecruitmentDto(recruitment_idx, recruitment_name, recruitment_title, recruitment_content, recruitment_date, recruitment_hit);
	            
                recruitment_list.add(dto);
	        }
			
			
		}catch(Exception e) {
			System.out.println("채용안내 에러");
			e.printStackTrace();
		}
		
		return recruitment_list;
	}
	//채용안내 세부 내용 보기
	public static RecruitmentDto recruitmentview(String recruitment_idx) {
		RecruitmentDto dto = null;
		
		Connection conn = null;    
        PreparedStatement pstmt = null;    //매개변수 입력 편하게 함. 
        ResultSet rs = null;    
        
        try {
        	conn = DBConnection.getConnection();
        	String query = "select * from gym_recruitment where recruitment_idx=?";
        	pstmt = conn.prepareStatement( query  );
        	pstmt.setInt(1, Integer.parseInt( recruitment_idx )); //첫번째 인자(물음표)
        	rs = pstmt.executeQuery(); //select
        	
        	while( rs.next() ) {
        		 int recruitment_idx_int = rs.getInt("recruitment_idx");
 	            String recruitment_name = rs.getString("recruitment_name");
 	            String recruitment_title = rs.getString("recruitment_title");
 	            String recruitment_content = rs.getString("recruitment_content");
 	            Date recruitment_date = rs.getTimestamp("recruitment_date");
 	            int recruitment_hit = rs.getInt("recruitment_hit");
	            
 	           dto = new RecruitmentDto(recruitment_idx_int, recruitment_name, recruitment_title, recruitment_content, recruitment_date, recruitment_hit);
        		
        	}
        }
        catch( Exception e ) {
        	System.out.println("채용안내 내용 에러");
			e.printStackTrace();
        }
		
		return dto;
	}
	//채용안내 조회수
	public static void recruitmentHit(String recruitment_idx) {
		Connection conn = null;    
        PreparedStatement pstmt = null;    //매개변수 입력 편하게 함. 
        
        try {
			conn = DBConnection.getConnection();
			String query = "UPDATE gym_recruitment SET recruitment_hit=recruitment_hit+1 WHERE recruitment_idx=?";       
			pstmt = conn.prepareStatement( query );
			pstmt.setInt(1, Integer.parseInt(recruitment_idx) );
			
			int result = pstmt.executeUpdate(); //insert, update, delete
			System.out.println("update hit result:" + result); //0 결과없음 
			                                               //1이상 수정된 열갯수
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	//공지사항 수정
	public static void modify( String recruitment_idx, String recruitment_name, 
        String recruitment_title, String recruitment_content ) {

		Connection conn = null;    
		PreparedStatement pstmt = null;    //매개변수 입력 편하게 함. 
		
		try {
		conn = DBConnection.getConnection();
		String query = "UPDATE gym_recruitment SET recruitment_name=?, recruitment_title=?, "
			+ "recruitment_content=? WHERE recruitment_idx=?";       
		pstmt = conn.prepareStatement( query );
		pstmt.setString(1, recruitment_name); //1부터 시작
		pstmt.setString(2, recruitment_title);
		pstmt.setString(3, recruitment_content);
		pstmt.setInt(4, Integer.parseInt( recruitment_idx ) );
		
		int result = pstmt.executeUpdate(); //insert, update, delete
		System.out.println("update result:" + result); //0 결과없음 
		                                        //1이상 수정된 열갯수
		
		} catch (Exception e) {
		e.printStackTrace();
		}
		
	}
	//공지사항 삭제
	public static void recruitmentDelete(String recruitment_idx) {
		Connection conn = null;    
        PreparedStatement pstmt = null;    //매개변수 입력 편하게 함. 
        
        try {
			conn = DBConnection.getConnection();
			String query = "DELETE FROM gym_recruitment where recruitment_idx=?";
			pstmt = conn.prepareStatement( query );
			pstmt.setInt(1, Integer.parseInt( recruitment_idx ) );
			
			int result = pstmt.executeUpdate(); //insert, update, delete
			System.out.println("delete result:" + result);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//채용안내 글쓰기
	public static void recruitmentWrite(String recruitment_name, String recruitment_title, String recruitment_content ) {
		Connection conn = null;    
        PreparedStatement pstmt = null;    //매개변수 입력 편하게 함.
        
        try {
			conn = DBConnection.getConnection();
			
			String query = "INSERT INTO gym_recruitment(recruitment_idx, recruitment_name, recruitment_title, recruitment_content, recruitment_date) VALUES (gym_recruitment_seq.nextval, ?, ?, ?, sysdate)";
			pstmt = conn.prepareStatement( query );
			pstmt.setString(1, recruitment_name);
			pstmt.setString(2, recruitment_title);
			pstmt.setString(3, recruitment_content);
			
			int result = pstmt.executeUpdate(); //insert, update, delete
			System.out.println("insert result:" + result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	//페이징 처리시 마지막 페이지를 연산하기 위한 함수
	public static int recruitment_count() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		String query = "select count(*) from gym_recruitment";
		
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
