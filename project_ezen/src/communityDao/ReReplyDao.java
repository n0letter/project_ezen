package communityDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import communityDto.ReviewDto;
import communityDto.ReReplyDto;
import project_ezen.DBConnection;

public class ReReplyDao {
	//댓글 쓰기 액션
	public static void reReply(HttpServletRequest request) {
		String reReply_review_idx = request.getParameter("reReply_review_idx");//게시물 idx
		String reReply_content = request.getParameter("reviewReply");
		String reReply_name = request.getParameter("reReply_name");
		String reReply_id = request.getParameter("reReply_id");
		String reReply_reviewMem_idx = request.getParameter("reReply_reviewMem_idx");//댓글 작성자 idx
		String reReply_reviewMem_idx2 = request.getParameter("reReply_reviewMem_idx2");//본 게시물 작성자 idx
		System.out.println("reReply_review_idx:"+reReply_review_idx);
		System.out.println("reReply_id:"+reReply_id);
		System.out.println("reReply_reviewMem_idx2:"+reReply_reviewMem_idx2);
		
		Connection conn = null;    
        PreparedStatement pstmt = null;    //매개변수 입력 편하게 함.
        
        try {
			conn = DBConnection.getConnection();
			
			String query = "INSERT INTO gym_reReply(reReply_idx, reReply_id, reReply_name, reReply_content, reReply_date, reReply_review_idx, reReply_reviewMem_idx, reReply_reviewMem_idx2) "
					+ "VALUES (gym_reReply_seq.nextval, ?, ?, ?, sysdate, ?, ?, ?)";
			pstmt = conn.prepareStatement( query );
			pstmt.setString(1, reReply_id);
			pstmt.setString(2, reReply_name);
			pstmt.setString(3, reReply_content);
			pstmt.setInt(4, Integer.parseInt( reReply_review_idx ) );
			pstmt.setInt(5, Integer.parseInt( reReply_reviewMem_idx ) );
			pstmt.setInt(6, Integer.parseInt( reReply_reviewMem_idx2 ) );
			int result = pstmt.executeUpdate(); // insert, update, delete
			
			System.out.println("INSERT result : "+ result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	//댓글 삭제 액션
	public static void reply_delete(String reReply_idx) {
		Connection conn = null;    
        PreparedStatement pstmt = null;    //매개변수 입력 편하게 함. 
        
        try {
			conn = DBConnection.getConnection();
			String query = "DELETE FROM gym_reReply where reReply_idx=?";
			pstmt = conn.prepareStatement( query );
			pstmt.setInt(1, Integer.parseInt( reReply_idx ) );
			
			int result = pstmt.executeUpdate(); //insert, update, delete
			System.out.println("reply delete result:" + result);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//이용자페이지 - 이용후기 댓글 수정 페이지 보기
	public static ReReplyDto reReplyView(String reReply_idx) {
		ReReplyDto dto = null;
		
		Connection conn = null;    
        PreparedStatement pstmt = null;    //매개변수 입력 편하게 함. 
        ResultSet rs = null;    
        
        try {
        	conn = DBConnection.getConnection();
        	String query = "select * from gym_reReply where reReply_idx=?";
        	pstmt = conn.prepareStatement( query  );
        	pstmt.setInt(1, Integer.parseInt( reReply_idx )); //첫번째 인자(물음표)
        	rs = pstmt.executeQuery(); //select
        	
        	while( rs.next() ) {
        		int reReply_idx_int = rs.getInt("reReply_idx");
	            String reReply_id = rs.getString("reReply_id");
	            String reReply_name = rs.getString("reReply_name");
	            String reReply_content = rs.getString("reReply_content");
	            Date reReply_date = rs.getTimestamp("reReply_date");
	            int reReply_review_idx = rs.getInt("reReply_review_idx");
	            int reReply_reviewMem_idx = rs.getInt("reReply_reviewMem_idx");
	            int reReply_reviewMem_idx2 = rs.getInt("reReply_reviewMem_idx2");
	            
	            dto = new ReReplyDto(reReply_idx_int, reReply_id, reReply_name
	            		, reReply_content, reReply_date, reReply_review_idx, reReply_reviewMem_idx, reReply_reviewMem_idx2);
        		
        	}
        }
        catch( Exception e ) {
        	System.out.println("이용후기 댓글 수정 페이지 에러");
			e.printStackTrace();
        }
		
		return dto;
	}	
	//댓글 수정 액션
	public static void reReplyModify(String reReply_idx, String reReply_review_idx, String reReply_content) {
		Connection conn = null;    
        PreparedStatement pstmt = null;    //매개변수 입력 편하게 함. 
        
        try {
			conn = DBConnection.getConnection();
			String query = "UPDATE gym_reReply SET reReply_content=? WHERE reReply_idx=?";  
			pstmt = conn.prepareStatement( query );
			pstmt.setString(1, reReply_content);
			pstmt.setInt(2, Integer.parseInt( reReply_idx ) );
			
			int result = pstmt.executeUpdate(); //insert, update, delete
			System.out.println("reply modify result:" + result);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//후기 삭제 시 댓글도 삭제 액션
	public static void reReply_delete(String reReply_review_idx) {
		Connection conn = null;    
        PreparedStatement pstmt = null;    //매개변수 입력 편하게 함. 
        
        try {
			conn = DBConnection.getConnection();
			String query = "DELETE FROM gym_reReply where reReply_review_idx=?";
			pstmt = conn.prepareStatement( query );
			pstmt.setInt(1, Integer.parseInt( reReply_review_idx ) );
			
			int result = pstmt.executeUpdate(); //insert, update, delete
			System.out.println("reply delete result:" + result);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}	
	//회원 탈퇴 시 삭제되는 이용후기에 달린 댓글도 삭제 액션 
	public static void myReReply_delete(String reReply_reviewMem_idx2) {
		Connection conn = null;    
        PreparedStatement pstmt = null;    
        
        try {
			conn = DBConnection.getConnection();
			String query = "DELETE FROM gym_reReply where reReply_reviewMem_idx2=?";
			pstmt = conn.prepareStatement( query );
			pstmt.setInt(1, Integer.parseInt( reReply_reviewMem_idx2 ) );
			
			int result = pstmt.executeUpdate(); //insert, update, delete
			System.out.println("reply delete result:" + result);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}		
	
}
