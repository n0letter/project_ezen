package memDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import memDto.OutMemberDto;
import project_ezen.DBConnection;

public class OutMemberDao {

	//마이페이지 - 탈퇴 회원 비번 확인 
	public static int joinout_pw(HttpServletRequest request)
	{
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int result = 0;
		
		String member_idx = request.getParameter("member_idx");
		String member_pw = request.getParameter("joinout_password");
		System.out.println("index : "+member_idx);
		System.out.println("pw : "+member_pw);
		
		try 
		{
			conn = DBConnection.getConnection();
			String query = "select * from gym_member where member_idx=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, member_idx);
			rs = pstmt.executeQuery(); 
			while(rs.next())
			{
				String check_pw = rs.getString("member_pw");
				if(check_pw.equals(member_pw))
				{
					//비밀번호 일치 시 리턴값
					result = 1;
				}
				else
				{
					//비밀번호 틀릴 시 리턴값
					result = 2;
				}
			}
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		
		return result;
	}
	//탈퇴회원 등록 액션
	public static void joinout_insert(HttpServletRequest request) {
		Connection conn = null;    
        PreparedStatement pstmt = null;
        
        String out_member_id = request.getParameter("member_id");
		String out_member_name = request.getParameter("member_name");
		String out_member_pay_sum = request.getParameter("member_pay_sum");
		String out_member_join_date = request.getParameter("member_join_date");
		String out_member_reason = request.getParameter("joinout_checkbox1") + " " + request.getParameter("joinout_checkbox2") 
						+ " " + request.getParameter("joinout_checkbox3") + " " +request.getParameter("joinout_checkbox4");
		String out_member_opinion = request.getParameter("joinout_opinion");
		
		try {	
			
			conn = DBConnection.getConnection();			
			String query = "INSERT INTO gym_out_member (out_member_idx, out_member_id, out_member_name,  "
					+ "out_member_pay_sum, out_member_join_date, "
					+ "out_member_reason, out_member_opinion, out_member_date, out_member_date12) "
					+ "values(gym_out_member_seq.nextval, ?, ?, ?, ?, ?, ?, sysdate, ADD_MONTHS(sysdate, +12))";
			
			System.out.println(query);
			pstmt= conn.prepareStatement(query);
			pstmt.setString(1, out_member_id);
			pstmt.setString(2, out_member_name);
			pstmt.setString(3, out_member_pay_sum);
			pstmt.setString(4, out_member_join_date.substring(0,10));
			pstmt.setString(5, out_member_reason);
			pstmt.setString(6, out_member_opinion);
			int result = pstmt.executeUpdate();
			System.out.println("update result:" + result); 
			
		}catch (Exception e) {
			System.out.println("등록 에러");
			e.printStackTrace();
		}
	}
	
	
	//탈퇴 회원 - 회원 정보 삭제
	public static void joinout(HttpServletRequest request)
	{
		String member_idx = request.getParameter("member_idx");
		Connection conn = null;    
        PreparedStatement pstmt = null;
        
        try 
        {
			conn = DBConnection.getConnection();
			String query ="delete from gym_member where member_idx=?";
			pstmt = conn.prepareStatement( query );
			pstmt.setInt(1, Integer.parseInt(member_idx));
			
			int result = pstmt.executeUpdate();
			System.out.println("delete result:" + result);
		} 
        catch (Exception e) 
        {
        	System.out.println("탈퇴 에러");
			e.printStackTrace();
		}
	}	
	//관리자 게시판 - 탈퇴 회원 목록
	public static ArrayList<OutMemberDto> out_member_list(int page) {
		ArrayList<OutMemberDto> out_member_list = new ArrayList<OutMemberDto>();
		
		Connection conn = null; // 데이터 접근을 위한 객체
		Statement stmt = null; // 쿼리문 실행을 위한 객체
		PreparedStatement pstmt = null; //매개변수 입력을 고려한 State클래스
		ResultSet rs = null; // 데이터를 가져와 결과값을 얻기 위한 객체
		
		try {
			conn = DBConnection.getConnection(); //DB커넥션 객체
			
			String query = "SELECT * FROM (SELECT ROWNUM AS RNUM, gym_out_member.* "
	        		+ "FROM gym_out_member ORDER BY out_member_idx desc) WHERE RNUM >= ? and RNUM <= ?";
	        pstmt = conn.prepareStatement( query  );
	        int pageSize = 5;// 한페이지에 나오는 게시물 개수
	        int startPage = (page - 1) * pageSize + 1; // 시작 게시물
			int endPage = startPage + pageSize - 1; // 끝 게시물
	        pstmt.setInt(1, startPage);
	        pstmt.setInt(2, endPage);
			System.out.println("query:"+query);
	        rs = pstmt.executeQuery(); //쿼리문 실행
			
			while( rs.next() ) {
				int out_member_idx = rs.getInt("out_member_idx");
        		String out_member_id = rs.getString("out_member_id");
	            String out_member_name = rs.getString("out_member_name");
	            String out_member_pay_sum = rs.getString("out_member_pay_sum");
	            String out_member_join_date = rs.getString("out_member_join_date");
	            String out_member_reason = rs.getString("out_member_reason");
	            String out_member_opinion = rs.getString("out_member_opinion");
	            Date out_member_date = rs.getTimestamp("out_member_date");
	            Date out_member_date12 = rs.getTimestamp("out_member_date12");
	            
	            OutMemberDto dto = new OutMemberDto(out_member_idx, out_member_id, out_member_name,
	            		out_member_pay_sum, out_member_join_date, out_member_reason,
	            		out_member_opinion, out_member_date, out_member_date12);
        		
	            out_member_list.add(dto);
	        }
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return out_member_list;
	}
	//페이징 처리시 마지막 페이지를 연산하기 위한 함수
	public static int outMember_count() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		String query = "select count(*) from gym_out_member";
		
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
	//관리자 페이지 - 탈퇴 회원 정보 상세 페이지 보기
	public static OutMemberDto out_member_view(HttpServletRequest request) {
		OutMemberDto dto = null;
		String out_member_idx = request.getParameter("out_member_idx");
		
		Connection conn = null;    
        PreparedStatement pstmt = null;    
        ResultSet rs = null;    
        
        try {
        	conn = DBConnection.getConnection();
        	String query = "select * from gym_out_member where out_member_idx=?";
        	pstmt = conn.prepareStatement( query  );
        	pstmt.setInt(1, Integer.parseInt( out_member_idx ));
        	rs = pstmt.executeQuery(); //select
        	
        	while( rs.next() ) {
        		int out_member_idx_int = rs.getInt("out_member_idx");
        		String out_member_id = rs.getString("out_member_id");
	            String out_member_name = rs.getString("out_member_name");
	            String out_member_pay_sum = rs.getString("out_member_pay_sum");
	            String out_member_join_date = rs.getString("out_member_join_date");
	            String out_member_reason = rs.getString("out_member_reason");
	            String out_member_opinion = rs.getString("out_member_opinion");
	            Date out_member_date = rs.getTimestamp("out_member_date");
	            Date out_member_date12 = rs.getTimestamp("out_member_date12");
	            
	            dto = new OutMemberDto(out_member_idx_int, out_member_id, out_member_name, 
	            		out_member_pay_sum, out_member_join_date, out_member_reason, 
	            		out_member_opinion, out_member_date, out_member_date12);
        	}
        }
        catch( Exception e ) {
        	e.printStackTrace();
        }
		
		return dto;
	}	
	//관리자 페이지 - 탈퇴 회원 선택 삭제
	public static void out_mem_delete(int out_member_idx)
	{
		Connection conn = null;    
        PreparedStatement pstmt = null;
        
        try 
        {
			conn = DBConnection.getConnection();
			String query ="delete from gym_out_member where out_member_idx=?";
			pstmt = conn.prepareStatement( query );
			pstmt.setInt(1, out_member_idx);
			
			int result = pstmt.executeUpdate();
			
			System.out.println("delete result:" + result);
		} 
        catch (Exception e) 
        {
			e.printStackTrace();
		}
	}
	//관리자 탈퇴 회원 목록 - 검색
	public static ArrayList<OutMemberDto> oMem_search(HttpServletRequest request) {
		String keyword = request.getParameter("keyword");
		String ms_title = request.getParameter("ms_title");
		int page = Integer.parseInt(request.getParameter("page"));
		System.out.println("keyword:"+keyword);
		
		ArrayList<OutMemberDto> out_member_list = new ArrayList<OutMemberDto>();
		
		Connection conn = null; // 데이터 접근을 위한 객체
		Statement stmt = null; // 쿼리문 실행을 위한 객체
		PreparedStatement pstmt = null; //매개변수 입력을 고려한 State클래스
		ResultSet rs = null; // 데이터를 가져와 결과값을 얻기 위한 객체
		
		try {
			
			conn = DBConnection.getConnection(); //DB커넥션 객체
			if(ms_title.equals("outDay")) {
				String query = "SELECT * FROM (SELECT ROWNUM AS RNUM, gym_out_member.* "
		        		+ "FROM gym_out_member where to_date(out_member_date, 'YY/MM/DD') = ? "
		        		+ "ORDER BY out_member_idx desc) WHERE RNUM >= ? and RNUM <= ?";
				pstmt = conn.prepareStatement( query  );
				pstmt.setString(1, (keyword));
				int pageSize = 5;// 한페이지에 나오는 게시물 개수
		        int startPage = (page - 1) * pageSize + 1; // 시작 게시물
				int endPage = startPage + pageSize - 1; // 끝 게시물
		        pstmt.setInt(2, startPage);
		        pstmt.setInt(3, endPage);
				System.out.println("query:"+query);
			}else if(ms_title.equals("joinDay")) {
				String query = "SELECT * FROM (SELECT ROWNUM AS RNUM, gym_out_member.* "
		        		+ "FROM gym_out_member where out_member_join_date like ? "
		        		+ "ORDER BY out_member_idx desc) WHERE RNUM >= ? and RNUM <= ?";
				pstmt = conn.prepareStatement( query  );
				pstmt.setString(1, keyword);
				int pageSize = 5;// 한페이지에 나오는 게시물 개수
		        int startPage = (page - 1) * pageSize + 1; // 시작 게시물
				int endPage = startPage + pageSize - 1; // 끝 게시물
		        pstmt.setInt(2, startPage);
		        pstmt.setInt(3, endPage);
				System.out.println("query:"+query);
			}else if(ms_title.equals("name")) {
				String query = "SELECT * FROM (SELECT ROWNUM AS RNUM, gym_out_member.* "
		        		+ "FROM gym_out_member where out_member_name like ? "
		        		+ "ORDER BY out_member_idx desc) WHERE RNUM >= ? and RNUM <= ?";
				pstmt = conn.prepareStatement( query  );
				pstmt.setString(1, "%"+keyword+"%");
				int pageSize = 5;// 한페이지에 나오는 게시물 개수
		        int startPage = (page - 1) * pageSize + 1; // 시작 게시물
				int endPage = startPage + pageSize - 1; // 끝 게시물
		        pstmt.setInt(2, startPage);
		        pstmt.setInt(3, endPage);
				System.out.println("query:"+query);
			}else if(ms_title.equals("id")) {
				String query = "SELECT * FROM (SELECT ROWNUM AS RNUM, gym_out_member.* "
		        		+ "FROM gym_out_member where out_member_name like ? "
		        		+ "ORDER BY out_member_idx desc) WHERE RNUM >= ? and RNUM <= ?";
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
				int out_member_idx = rs.getInt("out_member_idx");
        		String out_member_id = rs.getString("out_member_id");
	            String out_member_name = rs.getString("out_member_name");
	            String out_member_pay_sum = rs.getString("out_member_pay_sum");
	            String out_member_join_date = rs.getString("out_member_join_date");
	            String out_member_reason = rs.getString("out_member_reason");
	            String out_member_opinion = rs.getString("out_member_opinion");
	            Date out_member_date = rs.getTimestamp("out_member_date");
	            Date out_member_date12 = rs.getTimestamp("out_member_date12");
	            
	            OutMemberDto dto = new OutMemberDto(out_member_idx, out_member_id, out_member_name,
	            		out_member_pay_sum, out_member_join_date, out_member_reason,
	            		out_member_opinion, out_member_date, out_member_date12);
        		
	            out_member_list.add(dto);
	        }
			
		}catch(Exception e) {
			System.out.println("목록에러");
			e.printStackTrace();
		}
		
		return out_member_list;
	}
	//페이징 처리시 마지막 페이지를 연산하기 위한 함수(검색)
	public static int oMemSearch_count(HttpServletRequest request) {
		String keyword = request.getParameter("keyword");
		String ms_title = request.getParameter("ms_title");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		try {
			conn = DBConnection.getConnection();
			if(ms_title.equals("outDay")) {
				String query = "select count(*) from gym_out_member "
						+ "where to_date(out_member_date, 'YY/MM/DD') = ? order by out_member_idx desc";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, (keyword));
			} else if(ms_title.equals("joinDay")) {
				String query = "select count(*) from gym_out_member "
						+ "where out_member_join_date like ? order by out_member_idx desc";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, (keyword));
			} else if(ms_title.equals("name")) {
				String query = "select count(*) from gym_out_member "
						+ "where out_member_name like ? order by out_member_idx desc";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, "%"+keyword+"%");
			} else if(ms_title.equals("id")) {
				String query = "select count(*) from gym_out_member "
						+ "where out_member_id like ? order by out_member_idx desc";
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
