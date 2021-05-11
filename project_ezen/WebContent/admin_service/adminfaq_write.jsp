<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
response.setHeader("Pragma", "no-cache"); 
response.setHeader("Cache-Control", "no-cache"); 
response.setHeader("Cache-Control", "no-store"); 
response.setDateHeader("Expires", 0L); 
%> 
    
  <c:import url="/admin_header.jsp" />
  
  <%
  String member_idx = (String)session.getAttribute("member_idx");
  String member_id = (String)session.getAttribute("member_id");
  String uri = request.getRequestURI();
  System.out.println("현재 주소:" + uri);
  System.out.println("member_idx:" + member_idx);
  if(uri.indexOf("admin") != -1 && member_idx == null) {
    response.sendRedirect("/project_ezen/member/loginForm.jsp");
  } else if(!member_id.equals("admin")) {
	response.sendRedirect("/project_ezen/main.do");
  }
  %>
  
  <div class="mypage_header_img"></div>  
  
  <!-- 현재위치표시 영역 시작 -->    
  <div class="where">
    <a href="/project_ezen/main.do">H</a>
    <div>고객센터</div>
    <div>FAQ</div>
    <div>글쓰기</div>
  </div>
  <!-- 현재위치표시 영역 끝 -->
  
  <!-- admin_faq_write 영역 시작 -->
  <div class="admin_faq_write_wrap">
  
    <!-- 상단타이틀 -->
    <div class="admin_faq_write_title">
  	  <h4><small class="adminService_small">▌</small>FAQ 글쓰기</h4>
  	</div>
  	
  	<!-- 글쓰기 -->
    <div class="admin_faq_write_content">
      <form name="fwrite" method="post" action="fwrite.do" onsubmit="return FAQcheck()">
        <table class="admin_faq_write_table">
          <tr>
            <th>제목</th>
            <td class="admin_faq_write_td">
              <input class="ftitle" type="text" name="faq_title" placeholder="제목을 입력해 주세요!">
            </td>
          </tr>
          <tr>
            <td colspan="2">
              <textarea name="faq_content" class="ckeditor" cols="52"></textarea>
            </td>
          </tr>
        </table>
        <div class="fbuttons">
          <input class="fwritesub" type="submit" value="등록하기"/>
          <input class="fwritebutton" type="button" value="취소" onClick="cancel()"/>	
	    </div>
      </form>
    </div>
      
  </div>
  <!-- admin_faq_write 영역 끝 -->
 
  <!-- 유효성검사 -->
  <script>
    function FAQcheck() {
      var f = document.fwrite;
    	
      if(f.faq_title.value == "" ) {
        alert('제목을 입력해주세요.');
        f.faq_title.focus();
        return false;
      }
	}
  </script>
  
  <!-- 목록버튼 -->
  <script>
    function cancel() {	
      if(document.getElementsByName('faq_title')[0].value != "" || document.getElementsByName('faq_content')[0].value != "") {
        var a = confirm("FAQ글쓰기를 중단합니다.")
        if(a == true){
          location.href = "/project_ezen/admin_service/admin_faq.do";
          }
      }else {
        location.href = "/project_ezen/admin_service/admin_faq.do";	  
      }
    }
  </script>
  
  <script src="https://cdn.ckeditor.com/4.16.0/standard/ckeditor.js"></script>
  
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>

  <c:import url="/footer.jsp" />