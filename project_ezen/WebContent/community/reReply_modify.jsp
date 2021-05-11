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

<!-- 현재 위치 표시 -->
	<div class="where">
		<a href="/project_ezen/main.do">H</a>
		<div>커뮤니티</div>
		<div>이용후기</div>
		<div>댓글수정</div>
	</div>

	<div class="reReply_mo_wrap">
		<!-- 상단타이틀 -->
	    <div class="reReMo_title">
	  	  <h4><small class="service_small">▌</small>댓글 수정</h4>
	  	</div>
	  	
		<div class="reReply_mo_notice">
			<p>최대 500자까지 작성이 가능합니다.(띄어쓰기 포함)<br>
				욕설 또는 비방성 댓글을 작성한 경우 관리자에 의해 삭제될 수 있습니다.
			</p>
		</div>
		<div class="reReply_mo_text">
		<form method="post" name="reReplyMo" action="reReplyModify.do" onsubmit="return reReMoCheck()">
	   	  <input type="hidden" name="reReply_idx" value="${ dto.reReply_idx }" />
	   	  <input type="hidden" name="reReply_name" value="${ member_name }" />
	   	  <input type="hidden" name="reReply_id" value="${ member_id }" />
	   	  <input type="hidden" name="reReply_review_idx" value="${ dto.reReply_review_idx }" />
			<div class="reReply_text">
				<textarea maxlength="500" class="rrt_area" name="reReplyCon" placeholder="댓글">${ dto.reReply_content }</textarea>
				<div class="rm_btnArea">
					<input type="submit" class="rm_btn" value="수정" />
					<a href="javascript:window.history.go(-1);" ><input type="button" class="rm_btn rm_btn03" value="취소" /></a>
				</div>
			</div>
		</form>
		</div>	
	
	</div>
	
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>	
<!-- 유효성 검사 -->
<script>
	function reReMoCheck() {
		if(!document.reReplyMo.reReplyCon.value) {
			alert("댓글을 작성해 주세요!")
			return false;
		}
	}
</script>





<c:import url="/footer.jsp" />