package serviceDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import project_ezen.DBConnection;
import serviceDto.InquiryDto;

public class InquiryDao {
	
  // (고객센터)
  // 1:1문의 글쓰기	
  public static void inquiry(HttpServletRequest request) {	
	Connection conn = null;    
    PreparedStatement pstmt = null;
		            
	String inq_type = request.getParameter("inq_type");
	String inq_title = request.getParameter("inq_title");
	String inq_name = request.getParameter("inq_name");
	String inq_content = request.getParameter("inq_content");
	String inq_state = request.getParameter("inq_state");
	String inq_re_content = request.getParameter("inq_re_content");
	int inq_member_idx = Integer.parseInt(request.getParameter("inq_member_idx"));
		    
	try {		
      conn = DBConnection.getConnection();
	  String query = "INSERT INTO gym_inquiry (inq_idx, inq_type, inq_title, inq_name,"
		   	         + "inq_content, inq_state, inq_re_content, inq_member_idx, inq_date)"
		    		 + "values(gym_inquiry_seq.nextval, ?, ?, ?, ?, ?, ?, ?, sysdate)";
		    
	  pstmt= conn.prepareStatement(query);
	  pstmt.setString(1, inq_type);
	  pstmt.setString(2, inq_title);
	  pstmt.setString(3, inq_name);
	  pstmt.setString(4, inq_content);
	  pstmt.setString(5, inq_state);
	  pstmt.setString(6, inq_re_content);
	  pstmt.setInt(7, inq_member_idx);
		    					
	  int inqresult = pstmt.executeUpdate();
	  System.out.println("update:" + inqresult); 
	}catch (Exception e) {
	  e.printStackTrace();
	  System.out.println("1:1문의 에러");
	}
  }	
  
  // (마이페이지)
  // 1:1문의
  public static ArrayList<InquiryDto> inq_list(int page, String inq_member_idx) {
    ArrayList<InquiryDto> inq_list = new ArrayList<InquiryDto>();  
	  
    Connection conn = null; 
	PreparedStatement pstmt = null;
	ResultSet rs = null;	
	
	try {
	  conn = DBConnection.getConnection(); 
		
      String query = "SELECT * FROM (SELECT ROWNUM AS RNUM, gym_inquiry.* "
	             	 + "FROM gym_inquiry where inq_member_idx = ? ORDER BY inq_idx desc ) "
		             + "WHERE RNUM >= ? and RNUM <= ?";
      pstmt = conn.prepareStatement( query  );
      int pageSize = 5;// 한페이지에 나오는 게시물 개수
      int startPage = (page - 1) * pageSize + 1; // 시작 게시물
	  int endPage = startPage + pageSize - 1; // 끝 게시물
	  pstmt.setInt(1, Integer.parseInt(inq_member_idx));
      pstmt.setInt(2, startPage);
      pstmt.setInt(3, endPage);
	  System.out.println("query:"+query);
      
      rs = pstmt.executeQuery();
		
	  while( rs.next() ) {
	    int inq_idx = rs.getInt("inq_idx");
    	String inq_type = rs.getString("inq_type");
    	String inq_title = rs.getString("inq_title");
    	String inq_name = rs.getString("inq_name");
    	String inq_content = rs.getString("inq_content");
    	String inq_state = rs.getString("inq_state");
    	String inq_re_content = rs.getString("inq_re_content");
        Date inq_date = rs.getTimestamp("inq_date");
        int inq_member_idx_int = rs.getInt("inq_member_idx"); 
            
        InquiryDto dto = new InquiryDto(inq_idx, inq_type, inq_title, inq_name, 
        		         inq_content, inq_state, inq_re_content, 
        		         inq_date, inq_member_idx_int);
    		
        inq_list.add(dto);
      }	
	}catch(Exception e) {
	  e.printStackTrace();
	}	
    return inq_list;
  }
  // 1:1문의 마이페이지 게시글수
  public static int myinq_num(String inq_member_idx) {
    Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String query = "select count(*) from gym_inquiry where inq_member_idx = ?";
		
	try {
	  conn = DBConnection.getConnection();
	  
      pstmt = conn.prepareStatement( query );
      pstmt.setInt(1, Integer.parseInt( inq_member_idx ) );
	  rs = pstmt.executeQuery();
	  
	  if(rs.next()) {
	    return rs.getInt(1);
	  }
	}catch(Exception e) {
	  e.printStackTrace();
    }
	return -1;
  }
  // 1:1문의 상세보기
  public static InquiryDto inq_view(String inq_idx) {
    InquiryDto dto = null;
		
	Connection conn = null;    
    PreparedStatement pstmt = null;    
    ResultSet rs = null;    
       
    try {
      conn = DBConnection.getConnection();
      
      String query = "select * from gym_inquiry where inq_idx=?";
      pstmt = conn.prepareStatement( query );
      pstmt.setInt(1, Integer.parseInt( inq_idx ));
      
      rs = pstmt.executeQuery(); 
        	
      while( rs.next() ) {
    	int inq_idx_int = rs.getInt("inq_idx");
      	String inq_type = rs.getString("inq_type");
      	String inq_title = rs.getString("inq_title");
      	String inq_name = rs.getString("inq_name");
      	String inq_content = rs.getString("inq_content");
      	String inq_state = rs.getString("inq_state");
      	String inq_re_content = rs.getString("inq_re_content");
        Date inq_date = rs.getTimestamp("inq_date");
        int inq_member_idx = rs.getInt("inq_member_idx"); 
	            
	    dto = new InquiryDto(inq_idx_int, inq_type, inq_title, inq_name,
	    	  inq_content, inq_state, inq_re_content, inq_date, inq_member_idx);
      }
    }
    catch( Exception e ) {
      e.printStackTrace();    	
    }
    return dto;
  }
  
