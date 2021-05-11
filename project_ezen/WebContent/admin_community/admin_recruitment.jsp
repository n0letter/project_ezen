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
System.out.println("현재 주소:" + uri);
System.out.println("member_idx:" + member_idx);
if(uri.indexOf("admin") != -1 && member_idx == null) {
	response.sendRedirect("/project_ezen/member/loginForm.jsp");
} else if(!member_id.equals("admin")) {
	response.sendRedirect("/project_ezen/main.do");
}
%>

      <div class="mypage_header_img"></div>

<!-- 현재 위치 표시 -->
   <div class="where">
      <a href="/project_ezen/index.jsp">H</a>
      <div>관리자 커뮤니티</div>
      <div>채용안내</div>
   </div>
 

<div class="admin_recruitment_wrap">
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
		    <c:forEach var="dto" items="${recruitment_list}">
			  <tr onclick="location.href='/project_ezen/admin_community/admin_recruitment_view.do?recruitment_idx=${dto.recruitment_idx}';" style="cursor:pointer;">
			    <td>${ dto.recruitment_idx }</td>
			    <td class="adminReview_title">${ dto.recruitment_title }</td>
				<td>${dto.recruitment_name}</td>
				<fmt:formatDate value="${dto.recruitment_date}" pattern="yyyy-MM-dd" var="reg" />
				<td>${reg}</td>
				<td>${dto.recruitment_hit}</td>
			  </tr>
			</c:forEach>
		  </table>
	    </div>


<ul class="pagination justify-content-center">
	        <c:if test="${recruitmentCount > 0}">
			  <!--페이지 개수  -->
			    <c:set var="pageCount" value="${recruitmentCount / pageSize + ( recruitmentCount % pageSize == 0 ? 0 : 1)}" />
			    <c:set var="startPage" value="${pageGroupSize*(nowPageGroup-1)+1}" />
			    <c:set var="endPage" value="${startPage + pageGroupSize-1}" />
			    <c:if test="${endPage > pageCount}">
			      <c:set var="endPage" value="${pageCount}" />
			    </c:if>
			 
			    <c:if test="${nowPageGroup > 1}">
			      <li class="page-item">
			      	<a class="page-link" href="<c:url value = "/project_ezen/admin_community/admin_recruitment.do?page=${(nowPageGroup-2)*pageGroupSize+1 }&pageSize=${pageSize}"/>">
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
					    <a class="page-link" href="<c:url value="/project_ezen/admin_community/admin_recruitment.do?page=${i}&pageSize=${pageSize}"/>">				     
					        ${i} 
					    </a>
				      </li>
			        </c:when>
			        <c:otherwise>
				      <li class="page-item">
					    <a class="page-link" href="<c:url value="/project_ezen/admin_community/admin_recruitment.do?page=${i}&pageSize=${pageSize}"/>">				     
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
			        <a class="page-link" href="<c:url value = "/project_ezen/admin_community/admin_recruitment.do?page=${nowPageGroup*pageGroupSize+1}&pageSize=${pageSize}"/>">
			        다음
			        </a>
			      </li>
			    </c:if>
			  </c:if>

	        </ul>    


           <div class="notbuttons">
          <!-- <input class="notsub" type="submit" value="글쓰기"/> -->
		   <a href="/project_ezen/admin_community/admin_recruitment_write.jsp"> <input class="notsub" type="submit" value="글쓰기"></a>
		  </div>  
</div>
</div>

  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>

  <c:import url="/footer.jsp" />