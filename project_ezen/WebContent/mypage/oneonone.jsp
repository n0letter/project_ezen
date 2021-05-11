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

      <!-- 1:1문의 게시판 -->
      
     <div class="mypage_member_top">
  	   <h4><small class="service_small">▌</small>1:1문의</h4>
      
	    <table class="oneonone_table">
	      <tr>
		    <th>번호</th>
		    <th>유형</th>
		    <th>제목</th>
		    <th>답변상태</th>
		    <th>작성일</th>          
	      </tr>
		  <tr>
		  <% int num=1; %> 
		  <c:forEach var="dto" begin="0" step="1" items="${ inq_list }"> 
	   	    <tr onclick="location.href='/project_ezen/mypage/oneononeans.do?inq_idx=${dto.inq_idx}';" style="cursor:pointer;">
		      <td><%= num %><% num=num+1; %></td> 
              <td>${dto.inq_type}</td>
		      <td class="inq_list_title">${dto.inq_title}</td>
			  <td>${dto.inq_state}</td>
		   	  <fmt:formatDate value="${dto.inq_date}" pattern="yyyy-MM-dd" var="idate" />
              <td>${idate}</td>
		    </tr>
          </c:forEach>
	    </table>
	    
	  <!--페이징 처리 -->
	  <ul class="pagination justify-content-center">
        <c:if test="${myinq_num > 0}">
        
		  <!--페이지 개수  -->
		  <c:set var="pageCount" value="${myinq_num / pageSize + ( myinq_num % pageSize == 0 ? 0 : 1)}" />
		  <c:set var="startPage" value="${pageGroupSize*(nowPageGroup-1)+1}" />
		  <c:set var="endPage" value="${startPage + pageGroupSize-1}" />
		  <c:if test="${endPage > pageCount}">
		    <c:set var="endPage" value="${pageCount}" />
		  </c:if>
		 
		  <c:if test="${nowPageGroup > 1}">
		    <li class="page-item">
		      <a class="page-link" href="<c:url value = "/project_ezen/mypage/oneonone.do?page=${(nowPageGroup-2)*pageGroupSize+1 }&pageSize=${pageSize}&member_idx=${member_idx}"/>">
		        이전
		      </a>
		    </li>
		  </c:if>
		 
		  <c:forEach var="i" begin="${startPage}" end="${endPage}">
		    <c:choose>
              <c:when test="${param.page eq i }">
			    <li class="page-item active" aria-current="page">
				  <a class="page-link" href="<c:url value="/project_ezen/mypage/oneonone.do?page=${i}&pageSize=${pageSize}&member_idx=${member_idx}"/>">				     
				    ${i} 
				  </a>
			    </li>
		      </c:when>
		      <c:otherwise>
			    <li class="page-item">
				  <a class="page-link" href="<c:url value="/project_ezen/mypage/oneonone.do?page=${i}&pageSize=${pageSize}&member_idx=${member_idx}"/>">				     
				    ${i} 
				  </a>
			    </li>
		      </c:otherwise>
		    </c:choose>
		    </c:forEach>
		    
		    <c:if test="${nowPageGroup < pageGroupCount}">
		      <li class="page-item">
		        <a class="page-link" href="<c:url value = "/project_ezen/mypage/oneonone.do?page=${nowPageGroup*pageGroupSize+1}&pageSize=${pageSize}&member_idx=${member_idx}"/>">
		          다음
		        </a>
		      </li>
		    </c:if>
		    
		  </c:if>
        </ul>
	    
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