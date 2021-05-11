package serviceDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import project_ezen.DBConnection;
import serviceDto.FaqDto;

public class FaqDao {

  // (고객센터)
  // FAQ목록
  public static ArrayList<FaqDto> faq_list() {
    ArrayList<FaqDto> faq_list = new ArrayList<FaqDto>();

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
	  conn = DBConnection.getConnection();

	  String query = "select * from gym_faq order by faq_idx desc";
	  pstmt = conn.prepareStatement(query);
	  rs = pstmt.executeQuery();

	  while (rs.next()) {
	    int faq_idx = rs.getInt("faq_idx");
		String faq_title = rs.getString("faq_title");
		String faq_content = rs.getString("faq_content");
		Date faq_date = rs.getTimestamp("faq_date");

		FaqDto dto = new FaqDto(faq_idx, faq_title, faq_content, faq_date);

		faq_list.add(dto);
	  }
	} catch (Exception e) {
	  e.printStackTrace();
	}
	return faq_list;
  }
  // FAQ 상세보기
  public static FaqDto faq_view(String faq_idx) {
    FaqDto dto = null;

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
	  conn = DBConnection.getConnection();

	  String query = "select * from gym_faq where faq_idx=?";
	  pstmt = conn.prepareStatement(query);
	  pstmt.setInt(1, Integer.parseInt(faq_idx));

	  rs = pstmt.executeQuery();

	  while (rs.next()) {
		int faq_idx_int = rs.getInt("faq_idx");
		String faq_title = rs.getString("faq_title");
		String faq_content = rs.getString("faq_content");
		Date faq_date = rs.getTimestamp("faq_date");

		dto = new FaqDto(faq_idx_int, faq_title, faq_content, faq_date);
	  }
	} catch (Exception e) {
	  e.printStackTrace();
	}
	return dto;
  }
	
  // (관리자페이지)
  // FAQ 글쓰기
  public static void Faq(HttpServletRequest request) {
	Connection conn = null;
    PreparedStatement pstmt = null;
	  
	String faq_title = request.getParameter("faq_title"); 
	String faq_content = request.getParameter("faq_content");
	  
	try { 
	  conn = DBConnection.getConnection(); 
	  
	  String query = "INSERT INTO gym_faq (faq_idx, faq_title, faq_content, faq_date)"
	                 + "values(gym_faq_seq.nextval, ?, ?, sysdate)";
	  
	  pstmt= conn.prepareStatement(query); 
	  pstmt.setString(1, faq_title);
	  pstmt.setString(2, faq_content);
	  
	  int faqresult = pstmt.executeUpdate(); 
	  System.out.println("update:" +faqresult); 
	}catch (Exception e) {
	  e.printStackTrace();
	  System.out.println("Faq 에러");
	} 
  }
  //FAQ 수정하기
  public static void Faq_modify(HttpServletRequest request) {
	Connection conn = null;
    PreparedStatement pstmt = null;
	  
    String faq_idx = request.getParameter("faq_idx");
	String faq_title = request.getParameter("faq_title"); 
	String faq_content = request.getParameter("faq_content");
	  
	try { 
	  conn = DBConnection.getConnection(); 
	  
	  String query = "update gym_faq set faq_title = ?, faq_content = ?"
			         + "where faq_idx = ?";
	  System.out.println("query:"+query);
	  pstmt = conn.prepareStatement( query );
	  
	  pstmt.setString(1, faq_title);
	  pstmt.setString(2, faq_content);
	  pstmt.setString(3, faq_idx);
	  
	  int result = pstmt.executeUpdate();
	  System.out.println(result);
	}catch (Exception e) {
	  e.printStackTrace();
	  System.out.println("Faq 에러");
    } 
  }   
  // FAQ 삭제하기
  public static void faq_delete(HttpServletRequest request){
    String faq_idx = request.getParameter("faq_idx");
    
	Connection conn = null;    
    PreparedStatement pstmt = null;
      
    try {
	  conn = DBConnection.getConnection();
	    
      String query ="delete from gym_faq where faq_idx=?";
      System.out.println("query:"+query);
	  pstmt = conn.prepareStatement( query );
	  pstmt.setInt(1, Integer.parseInt(faq_idx));
			
	  int result = pstmt.executeUpdate();
      System.out.println("delete result:" + result);
    } 
    catch(Exception e) {
	  e.printStackTrace();
	}
  }
	 
}