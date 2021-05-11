<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
response.setHeader("Pragma", "no-cache"); //HTTP 1.0
response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
response.setDateHeader("Expires", 0L); // Do not cache in proxy server
%>       
  <c:import url="/header.jsp" />
<%
String member_idx = (String)session.getAttribute("member_idx");
String uri = request.getRequestURI();
System.out.println("현재 주소:" + uri);
System.out.println("member_idx:" + member_idx);
if(uri.indexOf("admin") != -1 && member_idx == null) {
	response.sendRedirect("/project_ezen/member/loginForm.jsp");
}
%>       
  <!-- 현재위치표시 영역 시작 -->  
  
  <div class="mypage_header_img"></div>
  
  <div class="where">
    <a href="/project_ezen/main.jsp">H</a>
    <div>헬스장 소개</div>
    <div>트레이너 소개</div>
  </div>
  	<!-- mypage 영역 끝 -->
<div class="trainer_wrap">
	<div class="tra01_wrap">
	<c:forEach var="dto" items="${ list }">                
 <table style="width:100%" class="trint">
<input type="hidden" name="trainner_idx" value="${ dto.trainner_idx }" />
<input type="hidden" name="trainner_int" value="${ dto.trainner_int }" />	
<input type="hidden" name="trainner_content" value="${ dto.trainner_content }" />
<input type="hidden" name="trainner_img" value="${ dto.trainner_img }" />	
  <tbody><tr>
    <td width="440px"><img src="/project_ezen/upload/${ dto.trainner_img }"></td>
    <td width="60%" colspan="2" class="staff_txt" padding:50px;="">
<h3 name="trainner_int"> ${ dto.trainner_int } </h3>
<hr>
  		${ dto.trainner_content }
</td>
  </tr>
</tbody>
</table>
</c:forEach>
											
				<div class="trainer_intro">
			  <div class="trainer_intro_text">
		        <p>		
		        <br>
						저희 굿초이스의 강사진들은 10년이상 경력의 베테랑 트레이너들로<br>
						고객님들께 최상의 만족감을 드릴 수 있도록 노력하겠습니다<br>
						(자세한 사항은 게시판이나 연락처로 문의해주세요)<br>
											(02-000-0000)<br>
											</p>
								</div>
								</div>			
</div>
</div>

  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>
  <c:import url="/footer.jsp" />