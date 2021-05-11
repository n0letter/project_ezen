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
  <c:import url="/header.jsp" />
<%
String member_idx = (String)session.getAttribute("member_idx");
String uri = request.getRequestURI();
System.out.println("현재 주소:" + uri);
System.out.println("member_idx:" + member_idx);
if(uri.indexOf("mypage") != -1 && member_idx == null) {
	response.sendRedirect("/project_ezen/member/loginForm.jsp");
}
%>    

 	<div class="mypage_header_img">
    </div>
    	
<!-- 현재 위치 표시 -->
	<div class="where">
		<a href="/project_ezen/main.jsp">H</a>
		<div>마이페이지</div>
		<div>회원정보</div>
	</div>
  
  <!-- 현재위치표시 영역 끝 -->
  
   <!-- mypage 영역 시작 -->
  <input type="hidden" name="member_idx" value="${dto.member_idx }" /> 
  <div class="mypage_wrap">
		<div class="mypage_menu">
		<table class="mypage_menutable">
			<tbody>
				<tr>
					<th>마이페이지</th>
				
				</tr>
				<tr>
					<td><a class="myclick" href="/project_ezen/mypage/Mypage.do?member_idx=${member_idx}"> > 회원정보</a> </td>
					
				</tr>
				<tr>
					<th> 결제내역</th>
				</tr>
				<tr>
					<td><a href="/project_ezen/mypage/paylist.do?member_idx=${member_idx}&page=1"> > 결제내역</a></td>
				</tr>
				<tr>
					<th> 게시판 이용 내역</th>
				</tr>
				<tr>
					<td><a href="/project_ezen/mypage/oneonone.do?member_idx=${member_idx}&page=1">> 1:1문의</a><br>
						<a href="/project_ezen/mypage/myafter.do?member_idx=${member_idx}&page=1"> >나의 후기</a>
					</td>
				</tr>
				<tr>
					<th> 개인정보 수정</th>
				</tr>
				<tr>
					<td><a href="/project_ezen/mypage/mypage_modify.do?member_idx=${member_idx}"> > 개인정보 수정</a> <br>
						<a href="/project_ezen/mypage/password.do?member_idx=${member_idx}"> > 비밀번호 변경</a><br>
						<a href="/project_ezen/mypage/joinout.do?member_idx=${member_idx}"> > 회원탈퇴</a>
					</td>
				</tr>
			</tbody>
		</table>  
		<div class="mypage_member_top">
  	     <h4><small class="service_small">▌</small>내정보</h4>

		<table class="mypage_member_table">
			<tbody>
				<tr>
					<th>아이디</th>
					<td>${ dto.member_id }</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>${ dto.member_name }</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>${ dto.member_phone }</td>
				</tr>
				<tr>
					<th>생년월일</a></th>
					<td>${ dto.member_birth_date }</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>${ dto.member_email }</td>
				</tr>
				<tr>
					<th>메일 수신 여부</th>
					<td>
					<c:set var="trans" value="${dto.member_email_receive}"/>
		   	      	<c:choose>
						<c:when test="${ trans eq '0' }">
			          		${fn:replace(trans, 0, "비수신")}
						</c:when>
						<c:otherwise>
							${fn:replace(trans, 1, "수신")}
						</c:otherwise>
					</c:choose>
					</td>
				</tr>
				
				
				<tr>
					<th>사물함</th>
					<td>
						<c:set var="trans" value="${dto.member_locker}"/>
			   	      	<c:choose>
							<c:when test="${ trans eq '0' }">
				          		${fn:replace(trans, 0, "미배정")}
							</c:when>
							<c:otherwise>
								${ dto.member_locker }&nbsp;번 사물함
							</c:otherwise>
						</c:choose>
						<%-- <%
						int member_locker = (Integer)request.getAttribute("member_locker"); 
						if(member_locker == 0) {
						%>
						미배정 
						<% 
						} else {
						%> 
						${ dto.member_locker }&nbsp;번 사물함
						<% 
						}
						%> --%>	
				
						<div class="mypage_popup" onclick="myFunction()">쿠폰함
							<span class="mypage_popuptext" id="myPopup">
							1주년 쿠폰(10,000원 할인) ${ dto.member_coupon01 }개 <br>
							후기 이벤트 쿠폰(10% 할인) ${ dto.member_coupon02 }개
							</span>
						</div>

					</td>
				
				</tr>
				
			</tbody>
		</table>  
		</div>
	</div>
	
	</div>
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>
  
	<!-- mypage 영역 끝 -->

  <c:import url="/footer.jsp" />