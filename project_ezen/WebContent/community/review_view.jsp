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
 
  <c:import url="/header.jsp" /> 

  <div class="mypage_header_img"></div>  
  
  <!-- 현재위치표시 영역 시작 -->    
  <div class="where">
    <a href="/project_ezen/main.do">H</a>
    <div>커뮤니티</div>
    <div>이용후기</div>
    <div>상세보기</div>
  </div>
  <!-- 현재위치표시 영역 끝 -->

  <!-- review_view 영역 시작 -->
  <div class="review_view_wrap">
  
    <!-- 상단타이틀 -->
    <div class="review_write_title">
  	  <h4><small class="service_small">▌</small>이용후기 상세보기</h4>
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
		    <div class="reContent" style="white-space:pre;">
		      <span>${dto.review_content}</span>
		    </div> 
		  </td>
        </tr>
	  </table>
	  
	  <!-- 이용후기 수정/삭제버튼 -->   
	  <div class="reContent_buttons"> 
	  
	    <%
	    String member_idx = (String)session.getAttribute("member_idx");
	    
	    if(member_idx != null){
	    %>
	    
	    <c:set var="trans" value="${member_idx}"/>
	    <c:set var="trans2" value="${dto.reviewMember_idx}"/>
	    <c:if test="${ trans eq trans2 }">
	      <form name="" method="post" action="reviewDelete.do" onsubmit="return deletecheck()">
		    <input type="hidden" name="review_idx" value="${dto.review_idx }" />
			<input class="reM" type="button" value="수정" onClick="location.href='/project_ezen/community/review_modify.do?review_idx=${dto.review_idx}';"/>
		    <input class="reD" type="submit" value="삭제" />                         
		  </form>
		</c:if>
		
	    <%	
	    }
	    %>
	    
	  </div>
	  
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
        <form method="post" name="replyDelete" action="reReply_delete.do" onsubmit="return replyDeletecheck()">
          <!-- 댓글이름+작성일 -->
          <div class="review_list_name">
            <fmt:formatDate value="${reply_dto.reReply_date}" pattern="yyyy-MM-dd HH:mm:ss" var="reg2" />
            <span class="re_span01">●</span> ${reply_dto.reReply_name} <span class="re_span02">( ${reg2} )</span>
          </div>
    
          <!-- 댓글내용 -->
          <%-- <form name="frm" method="post" target="HiddenFrame">
	        <input type="hidden" name="reReply_idx" value="${reply_dto.reReply_idx}" />
		    <input type="hidden" name="reReply_review_idx" value="${reply_dto.reReply_review_idx}" />
		  </form> --%>

		  <!-- <form method="post" name="reReplyModify" action="reReplyModify.do"> -->
		    
		    <input type="hidden" name="reReply_idx" value="${reply_dto.reReply_idx}" />
		    <input type="hidden" name="reReply_review_idx" value="${reply_dto.reReply_review_idx}" />
         
            <div class="rehr">
              <div class="reContent"><c:out value="${reply_dto.reReply_content}" /></div>
	        </div>
	      
	        <!-- 댓글수정 -> 등록/취소 -->
	        <!-- <div class="recdbuttonsA">
              <input class="rewritesub01" id="reMo2" style="display:none;" type="submit" value="등록"/>
		      <input class="rewritesub02" id="reMo3" style="display:none;" type="button" onclick="reMoRe()" value="취소"/>
		    </div> -->
		  <!-- </form> -->
		
		  <!-- 댓글수정/삭제 버튼 -->
          <c:set var="trans3" value="${member_idx}"/>
	   	  <c:set var="trans4" value="${reply_dto.reReply_reviewMem_idx}"/>
            <c:choose>
              <c:when test="${trans3 eq trans4 }">
                <div class="recdbuttonsB">
                  <a href="reReply_modify.do?reReply_idx=${reply_dto.reReply_idx}">	
   			      	<input class="rewritesub01" type="button" value="수정" id="reMo00" />
   			      </a>
				  <input class="rewritesub02" type="submit" value="삭제" id="reMo01" />           
                </div>
		      </c:when>
		      <c:otherwise>
		      </c:otherwise>
		    </c:choose>
		</form>
        </c:forEach>
      </div>
      
      <!-- 댓글쓰기 -->       
      <%
        if(member_idx != null){
       %>
       
      <div class="reply_write">
   	    <form method="post" name="reReply" action="reReply.do" onsubmit="return replyCheck()">
   	    
   	      <input type="hidden" name="reReply_reviewMem_idx" value="${ member_idx }" />
   	      <input type="hidden" name="reReply_name" value="${ member_name }" />
   	      <input type="hidden" name="reReply_id" value="${ member_id }" />
   	      <input type="hidden" name="reReply_review_idx" value="${ dto.review_idx }" />
   	      <input type="hidden" name="reReply_reviewMem_idx2" value="${ dto.reviewMember_idx }" />
   	      
	      <div><span class="re_span01">●</span> ${ member_name }</div>
	      <textarea maxlength="500" class="rewrite" name="reviewReply" placeholder="최대 500자까지 작성이 가능합니다.(띄어쓰기 포함) 욕설 또는 비방성 댓글을 작성한 경우 관리자에 의해 삭제될 수 있습니다."></textarea>
		  <input class="rewritesub03" type="submit" value="등록하기"/>
		
	    </form>
      </div>	
         
      <%	   
      }
      %>	
      
      <!-- 목록보기 --> 
	  <input type="button" class="rewritesub04" value="목록" onClick="location.href='/project_ezen/community/review.do?page=1'"/>
      	
    </div>
    
  </div>
  <!-- review_view 영역 끝 -->  
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>
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
		frm.action = "reReply_delete.do"
		frm.submit();
	  } else {
		return false;
        window.history.go(0);
	  }
    }
  </script> 
  <!-- 유효성 검사 -->    
  <script>
  function replyCheck() {
	  if(!reReply.reviewReply.value) {
		  alert("댓글을 작성해 주세요!")
		  return false;
	  }
  }
  </script>  
  
  <!-- 댓글수정버튼실행 -->
  <script>
/*     function replyModifycheck() {
	  document.getElementById('reMo').classList.remove('reReDisplay');
	  document.getElementById('reMo').removeAttribute("readonly");
	  
	  $('#reMo2').css('display','block');
	  $('#reMo3').css('display','block');
	  $('#reMo00').css('display','none');
	  $('#reMo').css('border','1px solid rgba(116, 116, 116, 0.5)');
	  $('#reMo01').css('display','none');
    }
    
    function reMoRe() {
	  document.getElementById('reMo').classList.add('reReDisplay');
	  
	  $('#reMo').attr('readonly', true);
	  $('#reMo2').css('display','none');
	  $('#reMo3').css('display','none');
	  $('#reMo00').css('display','block');
	  
	  location.reload();
    } */
  </script>
  

  <c:import url="/footer.jsp" /> 