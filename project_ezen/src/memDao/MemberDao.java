package memDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import memDto.MemberDto;
import project_ezen.DBConnection;
import serviceDto.PayDto;

public class MemberDao {

	//회원 가입 액션
	public static void insertMember(HttpServletRequest request) {
		Connection conn = null;    
        PreparedStatement pstmt = null;
        
        String member_id = request.getParameter("member_id");
		String member_pw = request.getParameter("member_pw");
		String member_name = request.getParameter("member_name");
		String member_birth_date = request.getParameter("member_birth_date");
		String member_gender = request.getParameter("member_gender");
		String member_phone = request.getParameter("htel1") + request.getParameter("htel2") + request.getParameter("htel3");
		String member_email = request.getParameter("member_email1") + "@" + request.getParameter("member_email2");
		int member_email_receive = Integer.parseInt(request.getParameter("member_email_receive"));
		String member_agree = request.getParameter("member_agree");
        
		try {	
			
			conn = DBConnection.getConnection();			
			String query = "INSERT INTO gym_member (member_idx, member_id, member_pw, member_name,  "
					+ "member_birth_date, member_gender, member_phone, member_email, member_email_receive, "
					+ "member_agree, member_join_date) "
					+ "values(gym_member_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
			
			System.out.println(query);
			pstmt= conn.prepareStatement(query);
			pstmt.setString(1, member_id);
			pstmt.setString(2, member_pw);
			pstmt.setString(3, member_name);
			pstmt.setString(4, member_birth_date);
			pstmt.setString(5, member_gender);
			pstmt.setString(6, member_phone);
			pstmt.setString(7, member_email);
			pstmt.setInt(8, member_email_receive );
			pstmt.setString(9, member_agree);
			
			int result = pstmt.executeUpdate();
			System.out.println("update result:" + result); 
			
		}catch (Exception e) {
			System.out.println("가입 에러");
			e.printStackTrace();
		}
	}
	//아이디 중복 체크 액션
	public static int idCheck(HttpServletRequest request) throws Exception 
	{
		int result = 0;
		
		System.out.println("start check ID");
		Connection conn = null; //DB연결 클래스
		ResultSet rs = null;  //검색결과을 담는 클래스
		PreparedStatement pstmt = null; //쿼리를 날리는 클래스
		
		String member_id = request.getParameter("member_id");
		System.out.println("member_id : " + member_id);
		
		conn = DBConnection.getConnection();
		String query = "SELECT * FROM gym_member WHERE member_id = ?";
		pstmt = conn.prepareStatement( query );
		pstmt.setString(1, member_id);
		rs = pstmt.executeQuery();
	
		try
		{
			if(rs.next())
			{
				//아이디 중복
				result = 1;
				System.out.println("아이디가 이미 있음.");
			}
			else
			{
				//아이디 중복안됨
				result = 2;
				System.out.println("아이디를 사용할 수 있음.");
			}
		}
		catch(Exception e)
		{
			System.out.println("버그 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	//로그인 액션
	public static int login(HttpServletRequest request) throws Exception {
		Connection conn = null;    
		ResultSet rs = null;
        PreparedStatement pstmt = null;
		
        HttpSession session = request.getSession();
        
        String member_id= request.getParameter("member_id");
        String member_pw = request.getParameter("member_pw");
        System.out.println("member_id : "+ member_id);
        
		conn = DBConnection.getConnection();
		String query = "SELECT * FROM gym_member WHERE member_id = ?";
		System.out.println(query);
		try {
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, member_id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
			String check_id = rs.getString("member_id");
			    System.out.println("check : "+check_id);
				String check_pw = rs.getString("member_pw");
				String member_name = rs.getString("member_name");
				String member_idx = rs.getString("member_idx");
				int member_email_receive = rs.getInt("member_email_receive");
				String member_phone = rs.getString("member_phone");
	            String member_email = rs.getString("member_email");
	            int member_coupon01 = rs.getInt("member_coupon01");
	            int member_coupon02 = rs.getInt("member_coupon02");
				
				if(member_id.equals("admin") && member_pw.equals(check_pw) ) {
					System.out.println("관리자 로그인!");
					session.setAttribute("member_id",member_id);
					session.setAttribute("member_name",member_name);
					session.setAttribute("member_idx",member_idx);
					return 2;
				}
				else if(member_id.equals(check_id) && member_pw.equals(check_pw)) {
			  	System.out.println("로그인 성공!");
					session.setAttribute("member_id",member_id);
					session.setAttribute("member_name",member_name);
					session.setAttribute("member_idx",member_idx);
					session.setAttribute("member_phone",member_phone);
					session.setAttribute("member_email",member_email);
					session.setAttribute("member_coupon01",member_coupon01);
					session.setAttribute("member_coupon02",member_coupon02);
					return 1;
				} else {
					return 0;
				}
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		 
		return -1;
	}	
	//마이페이지(회원 정보)
	public static MemberDto Mypage(HttpServletRequest request) {
		MemberDto dto = null;
		String member_idx = request.getParameter("member_idx");
		System.out.println("member_idx:" + member_idx);
		
		Connection conn = null;    
        PreparedStatement pstmt = null;    
        ResultSet rs = null;    
        
        try {
        	conn = DBConnection.getConnection();
        	String query = "select * from gym_member where member_idx=?";
        	pstmt = conn.prepareStatement( query  );
        	pstmt.setInt(1, Integer.parseInt( member_idx ));
        	rs = pstmt.executeQuery(); //select
        	
        	while( rs.next() ) {
        		int member_idx_int = rs.getInt("member_idx");
        		String member_id = rs.getString("member_id");
        		String member_pw = rs.getString("member_pw");
	            String member_name = rs.getString("member_name");
	            String member_birth_date = rs.getString("member_birth_date");
	            String member_gender = rs.getString("member_gender");
	            String member_phone = rs.getString("member_phone");
	            String member_email = rs.getString("member_email");
	            int member_email_receive = rs.getInt("member_email_receive");
	            int member_coupon01 = rs.getInt("member_coupon01");
	            int member_coupon02 = rs.getInt("member_coupon02");
	            int member_locker = rs.getInt("member_locker");
	            int member_pay_sum = rs.getInt("member_pay_sum");
	            String member_agree = rs.getString("member_agree");
	            Date member_join_date = rs.getTimestamp("member_join_date");
	            
	            dto = new MemberDto(member_idx_int, member_id, member_pw, member_name, member_birth_date,
	            		member_gender, member_phone, member_email, member_email_receive, member_coupon01, member_coupon02,
	            		member_locker, member_pay_sum, member_agree, member_join_date);
        		
	            
        	}
        }
        catch( Exception e ) {
        	e.printStackTrace();
        }
		
		return dto;
	}
	//관리자 메인 페이지(회원 목록)
	public static ArrayList<MemberDto> member_list(int page) {
		System.out.println("멤버dao");
		ArrayList<MemberDto> member_list = new ArrayList<MemberDto>();
		
		Connection conn = null; // 데이터 접근을 위한 객체
		Statement stmt = null; // 쿼리문 실행을 위한 객체
		PreparedStatement pstmt = null; //매개변수 입력을 고려한 State클래스
		ResultSet rs = null; // 데이터를 가져와 결과값을 얻기 위한 객체
		
		try {
			conn = DBConnection.getConnection(); //DB커넥션 객체

	        String query = "SELECT * FROM (SELECT ROWNUM AS RNUM, gym_member.* "
	        		+ "FROM gym_member ORDER BY member_idx desc) WHERE RNUM >= ? and RNUM <= ?";
	        pstmt = conn.prepareStatement( query  );
	        int pageSize = 5;// 한페이지에 나오는 게시물 개수
	        int startPage = (page - 1) * pageSize + 1; // 시작 게시물
			int endPage = startPage + pageSize - 1; // 끝 게시물
	        pstmt.setInt(1, startPage);
	        pstmt.setInt(2, endPage);
			System.out.println("query:"+query);
	        rs = pstmt.executeQuery(); //쿼리문 실행
			while( rs.next() ) {
				int member_idx = rs.getInt("member_idx");
        		String member_id = rs.getString("member_id");
        		String member_pw = rs.getString("member_pw");
	            String member_name = rs.getString("member_name");
	            String member_birth_date = rs.getString("member_birth_date");
	            String member_gender = rs.getString("member_gender");
	            String member_phone = rs.getString("member_phone");
	            String member_email = rs.getString("member_email");
	            int member_email_receive = rs.getInt("member_email_receive");
	            int member_coupon01 = rs.getInt("member_coupon01");
	            int member_coupon02 = rs.getInt("member_coupon02");
	            int member_locker = rs.getInt("member_locker");
	            int member_pay_sum = rs.getInt("member_pay_sum");
	            String member_agree = rs.getString("member_agree");
	            Date member_join_date = rs.getTimestamp("member_join_date");
	            
	            MemberDto dto = new MemberDto(member_idx, member_id, member_pw, member_name, member_birth_date,
	            		member_gender, member_phone, member_email, member_email_receive, member_coupon01, member_coupon02,
	            		member_locker, member_pay_sum, member_agree, member_join_date);
        		
	            member_list.add(dto);
	        }
			
		}catch(Exception e) {
			System.out.println("목록에러");
			e.printStackTrace();
		}
		
		return member_list;
	}
	//페이징 처리시 마지막 페이지를 연산하기 위한 함수
	public static int member_count() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		String query = "select count(*) from gym_member";
		
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
	//아이디 찾기 액션
	public static String idFind(HttpServletRequest request) throws Exception 
	{
		String result = null;
		
		System.out.println("start find ID");
		Connection conn = null; 
		ResultSet rs = null;  
		PreparedStatement pstmt = null; 
		
		HttpSession session = request.getSession();
		
		String member_name = request.getParameter("find_name");
		String member_email = request.getParameter("find_mail01");
		System.out.println(member_name);
		System.out.println(member_email);
		
		conn = DBConnection.getConnection();
		String query = "SELECT * FROM gym_member WHERE member_name=? AND member_email=?";
		pstmt = conn.prepareStatement( query );
		pstmt.setString(1, member_name);
		pstmt.setString(2, member_email);
		
		rs = pstmt.executeQuery();
		
		try
		{
			while(rs.next()) 
			{
				String member_id = rs.getString("member_id");

				session.setAttribute("member_id",member_id);
				result = member_id;
			}

		}
		catch(Exception e)
		{
			System.out.println("찾는 아이디가 없음");
			e.printStackTrace();
		}
		if(result == null) {
			result = "failed";
		}
		System.out.println("ID : "+result);
		return result;
	}
	//비밀번호 찾기 액션
	public static String find_pw(HttpServletRequest request) throws Exception 
	{
		String result = null;
		
		System.out.println("start find PW");
		Connection conn = null; 
		ResultSet rs = null;  
		PreparedStatement pstmt = null; 
		
		HttpSession session = request.getSession();

		String member_id = request.getParameter("find_id");
		String member_email = request.getParameter("find_mail02");
		System.out.println(member_id);
		System.out.println(member_email);
		
		conn = DBConnection.getConnection();
		String query = "SELECT * FROM gym_member WHERE member_id=? AND member_email=?";
		pstmt = conn.prepareStatement( query );
		pstmt.setString(1, member_id);
		pstmt.setString(2, member_email);
		
		rs = pstmt.executeQuery();
		
		try
		{
			while(rs.next()) 
			{
				String member_pw = rs.getString("member_pw");

				session.setAttribute("member_pw",member_pw);
				result = member_pw;
			}

		}
		catch(Exception e)
		{
			System.out.println("찾는 비밀번호가 없음");
			e.printStackTrace();
		}
		if(result == null) {
			result = "failed";	
		}
		System.out.println("PW : "+result);
		return result;
	}
	//관리자 페이지 - 회원 개인 정보 상세 페이지 보기
	public static MemberDto admin_member_view(HttpServletRequest request) {
		MemberDto dto = null;
		String member_idx = request.getParameter("mem_idx");
		
		Connection conn = null;    
        PreparedStatement pstmt = null;    
        ResultSet rs = null;    
        
        try {
        	conn = DBConnection.getConnection();
        	String query = "select * from gym_member where member_idx=?";
        	pstmt = conn.prepareStatement( query  );
        	pstmt.setInt(1, Integer.parseInt( member_idx ));
        	rs = pstmt.executeQuery(); //select
        	
        	while( rs.next() ) {
        		int member_idx_int = rs.getInt("member_idx");
        		String member_id = rs.getString("member_id");
        		String member_pw = rs.getString("member_pw");
	            String member_name = rs.getString("member_name");
	            String member_birth_date = rs.getString("member_birth_date");
	            String member_gender = rs.getString("member_gender");
	            String member_phone = rs.getString("member_phone");
	            String member_email = rs.getString("member_email");
	            int member_email_receive = rs.getInt("member_email_receive");
	            int member_coupon01 = rs.getInt("member_coupon01");
	            int member_coupon02 = rs.getInt("member_coupon02");
	            int member_locker = rs.getInt("member_locker");
	            int member_pay_sum = rs.getInt("member_pay_sum");
	            String member_agree = rs.getString("member_agree");
	            Date member_join_date = rs.getTimestamp("member_join_date");
	            
	            dto = new MemberDto(member_idx_int, member_id, member_pw, member_name, member_birth_date,
	            		member_gender, member_phone, member_email, member_email_receive, member_coupon01, member_coupon02,
	            		member_locker, member_pay_sum, member_agree, member_join_date);
        		
	            
        	}
        }
        catch( Exception e ) {
        	e.printStackTrace();
        }
		
		return dto;
	}
	//회원 삭제 액션
	public static void mem_delete(HttpServletRequest request)
	{
		String member_idx = request.getParameter("mem_delete");
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
			e.printStackTrace();
		}
	}
	//회원 정보 수정 액션
	public static void member_modify(HttpServletRequest request) 
	{
		Connection conn = null;    
        PreparedStatement pstmt = null;
        
        String member_idx = request.getParameter("mem_idx");
        String member_birth_date = request.getParameter("joinBirthday");
        String member_gender = request.getParameter("join_gender");
        String member_phone = request.getParameter("htel3");
        String member_email = request.getParameter("email");
        String member_coupon01 = request.getParameter("mv_coup01");
        String member_coupon02 = request.getParameter("mv_coup02");
        String member_locker = request.getParameter("locker");
        
        System.out.println(member_gender);
        System.out.println(member_phone);
        System.out.println(member_email);
        System.out.println(member_idx);
        System.out.println(member_birth_date);
        System.out.println(member_coupon01);
        System.out.println(member_coupon02);
        System.out.println(member_locker);
        
        try 
        {
			conn = DBConnection.getConnection();
			String query = "update gym_member set member_birth_date = ?, member_gender = ?"
					+ ", member_phone = ?, member_email = ?, member_coupon01 = ?"
					+ ", member_coupon02 = ?, member_locker = ? where member_idx = ?";
			pstmt = conn.prepareStatement( query );
			pstmt.setString(1, member_birth_date);
			pstmt.setString(2, member_gender);
			pstmt.setString(3, member_phone);
			pstmt.setString(4, member_email);
			pstmt.setInt(5, Integer.parseInt(member_coupon01));
			pstmt.setInt(6, Integer.parseInt(member_coupon02));
			pstmt.setInt(7, Integer.parseInt(member_locker));
			pstmt.setInt(8, Integer.parseInt(member_idx));
			
			int result = pstmt.executeUpdate();
			System.out.println(result);
		} 
        catch (Exception e) 
        {
			e.printStackTrace();
		}
	}
	//마이페이지 - 회원정보 수정 액션(비번 확인 포함)
	public static int modify_pw(HttpServletRequest request)
	{
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int result = 0;
		
		String member_idx = request.getParameter("member_idx");
		String member_pw = request.getParameter("modify_pw");
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
	//마이페이지 - 회원정보 수정 액션 - 수정
	public static void my_mem_modify(HttpServletRequest request) 
	{
		Connection conn = null;    
        PreparedStatement pstmt = null;
        
        String member_idx = request.getParameter("member_idx");
        String member_birth_date = request.getParameter("choice_date");
        String member_phone = request.getParameter("tel");
        String member_email = request.getParameter("email");
        String member_email_receive = request.getParameter("member_email_receive");
        
        System.out.println(member_phone);
        System.out.println(member_email);
        System.out.println(member_idx);
        System.out.println(member_birth_date);
        
        try 
        {
			conn = DBConnection.getConnection();
			String query = "update gym_member set member_birth_date = ?, member_phone = ?"
					+ ", member_email = ?, member_email_receive = ? where member_idx = ?";
			pstmt = conn.prepareStatement( query );
			pstmt.setString(1, member_birth_date);
			pstmt.setString(2, member_phone);
			pstmt.setString(3, member_email);
			pstmt.setInt(4, Integer.parseInt(member_email_receive));
			pstmt.setInt(5, Integer.parseInt(member_idx));
			
			int result = pstmt.executeUpdate();
			System.out.println(result);
		} 
        catch (Exception e) 
        {
			e.printStackTrace();
		}
	}
	//마이페이지 - 비밀번호 수정 액션 - 수정
	public static void myPwModify(HttpServletRequest request) 
	{
		Connection conn = null;    
        PreparedStatement pstmt = null;
        
        String member_idx = request.getParameter("member_idx");
        String member_pw = request.getParameter("new_pw01");
        
        System.out.println(member_idx);
        System.out.println(member_pw);
        
        try 
        {
			conn = DBConnection.getConnection();
			String query = "update gym_member set member_pw = ? where member_idx = ?";
			pstmt = conn.prepareStatement( query );
			pstmt.setString(1, member_pw);
			pstmt.setInt(2, Integer.parseInt(member_idx));
			
			int result = pstmt.executeUpdate();
			System.out.println(result);
		} 
        catch (Exception e) 
        {
			e.printStackTrace();
		}
	}

	//관리자 회원 목록 - 검색
	public static ArrayList<MemberDto> mem_search(HttpServletRequest request) {
		String keyword = request.getParameter("keyword");
		String ms_title = request.getParameter("ms_title");
		int page = Integer.parseInt(request.getParameter("page"));
		System.out.println("keyword:"+keyword);
		
		ArrayList<MemberDto> member_list = new ArrayList<MemberDto>();
		
		Connection conn = null; // 데이터 접근을 위한 객체
		Statement stmt = null; // 쿼리문 실행을 위한 객체
		PreparedStatement pstmt = null; //매개변수 입력을 고려한 State클래스
		ResultSet rs = null; // 데이터를 가져와 결과값을 얻기 위한 객체
		
		try {
			
			conn = DBConnection.getConnection(); //DB커넥션 객체
			if(ms_title.equals("joinDay")) {
				String query = "SELECT * FROM (SELECT ROWNUM AS RNUM, gym_member.* "
		        		+ "FROM gym_member where to_date(member_join_date, 'YY/MM/DD') = ? "
		        		+ "ORDER BY member_idx desc) WHERE RNUM >= ? and RNUM <= ?";
				pstmt = conn.prepareStatement( query  );
				pstmt.setString(1, (keyword));
				int pageSize = 5;// 한페이지에 나오는 게시물 개수
		        int startPage = (page - 1) * pageSize + 1; // 시작 게시물
				int endPage = startPage + pageSize - 1; // 끝 게시물
		        pstmt.setInt(2, startPage);
		        pstmt.setInt(3, endPage);
				System.out.println("query:"+query);
			}else if(ms_title.equals("name")) {
				String query = "SELECT * FROM (SELECT ROWNUM AS RNUM, gym_member.* "
		        		+ "FROM gym_member where member_name like ? "
		        		+ "ORDER BY member_idx desc) WHERE RNUM >= ? and RNUM <= ?";
				pstmt = conn.prepareStatement( query  );
				pstmt.setString(1, "%"+keyword+"%");
				int pageSize = 5;// 한페이지에 나오는 게시물 개수
		        int startPage = (page - 1) * pageSize + 1; // 시작 게시물
				int endPage = startPage + pageSize - 1; // 끝 게시물
		        pstmt.setInt(2, startPage);
		        pstmt.setInt(3, endPage);
				System.out.println("query:"+query);
			}else if(ms_title.equals("id")) {
				String query = "SELECT * FROM (SELECT ROWNUM AS RNUM, gym_member.* "
		        		+ "FROM gym_member where member_id like ? "
		        		+ "ORDER BY member_idx desc) WHERE RNUM >= ? and RNUM <= ?";
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
				int member_idx = rs.getInt("member_idx");
        		String member_id = rs.getString("member_id");
        		String member_pw = rs.getString("member_pw");
	            String member_name = rs.getString("member_name");
	            String member_birth_date = rs.getString("member_birth_date");
	            String member_gender = rs.getString("member_gender");
	            String member_phone = rs.getString("member_phone");
	            String member_email = rs.getString("member_email");
	            int member_email_receive = rs.getInt("member_email_receive");
	            int member_coupon01 = rs.getInt("member_coupon01");
	            int member_coupon02 = rs.getInt("member_coupon02");
	            int member_locker = rs.getInt("member_locker");
	            int member_pay_sum = rs.getInt("member_pay_sum");
	            String member_agree = rs.getString("member_agree");
	            Date member_join_date = rs.getTimestamp("member_join_date");
	            
	            MemberDto dto = new MemberDto(member_idx, member_id, member_pw, member_name, member_birth_date,
	            		member_gender, member_phone, member_email, member_email_receive, member_coupon01, member_coupon02,
	            		member_locker, member_pay_sum, member_agree, member_join_date);
        		
	            member_list.add(dto);
	        }
			
		}catch(Exception e) {
			System.out.println("목록에러");
			e.printStackTrace();
		}
		
		return member_list;
	}
	//페이징 처리시 마지막 페이지를 연산하기 위한 함수(검색)
	public static int memSearch_count(HttpServletRequest request) {
		String keyword = request.getParameter("keyword");
		String ms_title = request.getParameter("ms_title");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		try {
			conn = DBConnection.getConnection();
			if(ms_title.equals("joinDay")) {
				String query = "select count(*) from gym_member "
						+ "where to_date(member_join_date, 'YY/MM/DD') = ? order by member_idx desc";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, (keyword));
			} else if(ms_title.equals("name")) {
				String query = "select count(*) from gym_member "
						+ "where member_name like ? order by member_idx desc";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, "%"+keyword+"%");
			} else if(ms_title.equals("id")) {
				String query = "select count(*) from gym_member "
						+ "where member_id like ? order by member_idx desc";
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
