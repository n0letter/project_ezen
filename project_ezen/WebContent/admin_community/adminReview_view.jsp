<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
response.setHeader("Pragma", "no-cache"); //HTTP 1.0
response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
response.setDateHeader("Expires", 0L); // Do not cache in proxy server
%>  
   
  <c:import url="/admin_header.jsp" />

  <%
  String member_idx = (String)session.getAttribute("member_idx");
  String member_id = (String)session.getAttribute("member_id");
  String uri = request.getRequestURI();
  String referer = request.getHeader("referer");
  System.out.println("이전 주소" + referer);
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
    <div>커뮤니티</div>
    <div>이용후기</div>
    <div>상세보기</div>
  </div>
  <!-- 현재위치표시 영역 끝 -->

  <!-- admin_review_view 영역 시작 -->
  <div class="admin_review_wrap">
  
    <!-- 상단타이틀 -->
    <div class="admin_review_view_title">
  	  <h4><small class="adminService_small">▌</small>이용후기 상세보기</h4>
  	</div>
  
    <!-- 이용후기 내용 -->
    <div class="review_view_content">
    
      <table class="review_view_table">
	    <tr>	    
		  <th colspan="1" class="review_view_th01">제목</th>
		  <td colspan="3" class="review_view_td01">${dto.review_title}</td>	
		  <th class="review_view_th02">작성자</th>
		  <td class="review_view_td02">${dto.review_name}</td>	  
		</tr>
		<tr>	      
		  <th class="review_view_th01">작성일</th>
		  <fmt:formatDate value="${dto.review_date}" pattern="yyyy-MM-dd HH:mm:ss" var="reg" />
		  <td class="review_view_td03">${reg}</td>	
		  <th class="review_view_th03">조회수</th>
		  <td class="review_view_td04">${dto.review_hit}</td>	
		  <td colspan="2" class="review_view_tdN"></td> 
		</tr>
		<tr class="review_view_bottom">
		  <td colspan="6">
		    <div class="reContent" readonly>${dto.review_content}</div> 
		  </td>
        </tr>
	  </table>
	       
      <!-- 이용후기 댓글 -->
	  <c:set var="r" value="${dto.review_reply_count}"/>	 
	  <c:choose>	
	    <c:when test="${ r == '0' }" >
	      <table class="relist">
	        <tr>
		      <th>댓글 0</th>
	   	    </tr>
	      </table>  
        </c:when>	
	    <c:otherwise >
	      <table class="relist">
	        <tr>
		      <th>댓글 ${dto.review_reply_count}개</th>
		    </tr>
	      </table>       
	    </c:otherwise>	
	  </c:choose>
	       
      <!-- 댓글목록 -->	       
	  <div class="review_list">
		<c:forEach var="reply_dto" items="${ reply_list }"> 
	    <form name="" method="post" action="adReReply_delete.do" onsubmit="return replyDeletecheck();">
		  
		  <input type="hidden" name="reReply_idx" value="${reply_dto.reReply_idx}" />
		  <input type="hidden" name="reReply_review_idx" value="${reply_dto.reReply_review_idx}" />
		  
		     
            <!-- 댓글이름+작성일 -->
            <div class="review_list_name">
              <fmt:formatDate value="${reply_dto.reReply_date}" pattern="yyyy-MM-dd HH:mm:ss" var="reg2" />
              <span class="re_span01">●</span> ${reply_dto.reReply_name} <span class="re_span02">( ${reg2} )</span>
            </div>	
				
            <div class="rehr">
              <textarea id="reMo" class="reReContent reReDisplay" name="reviewReply" readonly>${reply_dto.reReply_content}</textarea>
	        </div>

		    <!-- 댓글 삭제버튼 -->
            <div class="recdbuttonsA">
              <input class="rewritesub01" type="submit" value="삭제" />
		    </div>
		    
	    </form>					
        </c:forEach>		
          
      </div>	
				
	  <!-- 목록/삭제 버튼 --> 	
	  <form name="frmM" method="post" action="adReviewDelete.do" onsubmit="return deletecheck()">
		<input type="hidden" name="review_idx" value="${dto.review_idx }" />
		<input type="submit" class="rewritesub02" value="삭제"/> 
		<input type="button" class="rewritesub03" value="목록" onClick="location.href='adminReview.do?page=1'"/>
      </form> 
   
    </div>
	
  </div>
  <!-- admin_review_view 영역 끝 -->  
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>  
  <script src="https://cdn.ckeditor.com/4.16.0/standard/ckeditor.js"></script>
  
  <!-- 삭제버튼실행 --> 	 
  <script> 
    $('textarea').css("resize", "none");
    
	function deletecheck() {
		var a = confirm("글을 삭제하시겠습니까?")
		if(a == true){
			
		} else {
			return false;
			window.history.go(0);
		}
	}
	function replyDeletecheck() {
		var a = confirm("댓글을 삭제하시겠습니까?")
		if(a == true){
			
		} else {
			return false;
			window.history.go(0);
		}
	}
  </script>   

  <c:import url="/footer.jsp" /> 