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
  }else if(!member_id.equals("admin")) {
	response.sendRedirect("/project_ezen/main.do");
  }
  %>
  
  <div class="mypage_header_img"></div>  
  
  <!-- 현재위치표시 영역 시작 -->    
  <div class="where">
    <a href="/project_ezen/main.do">H</a>
    <div>고객센터</div>
    <div>1:1문의</div>
  </div>
  <!-- 현재위치표시 영역 끝 -->
  
  <!-- admin_inquiry 영역 시작 -->
  <div class="admin_inquiry_wrap">
    
    <%
    int inqNO = (Integer)request.getAttribute("inqNO") == null? 0:(Integer)request.getAttribute("inqNO");
    System.out.println("inqNO:"+inqNO);
    
	if(inqNO == 0){
    %>

    <!-- 상단타이틀+버튼 -->
    <form action="admin_inquiryNo.do" method="post" >
    
      <input type="hidden" name="page" value="1">
    
      <div class="admin_inquiry_title">
  	    <h4><small class="adminService_small">▌</small>1:1문의 리스트</h4>
	    <input type="submit" class="admin_inquiry_btn" id="admin_inquiry_btn" value="미답변 문의만 보기" onclick="inquiry_change()">
  	  </div>
  	</form>
  	
    <!-- 모든상태 표 -->
    <div class="admin_inquiry_table"> 	        
      <table class="admin_inquiry_table_wrap">
        <tr>
          <th>번호</th>
          <th>유형</th>
          <th>제목</th>
          <th>작성자</th>
          <th>답변상태</th>
          <th>작성일</th>
        </tr>
  		<% int numA=1; %> 
		<c:forEach var="dto" begin="0" step="1" items="${ admininq_list }"> 
	   	  <tr onclick="location.href='/project_ezen/admin_service/admininquiry_view.do?inq_idx=${dto.inq_idx}';" style="cursor:pointer;">
		    <td><%= numA %><% numA=numA+1; %></td> 
            <td>${dto.inq_type}</td>
		    <td>${dto.inq_title}</td>
		    <td>${dto.inq_name}</td>
			<td>${dto.inq_state}</td>
			<fmt:formatDate value="${dto.inq_date}" pattern="yyyy-MM-dd" var="idate"/>
            <td>${idate}</td>
		  </tr>
        </c:forEach>
	  </table>
    </div>

    <!--모든상태 페이징 처리 -->
    <ul class="pagination justify-content-center" >
	  <c:if test="${inqcount > 0}">
	  
	    <!--페이지 개수  -->
	    <c:set var="pageCount" value="${inqcount / pageSize + ( inqcount % pageSize == 0 ? 0 : 1)}"/>
	    <c:set var="startPage" value="${pageGroupSize*(nowPageGroup-1)+1}" />
		<c:set var="endPage" value="${startPage + pageGroupSize-1}" />	
		<c:if test="${endPage > pageCount}">
		  <c:set var="endPage" value="${pageCount}" />
    	</c:if>		
    	 
		<c:if test="${nowPageGroup > 1}">
		  <li class="page-item">
		    <a class="page-link" href="<c:url value = "/project_ezen/admin_service/admin_inquiry.do?page=${(nowPageGroup-2)*pageGroupSize+1 }&pageSize=${pageSize}"/>">
		      이전
	        </a>
	      </li>
        </c:if>
          
	    <c:forEach var="i" begin="${startPage}" end="${endPage}">
		  <c:choose>
	        <c:when test="${param.page eq i }">
			  <li class="page-item active" aria-current="page">
		        <a class="page-link" href="<c:url value="/project_ezen/admin_service/admin_inquiry.do?page=${i}&pageSize=${pageSize}"/>">				     
			      ${i} 
				</a>
			  </li>
			</c:when>
		    <c:otherwise>
		      <li class="page-item">
			    <a class="page-link" href="<c:url value="/project_ezen/admin_service/admin_inquiry.do?page=${i}&pageSize=${pageSize}"/>">				     
			      ${i} 
			    </a>
			  </li>
		    </c:otherwise>
		  </c:choose>
		</c:forEach>
		  
        <c:if test="${nowPageGroup < pageGroupCount}">
		  <li class="page-item">
		    <a class="page-link" href="<c:url value = "/project_ezen/admin_service/admin_inquiry.do?page=${nowPageGroup*pageGroupSize+1}&pageSize=${pageSize}"/>">
		      다음
		    </a>
	      </li>
	    </c:if>
		  
	  </c:if>
    </ul>

    <% 
    }else if(inqNO == 1 ) {
    %>
    
    <!-- 상단타이틀+버튼 -->
    <form action="admin_inquiry.do" method="post" >
    
      <input type="hidden" name="page" value="1">

      <div class="admin_inquiry_title">
  	    <h4><small class="adminService_small">▌</small>1:1문의 미답변 리스트</h4>
	    <input type="submit" class="admin_inquiry_btn" id="admin_inquiry_btn" value="모든 문의 보기" >
  	  </div>
  	</form>
     
    <!-- 미답변상태 표 -->
    <div class="admin_inquiry_table"> 	        
      <table class="admin_inquiry_table_wrap">
        <tr>
          <th>번호</th>
          <th>유형</th>
          <th>제목</th>
          <th>작성자</th>
          <th>답변상태</th>
          <th>작성일</th>
        </tr>
  	    <% int numB=1; %> 
	    <c:forEach var="dto" begin="0" step="1" items="${ admininqN_list }"> 
	   	  <tr onclick="location.href='/project_ezen/admin_service/admininquiry_view.do?inq_idx=${dto.inq_idx}';" style="cursor:pointer;">
		    <td><%= numB %><% numB=numB+1; %></td> 
            <td>${dto.inq_type}</td>
		    <td>${dto.inq_title}</td>
		    <td>${dto.inq_name}</td>
	        <td>${dto.inq_state}</td>
		    <fmt:formatDate value="${dto.inq_date}" pattern="yyyy-MM-dd" var="idate"/>
            <td>${idate}</td>
		  </tr>
        </c:forEach>
	  </table>
    </div>
     
    <!-- 미답변상태 표 페이징 처리 -->
    <ul class="pagination justify-content-center">
	  <c:if test="${inqNcount > 0}">
	  
	    <!--페이지 개수  -->
	    <c:set var="pageCount" value="${inqNcount / pageSize + ( inqNcount % pageSize == 0 ? 0 : 1)}"/>
	    <c:set var="startPage" value="${pageGroupSize*(nowPageGroupN-1)+1}" />
		<c:set var="endPage" value="${startPage + pageGroupSize-1}" />	
		<c:if test="${endPage > pageCount}">
		  <c:set var="endPage" value="${pageCount}" />
    	</c:if>		
    	 
		<c:if test="${nowPageGroupN > 1}">
		  <li class="page-item">
			<a class="page-link" href="<c:url value = "/project_ezen/admin_service/admin_inquiryNo.do?page=${(nowPageGroupN-2)*pageGroupSize+1 }&pageSize=${pageSize}"/>">
			  이전
			</a>
	      </li>
        </c:if>
                    
	    <c:forEach var="i" begin="${startPage}" end="${endPage}">
		  <c:choose>
	        <c:when test="${param.page eq i }">
			  <li class="page-item active" aria-current="page">
			 	<a class="page-link" href="<c:url value="/project_ezen/admin_service/admin_inquiryNo.do?page=${i}&pageSize=${pageSize}"/>">				     
				  ${i} 
				</a>
			  </li>
			</c:when>
			<c:otherwise>
			  <li class="page-item">
				<a class="page-link" href="<c:url value="/project_ezen/admin_service/admin_inquiryNo.do?page=${i}&pageSize=${pageSize}"/>">				     
			      ${i} 
			    </a>
			  </li>
		    </c:otherwise>
		  </c:choose>
		</c:forEach>
		  
        <c:if test="${nowPageGroupN < pageGroupCountN}">
		  <li class="page-item">
		    <a class="page-link" href="<c:url value = "/project_ezen/admin_service/admin_inquiryNo.do?page=${nowPageGroupN*pageGroupSize+1}&pageSize=${pageSize}"/>">
		      다음
		    </a>
	      </li>
	    </c:if>
		  
	  </c:if>
    </ul>

    <%
    }
    %>
      
  </div>
  <!-- admin_inquiry 영역 끝 -->
  
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>

  <c:import url="/footer.jsp" />