  // (관리자페이지-고객센터)
  // 1:1문의 게시글
  public static ArrayList<InquiryDto> admininq_list(int page) {
    ArrayList<InquiryDto> admininq_list = new ArrayList<InquiryDto>();  
		  
	Connection conn = null; 
    PreparedStatement pstmt = null;
	ResultSet rs = null;	
		
	try {
      conn = DBConnection.getConnection(); 
			
	  String query = "SELECT * FROM (SELECT ROWNUM AS RNUM, gym_inquiry.* "
	      		+ "FROM gym_inquiry ORDER BY inq_idx desc) "
	      		+ "WHERE RNUM >= ? and RNUM <= ?";
	  
      pstmt = conn.prepareStatement( query );
      int pageSize = 5;// 한페이지에 나오는 게시물 개수
      int startPage = (page - 1) * pageSize + 1;
	  int endPage = startPage + pageSize - 1; 
      pstmt.setInt(1, startPage);
      pstmt.setInt(2, endPage);
	  System.out.println("query:"+query);
      rs = pstmt.executeQuery();
			
	  while( rs.next() ) {
	    int inq_idx = rs.getInt("inq_idx");
	    String inq_type = rs.getString("inq_type");
	    String inq_title = rs.getString("inq_title");
	    String inq_name = rs.getString("inq_name");
	    String inq_content = rs.getString("inq_content");
	    String inq_state = rs.getString("inq_state");
	    String inq_re_content = rs.getString("inq_re_content");
	    Date inq_date = rs.getTimestamp("inq_date");
	    int inq_member_idx_int = rs.getInt("inq_member_idx"); 
	            
	    InquiryDto dto = new InquiryDto(inq_idx, inq_type, inq_title, inq_name, 
	        		     inq_content, inq_state, inq_re_content, 
	        		     inq_date, inq_member_idx_int);
	    		
	    admininq_list.add(dto);
	  }	
	}catch(Exception e) {
	  e.printStackTrace();
	}	
	return admininq_list;
  }
  // 1:1문의 게시글 수
  public static int admininq_num() {
    Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String query = "select count(*) from gym_inquiry";
		
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
  // 1:1문의 미답변 게시글
  public static ArrayList<InquiryDto> admininqN_list(int pageB) {
    ArrayList<InquiryDto> admininqN_list = new ArrayList<InquiryDto>();  
		  
	Connection conn = null; 
    PreparedStatement pstmt = null;
	ResultSet rs = null;	
		
	try {
      conn = DBConnection.getConnection(); 
			
	  String query = "SELECT * FROM (SELECT ROWNUM AS RNUM, gym_inquiry.* "
	      	 	+ "FROM gym_inquiry where inq_state like '미답변%' ORDER BY inq_idx desc) "
	      		+ "WHERE RNUM >= ? and RNUM <= ?";
	  
      pstmt = conn.prepareStatement( query );
      int pageSize = 5;// 한페이지에 나오는 게시물 개수
      int startPage = (pageB - 1) * pageSize + 1;
	  int endPage = startPage + pageSize - 1; 
      pstmt.setInt(1, startPage);
      pstmt.setInt(2, endPage);
	  System.out.println("query:"+query);
      rs = pstmt.executeQuery();
			
	  while( rs.next() ) {
	    int inq_idx = rs.getInt("inq_idx");
	    String inq_type = rs.getString("inq_type");
	    String inq_title = rs.getString("inq_title");
	    String inq_name = rs.getString("inq_name");
	    String inq_content = rs.getString("inq_content");
	    String inq_state = rs.getString("inq_state");
	    String inq_re_content = rs.getString("inq_re_content");
	    Date inq_date = rs.getTimestamp("inq_date");
	    int inq_member_idx_int = rs.getInt("inq_member_idx"); 
	            
	    InquiryDto dto = new InquiryDto(inq_idx, inq_type, inq_title, inq_name, 
	        		     inq_content, inq_state, inq_re_content, 
	        		     inq_date, inq_member_idx_int);
	    		
	    admininqN_list.add(dto);
	  }	
	}catch(Exception e) {
	  e.printStackTrace();
	}	
    return admininqN_list;
  }
  // 1:1문의 미답변 게시글 수
  public static int admininqN_num() {
    Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String query = "select count(*) from gym_inquiry where inq_state like '미답변%'";
		
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
  // 1:1문의 답변하기
  public static void inq_answer(HttpServletRequest request) {
    Connection conn = null;    
    PreparedStatement pstmt = null;	  
    
    String inq_idx = request.getParameter("inq_idx");
	String inq_state = request.getParameter("inq_state");
	String inq_re_content = request.getParameter("inq_re_content");
    
	try {
	  conn = DBConnection.getConnection();
	  String query = "update gym_inquiry set inq_state = ?, inq_re_content = ?"
				     + "where inq_idx = ?";
	  System.out.println("query:"+query);
	  pstmt = conn.prepareStatement( query );
	  
	  pstmt.setString(1, inq_state);
	  pstmt.setString(2, inq_re_content);
	  pstmt.setString(3, inq_idx);
	  
	  int result = pstmt.executeUpdate();
	  System.out.println(result);
	}catch(Exception e) {
	  e.printStackTrace();
	}
  }
  //회원 탈퇴 시 작성한 모든 문의 삭제
  public static void myInquiryDelete(String inq_member_idx) {
    Connection conn = null;    
    PreparedStatement pstmt = null;    //매개변수 입력 편하게 함. 
  
    try {
		conn = DBConnection.getConnection();
		String query = "DELETE FROM gym_inquiry where inq_member_idx=?";
		pstmt = conn.prepareStatement( query );
		pstmt.setInt(1, Integer.parseInt( inq_member_idx ) );
		
		int result = pstmt.executeUpdate(); //insert, update, delete
		System.out.println("delete result:" + result);
		
	} catch (Exception e) {
		e.printStackTrace();
	}
}  
  
  
  
}