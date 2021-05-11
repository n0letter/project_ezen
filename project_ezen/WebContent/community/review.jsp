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

  <c:import url="/header.jsp" />  
    
  <div class="mypage_header_img"></div>  
  
  <!-- 현재위치표시 영역 시작 -->    
  <div class="where">
    <a href="/project_ezen/main.do">H</a>
    <div>커뮤니티</div>
    <div>이용후기</div>
  </div>
  <!-- 현재위치표시 영역 끝 -->
  
  <!-- review 영역 시작 --> 
  <div class="review_wrap">
    
  <input type="hidden" name="member_idx" value="${member_idx}">
    
    <!-- 검색하기 -->     
    <div class="notice_wrap">
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
    </div> 
      
    <!-- 표 -->		
    <div class="review_table">
	  <table class="review_table_wrap">
	    <tr>
	      <th>번호</th>
	      <th class="reTitle">제목</th>
	      <th>작성자</th>
	      <th>작성일</th>
	      <th>조회수</th>          
	    </tr>
	    <c:forEach var="dto" items="${review_list}">
		  <tr onclick="location.href='/project_ezen/community/review_view.do?review_idx=${dto.review_idx}';" style="cursor:pointer;">
		    <td>${ dto.review_idx }</td>	
            <c:set var="r" value="${dto.review_reply_count}"/>
	          <c:choose>	
	            <c:when test="${ r == '0' }" >
		          <td class="reTitle">${ dto.review_title }</td>
		        </c:when>	
		        <c:otherwise >
		          <td>${ dto.review_title }<span>&nbsp;[${ dto.review_reply_count }]</span></td>
		        </c:otherwise>	
		      </c:choose>
			<td >${dto.review_name}</td>
			<fmt:formatDate value="${dto.review_date}" pattern="yyyy-MM-dd" var="reg" />
			<td>${reg}</td>
			<td>${dto.review_hit}</td>
		  </tr>
		</c:forEach>
	  </table>
    </div>
	  
	<!-- 페이징 처리 --> 
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
		    <a class="page-link" href="<c:url value = "/project_ezen/community/review.do?page=${(nowPageGroup-2)*pageGroupSize+1 }&pageSize=${pageSize}"/>">
		      이전
		    </a>
		  </li>
        </c:if>
		 
	    <c:forEach var="i" begin="${startPage}" end="${endPage}">
	      <c:choose>
            <c:when test="${param.page eq i }">
		  	  <li class="page-item active" aria-current="page">
			    <a class="page-link" href="<c:url value="/project_ezen/community/review.do?page=${i}&pageSize=${pageSize}"/>">				     
			      ${i} 
			    </a>
			  </li>
		    </c:when>
		    <c:otherwise>
		      <li class="page-item">
			    <a class="page-link" href="<c:url value="/project_ezen/community/review.do?page=${i}&pageSize=${pageSize}"/>">				     
			  	  ${i} 
			    </a>
			  </li>
		    </c:otherwise>
		  </c:choose>
	    </c:forEach>
	  
	    <c:if test="${nowPageGroup < pageGroupCount}">
	      <li class="page-item">
	        <a class="page-link" href="<c:url value = "/project_ezen/community/review.do?page=${nowPageGroup*pageGroupSize+1}&pageSize=${pageSize}"/>">
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
		    <a class="page-link" href="<c:url value = "/project_ezen/community/adReviewSearch.do?page=${(nowPageGroup-2)*pageGroupSize+1 }&pageSize=${pageSize}&keyword=${keyword}&ar_title=${ar_title}"/>">
		      이전
		    </a>
		  </li>
        </c:if>
		 
	    <c:forEach var="i" begin="${startPage}" end="${endPage}">
	      <c:choose>
            <c:when test="${param.page eq i }">
		  	  <li class="page-item active" aria-current="page">
			    <a class="page-link" href="<c:url value="/project_ezen/community/adReviewSearch.do?page=${i}&pageSize=${pageSize}&keyword=${keyword}&ar_title=${ar_title}"/>">				     
			      ${i} 
			    </a>
			  </li>
		    </c:when>
		    <c:otherwise>
		      <li class="page-item">
			    <a class="page-link" href="<c:url value="/project_ezen/community/adReviewSearch.do?page=${i}&pageSize=${pageSize}&keyword=${keyword}&ar_title=${ar_title}"/>">				     
			  	  ${i} 
			    </a>
			  </li>
		    </c:otherwise>
		  </c:choose>
	    </c:forEach>
	  
	    <c:if test="${nowPageGroup < pageGroupCount}">
	      <li class="page-item">
	        <a class="page-link" href="<c:url value = "/project_ezen/community/adReviewSearch.do?page=${nowPageGroup*pageGroupSize+1}&pageSize=${pageSize}&keyword=${keyword}&ar_title=${ar_title}"/>">
		      다음
		    </a>
	      </li>
	    </c:if>
	  
	  </c:if>
    </ul> 	     	
   	<%
   	}
   	%>
    <!-- 버튼 -->
	<input class="reListBtn" type="button" value="글쓰기" onclick="reviewcheck();" />
    
  </div>  
  <!-- review 영역 끝 -->    
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>   
  <!-- 유효성검사 --> 
  <script>
    function reviewcheck() { 	
      if(document.getElementsByName('member_idx')[0].value == "") {
	    var a = confirm("로그인후 이용가능합니다.")
	  	if(a == true){
	  	  location.href = "/project_ezen/member/loginForm.jsp";
	  	}else{
		  return false;
	  	}
	  }	
      if(document.getElementsByName('member_idx')[0].value != "") {
  	    location.href = "/project_ezen/community/review_write.jsp";
  	    return true;
	  } 	
    }
    function arSearch() {
  	  var frm = document.adReviewSearch;
  	  
  	  if(!frm.keyword.value) {
  		  alert("검색어를 입력해 주세요.")
  		  frm.keyword.focus();
  		  return false;  
  	  } 
    }  
  	 
    if(adReviewSearch.keyword.value != " ") {

		if (self.name != 'reload') {
		    self.name = 'reload';
		    self.location.reload(true);
		}
		else self.name = '';    	
    } 
  </script>
   
   
  <c:import url="/footer.jsp" />