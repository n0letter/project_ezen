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
  
  <%
    String member_idx = (String)session.getAttribute("member_idx");
    String uri = request.getRequestURI();
    System.out.println("현재 주소:" + uri);
    System.out.println("member_idx:" + member_idx);
    if(uri.indexOf("mypage") != -1 && member_idx == null) {
	  response.sendRedirect("/project_ezen/member/loginForm.jsp");
    }
  %>  
  
  <div class="mypage_header_img"></div>  
  
  <!-- 현재위치표시 영역 시작 -->    
  <div class="where">
    <a href="/project_ezen/main.do">H</a>
    <div>마이페이지</div>
    <div>1:1문의</div>
    <div>상세보기</div>
  </div>
  <!-- 현재위치표시 영역 끝 -->
 
  <!-- mypage 영역 시작 -->
  <div class="mypage_wrap">
  
    <!-- 사이드메뉴 -->
	<div class="mypage_menu">
      <table class="mypage_menutable">
	    <tbody>
		  <tr>
		    <th>마이페이지</th>
          </tr>
          <tr>
		    <td><a href="/project_ezen/mypage/Mypage.do?member_idx=${member_idx}"> > 회원정보</a> </td>
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
		    <td>
		      <a class="myclick" href="/project_ezen/mypage/oneonone.do?member_idx=${member_idx}&page=1">> 1:1문의</a> <br>
			  <a href="/project_ezen/mypage/myafter.do?member_idx=${member_idx}&page=1"> >나의 후기</a>
		    </td>
		  </tr>
		  <tr>
		    <th> 개인정보 수정</th>
	      </tr>
		  <tr>
		    <td>
		      <a href="/project_ezen/mypage/mypage_modify.do?member_idx=${member_idx}"> > 개인정보 수정</a> <br>
		      <a href="/project_ezen/mypage/password.do?member_idx=${member_idx}"> > 비밀번호 변경</a><br>
			  <a href="/project_ezen/mypage/joinout.do?member_idx=${member_idx}"> > 회원탈퇴</a>
			 </td>
		  </tr>
	    </tbody>
      </table>  
      
      <div class="mypage_member_top">
  	    <h4><small class="service_small">▌</small>1:1문의</h4>
      
        <!-- 1:1문의 상세보기 -->  
        <div class="oneononeans_table">
      
          <!-- 1:1문의 질문 -->
          <div class="oneononeans_top">
            <div class="oneononeans_leftA">${dto.inq_type}</div>
            <div class="oneononeans_rightA">${dto.inq_title}</div>
          </div>
          <div class="oneononeans_top">
            <div class="oneononeans_leftA">작성일</div>
            <fmt:formatDate value="${dto.inq_date}" pattern="yyyy-MM-dd" var="idate" />
            <div class="oneononeans_rightA">${idate}</div>
            <div class="oneononeans_leftB">답변상태</div>
            <div class="oneononeans_rightA">${dto.inq_state}</div>     
          </div>
          <div class="oneononeans_bottom">
            <textarea class="oneononeans_content" maxlength="200" readonly>${dto.inq_content}</textarea> 
          </div>

          <!-- 1:1문의 답변 -->
          <div class="oneononeans_Answer">
            <c:set var="istate" value="${dto.inq_state}"/>
              <c:choose>
                <c:when test="${ istate eq '미답변' }">
			    </c:when>
                <c:when test="${ istate eq '답변완료' }">
			      <div class="oneononeans_re_left">답변</div>
                  <textarea class="oneononeans_re_content" maxlength="200" readonly>${dto.inq_re_content}</textarea>
 			    </c:when>
              </c:choose>
	      </div>   
	    
	      <!-- 버튼 -->
          <input class="oneononeans_btn" type="button" value="목록" onClick="location.href='/project_ezen/mypage/oneonone.do?member_idx=${member_idx}&page=1'"/>

        </div>
        
      </div> 
    	
	</div>
	
  </div>
  <!-- mypage 영역 끝 -->

  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>

  <c:import url="/footer.jsp" /> 