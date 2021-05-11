package communityDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import communityDto.NoticeDto;
import communityDto.ReviewDto;
import communityDto.reReplyDto;
import memDto.MemberDto;
import project_ezen.DBConnection;

public class ReviewDao {
	public static ArrayList<ReviewDto> review_list(int page) {
		ArrayList<ReviewDto> review_list = new ArrayList<ReviewDto>();
		
		Connection conn = null; // 데이터 접근을 위한 객체
		Statement stmt = null; // 쿼리문 실행을 위한 객체
		PreparedStatement pstmt = null; //매개변수 입력을 고려한 State클래스
		ResultSet rs = null; // 데이터를 가져와 결과값을 얻기 위한 객체
		
		try {
			conn = DBConnection.getConnection(); //DB커넥션 객체
			
	        String query = "SELECT * FROM (SELECT ROWNUM AS RNUM, gym_review.* "
	        		+ "FROM gym_review ORDER BY review_idx desc) WHERE RNUM >= ? and RNUM <= ?";
	        pstmt = conn.prepareStatement( query  );
	        int pageSize = 5;// 한페이지에 나오는 게시물 개수
	        int startPage = (page - 1) * pageSize + 1; // 시작 게시물
			int endPage = startPage + pageSize - 1; // 끝 게시물
	        pstmt.setInt(1, startPage);
	        pstmt.setInt(2, endPage);
			System.out.println("query:"+query);
	        rs = pstmt.executeQuery(); //쿼리문 실행
			
			while( rs.next() ) {
	            int review_idx = rs.getInt("review_idx");
	            String review_id = rs.getString("review_id");
	            String review_name = rs.getString("review_name");
	            String review_title = rs.getString("review_title");
	            String review_content = rs.getString("review_content");
	            Date review_date = rs.getTimestamp("review_date");
	            int review_hit = rs.getInt("review_hit");
	            int review_reply_count = rs.getInt("review_reply_count");
	            int reviewMember_idx = rs.getInt("reviewMember_idx");
	            
	            System.out.println("review_idx"+review_idx);
	            System.out.println("review_title"+review_title);
	            System.out.println("review_content"+review_content);
	            
	            ReviewDto dto = new ReviewDto(review_idx, review_id, review_name, review_title
	            		, review_content, review_date, review_hit, review_reply_count, reviewMember_idx);
	            
	            review_list.add(dto);
	        }
			
		}catch(Exception e) {
			System.out.println("이용후기 에러");
			e.printStackTrace();
		}
		
		return review_list;
	}
	//페이징 처리시 마지막 페이지를 연산하기 위한 함수
	public static int review_count() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		String query = "select count(*) from gym_review";
		
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
	//관리자 페이지 - 이용후기 세부 내용 보기
	public static ReviewDto reviewView(String review_idx) {
		ReviewDto dto = null;
		
		Connection conn = null;    
        PreparedStatement pstmt = null;    //매개변수 입력 편하게 함. 
        ResultSet rs = null;    
        
        try {
        	conn = DBConnection.getConnection();
        	String query = "select * from gym_review where review_idx=?";
        	pstmt = conn.prepareStatement( query  );
        	pstmt.setInt(1, Integer.parseInt( review_idx )); //첫번째 인자(물음표)
        	rs = pstmt.executeQuery(); //select
        	
        	while( rs.next() ) {
        		int review_idx_int = rs.getInt("review_idx");
	            String review_id = rs.getString("review_id");
	            String review_name = rs.getString("review_name");
	            String review_title = rs.getString("review_title");
	            String review_content = rs.getString("review_content");
	            Date review_date = rs.getTimestamp("review_date");
	            int review_hit = rs.getInt("review_hit");
	            int review_reply_count = rs.getInt("review_reply_count");
	            int reviewMember_idx = rs.getInt("reviewMember_idx");
	            
	            dto = new ReviewDto(review_idx_int, review_id, review_name, review_title
	            		, review_content, review_date, review_hit, review_reply_count, reviewMember_idx);
        		
        	}
        }
        catch( Exception e ) {
        	System.out.println("이용후기 내용 에러");
			e.printStackTrace();
        }
		
		return dto;
	}
	//이용후기 조회수
	public static void reviewHit(String review_idx) {
		Connection conn = null;    
        PreparedStatement pstmt = null;    //매개변수 입력 편하게 함. 
        
        try {
			conn = DBConnection.getConnection();
			String query = "UPDATE gym_review SET review_hit=review_hit+1 WHERE review_idx=?";       
			pstmt = conn.prepareStatement( query );
			pstmt.setInt(1, Integer.parseInt(review_idx) );
			
			int result = pstmt.executeUpdate(); //insert, update, delete
			System.out.println("update hit result:" + result); //0 결과없음 
			                                               //1이상 수정된 열갯수
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	//이용후기 수정
	public static void reviewModify( String review_idx, 
        String review_title, String review_content ) {

		Connection conn = null;    
		PreparedStatement pstmt = null;    //매개변수 입력 편하게 함. 
		
		try {
		conn = DBConnection.getConnection();
		String query = "UPDATE gym_review SET review_title=?, "
			+ "review_content=? WHERE review_idx=?";       
		pstmt = conn.prepareStatement( query );
		pstmt.setString(1, review_title); //1부터 시작
		pstmt.setString(2, review_content);
		pstmt.setInt(3, Integer.parseInt( review_idx ) );
		
		int result = pstmt.executeUpdate(); //insert, update, delete
		System.out.println("update result:" + result); //0 결과없음 
		                                        //1이상 수정된 열갯수
		
		} catch (Exception e) {
		e.printStackTrace();
		}
		
	}
	//이용후기 삭제
	public static void reviewDelete(String review_idx) {
		Connection conn = null;    
        PreparedStatement pstmt = null;    //매개변수 입력 편하게 함. 
        
        try {
			conn = DBConnection.getConnection();
			String query = "DELETE FROM gym_review where review_idx=?";
			pstmt = conn.prepareStatement( query );
			pstmt.setInt(1, Integer.parseInt( review_idx ) );
			
			int result = pstmt.executeUpdate(); //insert, update, delete
			System.out.println("delete result:" + result);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//이용후기 글쓰기
	public static void reviewWrite(HttpServletRequest request) {
		String review_id = request.getParameter("review_id");
		String reviewMember_idx = request.getParameter("review_member_idx");
		String review_name = request.getParameter("review_name");
		String review_title = request.getParameter("review_title");
		String review_content = request.getParameter("review_content");
		System.out.println("reviewMember_idx:"+reviewMember_idx);
		System.out.println("review_name:"+review_name);
		System.out.println("review_id:"+review_id);
		
		Connection conn = null;    
        PreparedStatement pstmt = null;    //매개변수 입력 편하게 함.
        
        try {
			conn = DBConnection.getConnection();
			
			String query = "INSERT INTO gym_review(review_idx, review_id, review_name, review_title, review_content, review_date, reviewMember_idx)"
					+ " VALUES (gym_notice_seq.nextval, ?, ?, ?, ?, sysdate, ?)";
			pstmt = conn.prepareStatement( query );
			pstmt.setString(1, review_id);
			pstmt.setString(2, review_name);
			pstmt.setString(3, review_title);
			pstmt.setString(4, review_content);
			pstmt.setInt(5, Integer.parseInt( reviewMember_idx ));
			
			int result = pstmt.executeUpdate(); //insert, update, delete
			System.out.println("insert result:" + result);
		} catch (Exception e) {
			System.out.println("후기 등록 실패");
			e.printStackTrace();
		}
		
	}	
	//댓글 목록
	public static ArrayList<reReplyDto> reply_list(String review_idx) {
		ArrayList<reReplyDto> reply_list = new ArrayList<reReplyDto>();
		
		Connection conn = null; 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		System.out.println( "reply_list review_idx:"+review_idx);
		
		try {
			conn = DBConnection.getConnection(); 
	        
	        String query = "SELECT * FROM gym_reReply WHERE reReply_review_idx=? "
	        		+ "order by reReply_idx desc";
	        pstmt = conn.prepareStatement( query );
	        pstmt.setInt(1, Integer.parseInt( review_idx ) );
	        
			rs = pstmt.executeQuery(); //쿼리문 실행
			
			while( rs.next() ) {
	            int reReply_idx = rs.getInt("reReply_idx");
	            String reReply_id = rs.getString("reReply_id");
	            String reReply_name = rs.getString("reReply_name");
	            String reReply_content = rs.getString("reReply_content");
	            Date reReply_date = rs.getTimestamp("reReply_date");
	            int reReply_review_idx = rs.getInt("reReply_review_idx");
	            int reReply_reviewMem_idx = rs.getInt("reReply_reviewMem_idx");
	            int reReply_reviewMem_idx2 = rs.getInt("reReply_reviewMem_idx2");
	            
	            System.out.println("reReply_idx"+reReply_idx);
	            System.out.println("reReply_name"+reReply_name);
	            System.out.println("reReply_reviewMem_idx"+reReply_reviewMem_idx);
	            
	            reReplyDto dto = new reReplyDto(reReply_idx, reReply_id, reReply_name, reReply_content
	            		, reReply_date, reReply_review_idx, reReply_reviewMem_idx, reReply_reviewMem_idx2);
	            
	            reply_list.add(dto);
	        }
			
		}catch(Exception e) {
			System.out.println("댓글 목록 오류");
			e.printStackTrace();
		}
		
		return reply_list;
	}	
	//이용후기 댓글 수 증가
	public static void reReplyHitAdd(HttpServletRequest request) {
		String reReply_review_idx = request.getParameter("reReply_review_idx");
		
		Connection conn = null;    
        PreparedStatement pstmt = null;    //매개변수 입력 편하게 함. 
        
        try {
			conn = DBConnection.getConnection();
			String query = "UPDATE gym_review SET review_reply_count=review_reply_count+1 WHERE review_idx=?";       
			pstmt = conn.prepareStatement( query );
			pstmt.setInt(1, Integer.parseInt(reReply_review_idx) );
			
			int result = pstmt.executeUpdate(); //insert, update, delete
			System.out.println("update hit result:" + result); //0 결과없음 
			                                               //1이상 수정된 열갯수
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}	
	//이용후기 댓글 수 감소
	public static void reReplyHitMinus(HttpServletRequest request) {
		String reReply_review_idx = request.getParameter("reReply_review_idx");
		
		Connection conn = null;    
        PreparedStatement pstmt = null;    //매개변수 입력 편하게 함. 
        
        try {
			conn = DBConnection.getConnection();
			String query = "UPDATE gym_review SET review_reply_count=review_reply_count-1 WHERE review_idx=?";       
			pstmt = conn.prepareStatement( query );
			pstmt.setInt(1, Integer.parseInt(reReply_review_idx) );
			
			int result = pstmt.executeUpdate(); //insert, update, delete
			System.out.println("update minus result:" + result); //0 결과없음 
			                                               //1이상 수정된 열갯수
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}		
	//마이 페이지 - 나의 후기 목록 보기
	public static ArrayList<ReviewDto> myReview_list(int page, String reviewMember_idx) {
		ArrayList<ReviewDto> myReview_list = new ArrayList<ReviewDto>();
		
		Connection conn = null; // 데이터 접근을 위한 객체
		Statement stmt = null; // 쿼리문 실행을 위한 객체
		PreparedStatement pstmt = null; //매개변수 입력을 고려한 State클래스
		ResultSet rs = null; // 데이터를 가져와 결과값을 얻기 위한 객체
		
		try {
			conn = DBConnection.getConnection(); //DB커넥션 객체
			
	        String query = "SELECT * FROM (SELECT ROWNUM AS RNUM, gym_review.* "
	        		+ "FROM gym_review where reviewMember_idx = ? ORDER BY review_idx desc) WHERE RNUM >= ? and RNUM <= ?";
	        pstmt = conn.prepareStatement( query  );
	        int pageSize = 5;// 한페이지에 나오는 게시물 개수
	        int startPage = (page - 1) * pageSize + 1; // 시작 게시물
			int endPage = startPage + pageSize - 1; // 끝 게시물
			pstmt.setInt(1, Integer.parseInt(reviewMember_idx));
	        pstmt.setInt(2, startPage);
	        pstmt.setInt(3, endPage);
			System.out.println("query:"+query);
	        rs = pstmt.executeQuery(); //쿼리문 실행
			
			while( rs.next() ) {
	            int review_idx = rs.getInt("review_idx");
	            String review_id = rs.getString("review_id");
	            String review_name = rs.getString("review_name");
	            String review_title = rs.getString("review_title");
	            String review_content = rs.getString("review_content");
	            Date review_date = rs.getTimestamp("review_date");
	            int review_hit = rs.getInt("review_hit");
	            int review_reply_count = rs.getInt("review_reply_count");
	            int reviewMember_idx_int = rs.getInt("reviewMember_idx");
	            
	            System.out.println("review_idx"+review_idx);
	            System.out.println("review_title"+review_title);
	            System.out.println("review_content"+review_content);
	            
	            ReviewDto dto = new ReviewDto(review_idx, review_id, review_name, review_title
	            		, review_content, review_date, review_hit, review_reply_count, reviewMember_idx_int);
	            
	            myReview_list.add(dto);
	        }
			
		}catch(Exception e) {
			System.out.println("이용후기 에러");
			e.printStackTrace();
		}
		
		return myReview_list;
	}
	//페이징 처리시 마지막 페이지를 연산하기 위한 함수
	public static int myReview_count(String reviewMember_idx) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		String query = "select count(*) from gym_review where reviewMember_idx = ?";
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, Integer.parseInt(reviewMember_idx));
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
		
	}
	//회원 탈퇴 시 작성한 모든 이용 후기 삭제
	public static void myReviewDelete(String reviewMember_idx) {
		Connection conn = null;    
        PreparedStatement pstmt = null;    //매개변수 입력 편하게 함. 
        
        try {
			conn = DBConnection.getConnection();
			String query = "DELETE FROM gym_review where reviewMember_idx=?";
			pstmt = conn.prepareStatement( query );
			pstmt.setInt(1, Integer.parseInt( reviewMember_idx ) );
			
			int result = pstmt.executeUpdate(); //insert, update, delete
			System.out.println("delete result:" + result);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//이용자 후기 목록 - 검색
	public static ArrayList<ReviewDto> adReviewSearch(HttpServletRequest request) {
		String keyword = request.getParameter("keyword");
		String ar_title = request.getParameter("ar_title");
		int page = Integer.parseInt(request.getParameter("page"));
		System.out.println("keyword:"+keyword);
		
		ArrayList<ReviewDto> review_list = new ArrayList<ReviewDto>();
		
		Connection conn = null; // 데이터 접근을 위한 객체
		Statement stmt = null; // 쿼리문 실행을 위한 객체
		PreparedStatement pstmt = null; //매개변수 입력을 고려한 State클래스
		ResultSet rs = null; // 데이터를 가져와 결과값을 얻기 위한 객체
		
		try {
			
			conn = DBConnection.getConnection(); //DB커넥션 객체
			if(ar_title.equals("title")) {
//				String query = "SELECT * FROM gym_member where to_date(member_join_date, 'YY/MM/DD') = ?";
				String query = "SELECT * FROM (SELECT ROWNUM AS RNUM, gym_review.* "
		        		+ "FROM gym_review where review_title like ? "
		        		+ "ORDER BY review_idx desc) WHERE RNUM >= ? and RNUM <= ?";
				pstmt = conn.prepareStatement( query  );
				pstmt.setString(1, "%"+keyword+"%");
				int pageSize = 5;// 한페이지에 나오는 게시물 개수
		        int startPage = (page - 1) * pageSize + 1; // 시작 게시물
				int endPage = startPage + pageSize - 1; // 끝 게시물
		        pstmt.setInt(2, startPage);
		        pstmt.setInt(3, endPage);
				System.out.println("query:"+query);
			}else if(ar_title.equals("contents")) {
//				String query = "SELECT * FROM gym_member where member_name like ? order by member_idx desc";
				String query = "SELECT * FROM (SELECT ROWNUM AS RNUM, gym_review.* "
		        		+ "FROM gym_review where review_content like ? "
		        		+ "ORDER BY review_idx desc) WHERE RNUM >= ? and RNUM <= ?";
				pstmt = conn.prepareStatement( query  );
				pstmt.setString(1, "%"+keyword+"%");
				int pageSize = 5;// 한페이지에 나오는 게시물 개수
		        int startPage = (page - 1) * pageSize + 1; // 시작 게시물
				int endPage = startPage + pageSize - 1; // 끝 게시물
		        pstmt.setInt(2, startPage);
		        pstmt.setInt(3, endPage);
				System.out.println("query:"+query);
			}else if(ar_title.equals("tOrC")) {
				String query = "SELECT * FROM (SELECT ROWNUM AS RNUM, gym_review.* "
		        		+ "FROM gym_review where review_title like ? or review_content like ?"
		        		+ "ORDER BY review_idx desc) WHERE RNUM >= ? and RNUM <= ?";
				pstmt = conn.prepareStatement( query  );
				pstmt.setString(1, "%"+keyword+"%");
				pstmt.setString(2, "%"+keyword+"%");
				int pageSize = 5;// 한페이지에 나오는 게시물 개수
		        int startPage = (page - 1) * pageSize + 1; // 시작 게시물
				int endPage = startPage + pageSize - 1; // 끝 게시물
		        pstmt.setInt(3, startPage);
		        pstmt.setInt(4, endPage);
				System.out.println("query:"+query);
			}else if(ar_title.equals("writer")) {
				String query = "SELECT * FROM (SELECT ROWNUM AS RNUM, gym_review.* "
		        		+ "FROM gym_review where review_name like ? "
		        		+ "ORDER BY review_idx desc) WHERE RNUM >= ? and RNUM <= ?";
				pstmt = conn.prepareStatement( query  );
				pstmt.setString(1, "%"+keyword+"%");
				int pageSize = 5;// 한페이지에 나오는 게시물 개수
		        int startPage = (page - 1) * pageSize + 1; // 시작 게시물
				int endPage = startPage + pageSize - 1; // 끝 게시물
		        pstmt.setInt(2, startPage);
		        pstmt.setInt(3, endPage);
				System.out.println("query:"+query);
			}
	        rs = pstmt.executeQuery(); //쿼리문 실행
			while( rs.next() ) {
	            int review_idx = rs.getInt("review_idx");
	            String review_id = rs.getString("review_id");
	            String review_name = rs.getString("review_name");
	            String review_title = rs.getString("review_title");
	            String review_content = rs.getString("review_content");
	            Date review_date = rs.getTimestamp("review_date");
	            int review_hit = rs.getInt("review_hit");
	            int review_reply_count = rs.getInt("review_reply_count");
	            int reviewMember_idx_int = rs.getInt("reviewMember_idx");
	            
	            System.out.println("review_idx"+review_idx);
	            System.out.println("review_title"+review_title);
	            System.out.println("review_content"+review_content);
	            
	            ReviewDto dto = new ReviewDto(review_idx, review_id, review_name, review_title
	            		, review_content, review_date, review_hit, review_reply_count, reviewMember_idx_int);
	            
	            review_list.add(dto);
	        }
			
		}catch(Exception e) {
			System.out.println("목록에러");
			e.printStackTrace();
		}
		
		return review_list;
	}
	//페이징 처리시 마지막 페이지를 연산하기 위한 함수(검색)
	public static int memSearch_count(HttpServletRequest request) {
		String keyword = request.getParameter("keyword");
		String ar_title = request.getParameter("ar_title");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		try {
			conn = DBConnection.getConnection();
			if(ar_title.equals("title")) {
				String query = "select count(*) from gym_review "
						+ "where review_title like ? order by review_idx desc";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, "%"+keyword+"%");
			} else if(ar_title.equals("contents")) {
				String query = "select count(*) from gym_review "
						+ "where review_content like ? order by review_idx desc";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, "%"+keyword+"%");
			} else if(ar_title.equals("tOrC")) {
				String query = "select count(*) from gym_review "
						+ "where review_title like ? or review_content like ? order by review_idx desc";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, "%"+keyword+"%");
				pstmt.setString(2, "%"+keyword+"%");
			} else if(ar_title.equals("writer")) {
				String query = "select count(*) from gym_review "
						+ "where review_name like ? order by review_idx desc";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, "%"+keyword+"%");
			}
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
