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
  </div>
  <!-- 현재위치표시 영역 끝 -->
   
  <!-- admin_review 영역 시작 --> 
  <div class="adminReview_wrap">
  
    <!-- 검색하기 -->     
	<form class="ml_search_wrap" action="adReviewSearch.do" name="adReviewSearch" onsubmit="return arSearch()">
      <div>
	    <select name="ar_title" class="memList_select">
		  <option value="title">제목</option>
		  <option value="contents">내용</option>
		  <option value="tOrC">제목+내용</option>
		  <option value="writer">작성자</option>
	    </select>
      </div>
	  <div>
	    <input type="text" name="keyword" value="${keyword }" placeholder="검색어를 입력하세요." class="ml_search_text">
	  </div>
	  <div>
	    <input type="submit" class="ml_search_btn" value="검색">
	  </div>
      <input type="hidden" name="page" value="1">
    </form>
         
    <!-- 표 -->	        
	<div class="adminReview_table">
      <table class="adminReview_table_wrap">
	    <tr>
	      <th>번호</th>
	      <th class="adminReview_title">제목</th>
	      <th>작성자</th>
	      <th>작성일</th>
	      <th>조회수</th>          
	    </tr>
	    <c:forEach var="dto" items="${review_list}">
		  <tr onclick="location.href='/project_ezen/admin_community/adminReview_view.do?review_idx=${dto.review_idx}';" style="cursor:pointer;">
		    <td>${ dto.review_idx }</td>
		    <c:set var="r" value="${dto.review_reply_count}"/>
	          <c:choose>	
	            <c:when test="${ r == '0' }" >
		          <td class="adminReview_title">${ dto.review_title }</td>
		        </c:when>	
		        <c:otherwise >
		          <td class="adminReview_title">${ dto.review_title }<span>&nbsp;[${ dto.review_reply_count }]</span></td>
		        </c:otherwise>	
		      </c:choose>
			<td>${dto.review_name}</td>
			<fmt:formatDate value="${dto.review_date}" pattern="yyyy-MM-dd" var="reg" />
			<td>${reg}</td>
			<td>${dto.review_hit}</td>
		  </tr>
		</c:forEach>
	  </table>
    </div>
     
	<!-- 페이징 처리 --> 	  
	<ul class="pagination justify-content-center">
      <c:if test="${reviewCount > 0}">
      
	    <!--페이지 개수  -->
	    <c:set var="pageCount" value="${reviewCount / pageSize + ( reviewCount % pageSize == 0 ? 0 : 1)}" />
	    <c:set var="startPage" value="${pageGroupSize*(nowPageGroup-1)+1}" />
	    <c:set var="endPage" value="${startPage + pageGroupSize-1}" />
	    <c:if test="${endPage > pageCount}">
	      <c:set var="endPage" value="${pageCount}" />
	    </c:if>
		 
	    <c:if test="${nowPageGroup > 1}">
		  <li class="page-item">
		    <a class="page-link" href="<c:url value = "/project_ezen/admin_community/adminReview.do?page=${(nowPageGroup-2)*pageGroupSize+1 }&pageSize=${pageSize}"/>">
		      이전
		    </a>
		  </li>
        </c:if>
		 
	    <c:forEach var="i" begin="${startPage}" end="${endPage}">
	      <c:choose>
            <c:when test="${param.page eq i }">
		  	  <li class="page-item active" aria-current="page">
			    <a class="page-link" href="<c:url value="/project_ezen/admin_community/adminReview.do?page=${i}&pageSize=${pageSize}"/>">				     
			      ${i} 
			    </a>
			  </li>
		    </c:when>
		    <c:otherwise>
			  <li class="page-item">
			    <a class="page-link" href="<c:url value="/project_ezen/admin_community/adminReview.do?page=${i}&pageSize=${pageSize}"/>">				     
			  	  ${i} 
			    </a>
			  </li>
		    </c:otherwise>
		  </c:choose>
	    </c:forEach>
	    
	    <c:if test="${nowPageGroup < pageGroupCount}">
	      <li class="page-item">
		    <a class="page-link" href="<c:url value = "/project_ezen/admin_community/adminReview.do?page=${nowPageGroup*pageGroupSize+1}&pageSize=${pageSize}"/>">
		      다음
		    </a>
	      </li>
	    </c:if>

	  </c:if>
    </ul> 	    

  </div>  
  <!-- admin_review 영역 끝 --> 
     
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>
   
  <c:import url="/footer.jsp" />