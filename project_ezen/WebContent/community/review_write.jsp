<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
response.setHeader("Pragma", "no-cache"); 
response.setHeader("Cache-Control", "no-cache"); 
response.setHeader("Cache-Control", "no-store"); 
response.setDateHeader("Expires", 0L); 
%> 

  <c:import url="/header.jsp" />
  
  <%
  String member_idx = (String)session.getAttribute("member_idx");
  String uri = request.getRequestURI();
  System.out.println("현재 주소:" + uri);
  System.out.println("member_idx:" + member_idx);
  if(member_idx == null) {
  response.sendRedirect("/project_ezen/member/loginForm.jsp");
  }
  %>     

  <div class="mypage_header_img"></div>  
  
  <!-- 현재위치표시 영역 시작 -->    
  <div class="where">
    <a href="/project_ezen/main.do">H</a>
    <div>커뮤니티</div>
    <div>이용후기</div>
    <div>글쓰기</div>
  </div>
  <!-- 현재위치표시 영역 끝 -->
  
  <!-- review_write 영역 시작 -->                   
  <div class="review_write_wrap">
  
    <!-- 상단타이틀 -->
    <div class="review_write_title">
  	  <h4><small class="service_small">▌</small>이용후기 글쓰기</h4>
  	</div>
  	
    <div class="review_write_content">
      <form name="rewrite" method="post" action="reviewWrite.do" onsubmit="return reviewCheck()">
      
        <input type="hidden" name="review_id" value="${member_id}" />
      	<input type="hidden" name="review_member_idx" value="${member_idx}" />
      	<input type="hidden" name="review_name" value="${member_name}" />
      	
        <table class="review_write_table">
          <tr>
            <th>제목</th>
            <td class="review_write_td">
              <input class="retitle" type="text" name=review_title placeholder="제목을 입력해 주세요!">
            </td>
          </tr>         
          <tr>
            <td colspan="2">
              <textarea name="review_content" class="ckeditor" cols="52"></textarea>
            </td>
          </tr>
        </table>               
        <div class="nbuttons">
          <input class="nwritesub" type="submit" value="등록"/>
          <input class="nwritebutton" type="button" value="취소" onClick="location.href='/project_ezen/community/review.do?page=1';"/>
	    </div>
      </form>
    </div>
    
  </div>
  <!-- review_write 영역 끝 -->        

  <script src="https://cdn.ckeditor.com/4.16.0/standard/ckeditor.js"></script>
  
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>

  <!-- 유효성 검사 -->    
  <script>
  function reviewCheck() {
	  if(!rewrite.review_title.value) {
		  alert("제목을 작성해 주세요!")
		  return false;
	  }
	  /* if(!rewrite.review_content.value) {
		  alert("내용을 작성해 주세요!")
		  return false;
	  } */
  }
  </script> 


  <c:import url="/footer.jsp" />