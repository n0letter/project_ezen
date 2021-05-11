<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
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
  } else if(!member_id.equals("admin")) {
	response.sendRedirect("/project_ezen/main.do");
  }
  %>
  
  <div class="mypage_header_img"></div>  
  
  <!-- 현재위치표시 영역 시작 -->    
  <div class="where">
    <a href="/project_ezen/main.do">H</a>
    <div>결제관리</div>
    <div>결제내역</div>
    <div>일반 회원권</div>
  </div>
  <!-- 현재위치표시 영역 끝 -->
  
  <!-- general 영역 시작 -->
  <div class="paygenral_wrap">
  
    <!-- 상단타이틀+버튼 -->
    <div class="paygenral_title">
  	  <h4><small class="adminPay_small">▌</small>일반 회원권 결제관리</h4>
  	</div>
  	
  	<!-- 표 -->
    <div class="paygenral_table"> 	        
      <table class="paygenral_table_wrap" id="general_content">
        <tr>
          <th>번호</th>
          <th>결제일시</th>
          <th>아이디</th>
          <th>고객명</th>
          <th>결제상품</th>
          <th>시작일</th>
          <th>만료일</th>
          <th>쿠폰사용</th>
          <th>결제금액</th>
        </tr>
        <% int num=1; %> 
	    <c:forEach var="dto" begin="0" step="1" items="${ admingpay_list }"> 
          <tr>
            <td><%= num %><% num=num+1; %></td> 
            <fmt:formatDate value="${dto.pay_payment_date}" pattern="yyyy-MM-dd" var="pdate" />
            <td>${pdate}</td>
            <td>${dto.pay_id}</td>
            <td>${dto.pay_name}</td>
            <td class="paylist_mem">${dto.pay_membership}</td>
            <td>${dto.pay_start_date}</td>
		    <td>${dto.pay_end_date}</td>
            <td>
              <c:set var="pc" value="${dto.pay_coupon_num}"/>
			    <c:choose>
				  <c:when test="${ pc eq '0' }">
				    ${fn:replace(pc, 0, "미사용")}
				  </c:when>
				  <c:when test="${ pc eq '1' }">
				    ${fn:replace(pc, 1, "1주년 쿠폰")}
				  </c:when>
				  <c:otherwise>
					${fn:replace(pc, 2, "후기 이벤트 쿠폰")}
				  </c:otherwise>
				</c:choose>
            </td>
            <td>${dto.pay_amount}원</td>
          </tr>
        </c:forEach>
      </table> 	
    </div>
    
    <!--페이징 처리 -->
    <ul class="pagination justify-content-center">
	  <c:if test="${paycount > 0}">
	  
	    <!--페이지 개수  -->
	    <c:set var="pageCount" value="${paycount / pageSize + ( paycount % pageSize == 0 ? 0 : 1)}"/>
	    <c:set var="startPage" value="${pageGroupSize*(nowPageGroup-1)+1}" />
		<c:set var="endPage" value="${startPage + pageGroupSize-1}" />	
		<c:if test="${endPage > pageCount}">
		  <c:set var="endPage" value="${pageCount}" />
    	</c:if>		
    	 
		<c:if test="${nowPageGroup > 1}">
		  <li class="page-item">
			<a class="page-link" href="<c:url value = "/project_ezen/admin_payment/admin_general.do?page=${(nowPageGroup-2)*pageGroupSize+1 }&pageSize=${pageSize}"/>">
			  이전
			</a>
	      </li>
        </c:if>
          
	    <c:forEach var="i" begin="${startPage}" end="${endPage}">
		  <c:choose>
	        <c:when test="${param.page eq i }">
			  <li class="page-item active" aria-current="page">
				<a class="page-link" href="<c:url value="/project_ezen/admin_payment/admin_general.do?page=${i}&pageSize=${pageSize}"/>">				     
				  ${i} 
				</a>
			  </li>
			</c:when>
			<c:otherwise>
			  <li class="page-item">
				<a class="page-link" href="<c:url value="/project_ezen/admin_payment/admin_general.do?page=${i}&pageSize=${pageSize}"/>">				     
			      ${i} 
			    </a>
			  </li>
			</c:otherwise>
		  </c:choose>
		</c:forEach>
		  
        <c:if test="${nowPageGroup < pageGroupCount}">
		  <li class="page-item">
		    <a class="page-link" href="<c:url value = "/project_ezen/admin_payment/admin_general.do?page=${nowPageGroup*pageGroupSize+1}&pageSize=${pageSize}"/>">
		      다음
		    </a>
	      </li>
	    </c:if>
		  
	  </c:if>
    </ul>
    
    <!-- 목록버튼 -->
    <input type="button" class="pcbtn" value="목록" onClick="location.href='/project_ezen/admin_payment/admin_paymain.do'"/>    	
      
  </div>
  <!-- general 영역 끝 -->
  
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>

  <c:import url="/footer.jsp" />