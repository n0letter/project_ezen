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
String referer = request.getHeader("referer");
System.out.println("이전 주소" + referer); 
System.out.println("현재 주소:" + uri);
System.out.println("member_idx:" + member_idx);
System.out.println("member_id:" + member_id);
if(uri.indexOf("admin") != -1 && member_idx == null) {
	response.sendRedirect("/project_ezen/member/loginForm.jsp");
} else if(!member_id.equals("admin") ) {
	response.sendRedirect("/project_ezen/main.do");
} 
%>
	<div class="mypage_header_img">
    </div>
   	
<!-- 현재 위치 표시 -->
	<div class="where">
		<a href="/project_ezen/main.do">H</a>
		<div>회원 관리</div>
		<div>회원 목록</div>
	</div>

<!-- 섹션 영역 시작 -->
	<div class="memList_wrap">
		
    	<form class="ml_search_wrap" action="memList_search.do" 
    	name="ml_search" onsubmit="return mem_search()">
	        <div>
	        	<select name="ms_title" class="memList_select">
		            <option value="joinDay">가입일</option>
		            <option value="name">이름</option>
		            <option value="id">아이디</option>
	        	</select>
	        </div>
	        <div>
	        	<input type="text" name="keyword" value="${keyword }"
	        	placeholder="검색어를 입력하세요." class="ml_search_text">
	        </div>
	        <div>
	        	<input type="submit" class="ml_search_btn" value="검색">
	        </div>
	        <input type="hidden" name="page" value="1">
    	</form>
    	
    	<div class="ml_table_wrap" id="ml_general">
	        <table class="memList_table" id="ml_content">
	        	<thead>
			        <tr>
			            <th class="ml_t01">번호</th>
			            <th>가입일</th>
			            <th>이름</th>
			            <th>아이디</th>
			            <th>구매 금액</th>
			            <th>메일 수신 여부</th>
			        </tr>
		        </thead>
		       
		        <tbody>
		        	
		        	<%-- <c:if test="${fn:length(member_list) < 1} ">
			        
					</c:if> --%>
					
					<c:forEach var="dto" items="${ member_list }" begin="0" end="9" step="1" varStatus="status">
				        <tr onclick="location.href='/project_ezen/admin_member/member_view.do?mem_idx=${dto.member_idx}';" style="cursor:pointer;">
				          <td class="ml_t01">${dto.member_idx}</td>
				          <fmt:formatDate value="${dto.member_join_date}" pattern="yyyy-MM-dd" var="reg" />
				          <td>${ reg }</td>
				          <td class="ml_t02"><a href="/project_ezen/admin_member/member_view.do?mem_idx=${dto.member_idx}">${dto.member_name}</a></td>
				          <td>${dto.member_id}</td>
				          <td>${dto.member_pay_sum}원</td>
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
			        </c:forEach>
			        
	      		</tbody>
	        </table>
	        <%
        	int list_size = (Integer)request.getAttribute("size") == null? 2:(Integer)request.getAttribute("size");
	        int searchResult = (Integer)request.getAttribute("searchResult") == null? 0:(Integer)request.getAttribute("searchResult");
	        String keyword = (String)request.getAttribute("keyword") == null? "key":(String)request.getAttribute("keyword");
	        String ms_title = (String)request.getAttribute("ms_title") == null? "ms":(String)request.getAttribute("ms_title");
	        System.out.println("size:"+list_size);
	        System.out.println("searchResult:"+searchResult);
	        System.out.println("keyword:"+keyword);
	        System.out.println("ms_title:"+ms_title);
	        if(list_size == 0){
        	%>
        	<h4>검색 결과가 없습니다.</h4>
        	<% 
        	} else if(list_size != 0 && searchResult == 0) {
        	%>
        	<ul class="pagination justify-content-center">
	        <c:if test="${memberCount > 0}">
			  <!--페이지 개수  -->
			    <c:set var="pageCount" value="${memberCount / pageSize + ( memberCount % pageSize == 0 ? 0 : 1)}" />
			    <c:set var="startPage" value="${pageGroupSize*(nowPageGroup-1)+1}" />
			    <c:set var="endPage" value="${startPage + pageGroupSize-1}" />
			    <c:if test="${endPage > pageCount}">
			      <c:set var="endPage" value="${pageCount}" />
			    </c:if>
			 	
			    <c:if test="${nowPageGroup > 1}">
			      <li class="page-item">
			      	<a class="page-link" href="<c:url value = "/project_ezen/admin_member/member_list.do?page=${(nowPageGroup-2)*pageGroupSize+1 }&pageSize=${pageSize}"/>">
			      	이전
			      	</a>
			      </li>
			      <%-- <li class="page-item">
       				<a class="page-link" href="/project_ezen/admin_member/member_list.do?page=${param.page-1 }">
       				<
       				</a>
        		  </li> --%>
			    </c:if>
			 
			    <c:forEach var="i" begin="${startPage}" end="${endPage}">
			      <c:choose>
	        		<c:when test="${param.page eq i }">
				      <li class="page-item active" aria-current="page">
					    <a class="page-link" href="<c:url value="/project_ezen/admin_member/member_list.do?page=${i}&pageSize=${pageSize}"/>">				     
					        ${i} 
					    </a>
				      </li>
			        </c:when>
			        <c:otherwise>
				      <li class="page-item">
					    <a class="page-link" href="<c:url value="/project_ezen/admin_member/member_list.do?page=${i}&pageSize=${pageSize}"/>">				     
					        ${i} 
					    </a>
				     </li>
			        </c:otherwise>
			      </c:choose>
			    </c:forEach>
			    <c:if test="${nowPageGroup < pageGroupCount}">
			      <%-- <li class="page-item">
       				<a class="page-link" href="/project_ezen/admin_member/member_list.do?page=${param.page+1 }">
       				>
       				</a>
        		  </li> --%>
			      <li class="page-item">
			        <a class="page-link" href="<c:url value = "/project_ezen/admin_member/member_list.do?page=${nowPageGroup*pageGroupSize+1}&pageSize=${pageSize}"/>">
			        다음
			        </a>
			      </li>
			    </c:if>
			  </c:if>
	        </ul>
        	<%
        	} else if(list_size != 0 && searchResult == 1) {
        	%>	
	        <ul class="pagination justify-content-center">
	        <c:if test="${memberCount > 0}">
			  <!--페이지 개수  -->
			    <c:set var="pageCount" value="${memberCount / pageSize + ( memberCount % pageSize == 0 ? 0 : 1)}" />
			    <c:set var="startPage" value="${pageGroupSize*(nowPageGroup-1)+1}" />
			    <c:set var="endPage" value="${startPage + pageGroupSize-1}" />
			    <c:if test="${endPage > pageCount}">
			      <c:set var="endPage" value="${pageCount}" />
			    </c:if>
			 	
			    <c:if test="${nowPageGroup > 1}">
			      <li class="page-item">
			      	<a class="page-link" href="<c:url value = "/project_ezen/admin_member/memList_search.do?page=${(nowPageGroup-2)*pageGroupSize+1 }&pageSize=${pageSize}&keyword=${keyword}&ms_title=${ms_title}"/>">
			      	이전
			      	</a>
			      </li>
			      <%-- <li class="page-item">
       				<a class="page-link" href="/project_ezen/admin_member/memList_search.do?page=${param.page-1 }">
       				<
       				</a>
        		  </li> --%>
			    </c:if>
			 
			    <c:forEach var="i" begin="${startPage}" end="${endPage}">
			      <c:choose>
	        		<c:when test="${param.page eq i }">
				      <li class="page-item active" aria-current="page">
					    <a class="page-link" href="<c:url value="/project_ezen/admin_member/memList_search.do?page=${i}&pageSize=${pageSize}&keyword=${keyword}&ms_title=${ms_title}"/>">				     
					        ${i} 
					    </a>
				      </li>
			        </c:when>
			        <c:otherwise>
				      <li class="page-item">
					    <a class="page-link" href="<c:url value="/project_ezen/admin_member/memList_search.do?page=${i}&pageSize=${pageSize}&keyword=${keyword}&ms_title=${ms_title}"/>">				     
					        ${i} 
					    </a>
				     </li>
			        </c:otherwise>
			      </c:choose>
			    </c:forEach>
			    <c:if test="${nowPageGroup < pageGroupCount}">
			      <%-- <li class="page-item">
       				<a class="page-link" href="/project_ezen/admin_member/memList_search.do?page=${param.page+1 }">
       				>
       				</a>
        		  </li> --%>
			      <li class="page-item">
			        <a class="page-link" href="<c:url value = "/project_ezen/admin_member/memList_search.do?page=${nowPageGroup*pageGroupSize+1}&pageSize=${pageSize}&keyword=${keyword}&ms_title=${ms_title}"/>">
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
	</div>
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>
<!-- 섹션 영역 끝 -->

  <script>
  function mem_search() {
	  var frm = document.ml_search;
	  
	  if(!frm.keyword.value) {
		  alert("검색어를 입력해 주세요.")
		  frm.keyword.focus();
		  return false;  
	  } 
	  /* if(frm.ms_title.value == "joinDay") {
		  if(!/^[0-9]{8}$/.test(frm.keyword.value)) {
			  	alert("숫자8자리, 날짜 형식으로 입력하세요. 예)20200303")
			  	frm.keyword.focus();
				return false;  
	      }
	  	  
	  } */
	  
  }
  

  </script>    


	<c:import url="/footer.jsp" />	