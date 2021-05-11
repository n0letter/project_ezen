<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
    <div>1:1문의</div>
    <div>상세보기</div>
  </div>
  <!-- 현재위치표시 영역 끝 -->
  
  <!-- admin_inquiry_view 영역 시작 -->
  <div class="admin_inquiry_view_wrap">
  
    <!-- 상단타이틀+버튼 -->
    <div class="admin_inquiry_view_title">
  	  <h4><small class="adminService_small">▌</small>1:1문의 상세보기</h4>
  	</div>
  	
  	<!-- 1:1문의 상세보기 -->
  	<div class="admin_inquiry_view_table">
      <div class="admin_inquiry_view_top">
        <div class="admin_inquiry_view_left">${dto.inq_type}</div>
        <div class="admin_inquiry_view_right">${dto.inq_title}</div>
      </div>
      <div class="admin_inquiry_view_top">
        <div class="admin_inquiry_view_left">작성자</div>
        <div class="admin_inquiry_view_right">${dto.inq_name}</div>
        <div class="admin_inquiry_view_leftB">작성일</div>
        <fmt:formatDate value="${dto.inq_date}" pattern="yyyy-MM-dd" var="idate" />
        <div class="admin_inquiry_view_right">${idate}</div>
      </div>
      <div class="admin_inquiry_view_content" style="white-space:pre;"><c:out value="${dto.inq_content}" />
      </div>
    </div> 
    
    <hr>
    
    <!-- 1:1문의 답변하기+답변상태+버튼 -->
    <c:set var="istate" value="${dto.inq_state}"/>
      <c:choose>
        <c:when test="${ istate == '미답변' }" >
          <form name="inquiryAnswer" method="post" action="iAnswer.do" onsubmit="return Answercheck()">
    
            <input type="hidden" name="inq_idx" value="${dto.inq_idx}" /> 
     
            <div class="admin_inquiry_view_Answer">
              <textarea name="inq_re_content" class="admin_inquiry_Answer_content" maxlength="200" placeholder="답변을 작성해 주세요."></textarea>
	          <div class="Answer_bottom">
	            <select class="iselect" name="inq_state">
                  <option value="">답변상태</option>
	              <option value="미답변">미답변</option>
		          <option value="답변완료">답변완료</option>  
	            </select> 
                <input class="iAnswersub" type="submit" value="답변하기"/>
                <input class="iAnswerbtn" type="button" value="목록" onClick="cancel()"/>	
	          </div>       
            </div>
          </form>
        </c:when>
        <c:when test="${ istate == '답변완료' }" >
          <form name="inquiryAnswer" method="post" action="iAnswer.do" onsubmit="return Answercheck()">
    
            <input type="hidden" name="inq_idx" value="${dto.inq_idx}" /> 
     
            <div class="admin_inquiry_view_Answer">
              <textarea name="inq_re_content" class="admin_inquiry_Answer_content" maxlength="200">${dto.inq_re_content}</textarea>
	          <div class="Answer_bottom">
	            <input name="inq_state" type="text" class="iselectB" value="답변완료" readonly>
                <input class="iAnswersub" type="submit" value="수정하기"/>
                <input class="iAnswerbtnB" type="button" value="목록" onClick="location.href='/project_ezen/admin_service/admin_inquiry.do?page=1'"/>	
	          </div>       
            </div>
          </form>
        </c:when> 
      </c:choose> 
               
  </div>
  <!-- admin_inquiry 영역 끝 -->
  
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>
  
  <!-- 유효성검사 -->
  <script>
    function Answercheck() {
      var i = document.inquiryAnswer;
    	
      if(i.inq_re_content.value == "" ) {
        alert('답변을 작성해주세요.');
        i.inq_re_content.focus();
        return false;
      }
      if(i.inq_state.value == "" ) {
        alert('답변상태를 선택해주세요.');
        i.inq_state.focus();
        return false;
      }
      if(i.inq_re_content.value != "" && i.inq_state.value == "미답변" ) {
        alert('답변을 작성한 상태에서 미답변을 선택했습니다. \n답변상태를 다시 선택해주세요.');
        i.inq_re_content.focus();
        i.inq_state.focus();
        return false;
      }
	}
  </script>
  
  <!-- 목록버튼 -->
  <script>
    function cancel() {	
      if(document.getElementsByName('inq_re_content')[0].value != "" ){
        var a = confirm("답변등록을 중단합니다.")
        if(a == true){
          location.href = "/project_ezen/admin_service/admin_inquiry.do?page=1";
          }
      }else {
        location.href = "/project_ezen/admin_service/admin_inquiry.do?page=1";	  
      }
    }
  </script>

  <c:import url="/footer.jsp" />