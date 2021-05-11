<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
System.out.println("현재 주소:" + uri);
System.out.println("member_idx:" + member_idx);
if(uri.indexOf("admin") != -1 && member_idx == null) {
	response.sendRedirect("/project_ezen/member/loginForm.jsp");
} else if(!member_id.equals("admin")) {
	response.sendRedirect("/project_ezen/main.do");
}
%>
	<div class="mypage_header_img">
    </div>
   	
<!-- 현재 위치 표시 -->
	<div class="where">
		<a href="/project_ezen/main.jsp">H</a>
		<div>회원 관리</div>
		<div>탈퇴 사유</div>
	</div>

<!-- 섹션 영역 시작 -->
    <div class="omv_wrap">
	    <div class="omv_table">
	        <div class="omvt_top">
		        <div>이름</div>
		        <div>${ dto.out_member_name }</div>
	        </div>
	        <div class="omvt_top">
		        <div>아이디</div>
		        <div>${ dto.out_member_id }</div>
	        </div>
	        <div class="omvt_top">
		        <div>탈퇴일</div>
		        <fmt:formatDate value="${dto.out_member_date}" pattern="yyyy-MM-dd" var="reg" />
		        <div>${ reg }</div>
	        </div>
	        <div class="omvt_top">
		        <div>탈퇴 사유</div>
		        <div>
			        <c:set var="trans" value="${dto.out_member_reason}"/>
			        <c:if test="${fn:contains(trans, 'null')}">  
					   ${fn:replace(trans, 'null', "")}
					</c:if> 
				</div> 
	        </div>
	        <div class="omvt_bottom">${ dto.out_member_opinion }</div>
	    </div>  
	    <div class="om_list_wrap">
	    	<button class="om_list" onclick="location.href='/project_ezen/admin_member/outMember_list.do?page=1' ">
	    		목록
	    	</button>
        </div> 
    </div>

  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>
    
<!-- 섹션 영역 끝 -->

	<c:import url="/footer.jsp" />	