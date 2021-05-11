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
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>결제 내역 보기</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
	<link rel="stylesheet" href="/project_ezen/css/adminMem_style.css">
	
	<style>
		* {
			margin: 0; padding: 0;	
		}
	</style>
</head>
<body>
<!-- 섹션 영역 시작 -->
	<div class="mv_popUp_wrap">
		<%
		String pay_name = (String)session.getAttribute("pay_name");
		String pay_member_idx = (String)session.getAttribute("pay_member_idx");
		System.out.println("팝업창 pay_member_idx:" + pay_member_idx);
		System.out.println("팝업창 pay_name:" + pay_name);
		%>
		<div class="">
        	<h4><small class="mv_title">▌</small>결제 내역 보기</h4><hr>
        </div>
        <div class="mvp_title">
        	<h4><small class="mv_title">▌</small>이름 : &nbsp;${pay_name}</h4>
        </div>
        <div class="mvp_table_wrap">
	        <table class="mv_popUp_table">
		        <tr>
		            <th class="mvp_t01">번호</th>
		            <th>주문일</th>
		            <th>주문 상품</th>
		            <th>결제 금액</th>
		            <th>결제 취소</th>
		        </tr>
		        <% int num=1; %> 
				<c:forEach var="dto" items="${ pay_list }" begin="0"  step="1" varStatus="status">
		          <form method="post" name="payDel" action="mv_popUp_delete.do" onsubmit="return deletecheck()">
		          <tr>
			          <td class="mvp_t01"><%= num %><% num = num + 1; %> </td>
			          <fmt:formatDate value="${dto.pay_payment_date}" pattern="yyyy-MM-dd" var="reg" />
			          <td>${ reg }</td>
			          <td class="mvp_t02">${dto.pay_membership}</td>
			          <td>${dto.pay_amount}</td>
		         	  <td><a><input type="submit" class="mvp_del" value="삭제" /></a></td>
		          	  <input type="hidden" name="payIdx" value="${dto.pay_idx}" />
		          	  <input type="hidden" name="pay_member_idx" value="${dto.pay_member_idx}" />
		          	  <input type="hidden" name="mem_name" value="${dto.pay_name}" />
		          </tr>
		          </form>
		        </c:forEach>
	        </table>
	        
			<input type="hidden" name="mv_pop" value="${pay_member_idx}" />
			<input type="hidden" name="mem_name" value="${pay_name}"/>
        	<ul class="pagination justify-content-center">
	        <c:if test="${mypay_num > 0}">
			  <!--페이지 개수  -->
			    <c:set var="pageCount" value="${mypay_num / pageSize + ( mypay_num % pageSize == 0 ? 0 : 1)}" />
			    <c:set var="startPage" value="${pageGroupSize*(nowPageGroup-1)+1}" />
			    <c:set var="endPage" value="${startPage + pageGroupSize-1}" />
			    <c:if test="${endPage > pageCount}">
			      <c:set var="endPage" value="${pageCount}" />
			    </c:if>
			 	
			    <c:if test="${nowPageGroup > 1}">
			      <li class="page-item">
			      	<a class="page-link" href="<c:url value = "admin_member/mv_popUp.do?page=${(nowPageGroup-2)*pageGroupSize+1 }&pageSize=${pageSize}&mv_pop=${pay_member_idx}&mem_name=${pay_name}"/>">
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
					    <a class="page-link" href="<c:url value="/admin_member/mv_popUp.do?page=${i}&pageSize=${pageSize}&mv_pop=${pay_member_idx}&mem_name=${pay_name}"/>">				     
					        ${i} 
					    </a>
				      </li>
			        </c:when>
			        <c:otherwise>
				      <li class="page-item">
					    <a class="page-link" href="<c:url value="/admin_member/mv_popUp.do?page=${i}&pageSize=${pageSize}&mv_pop=${pay_member_idx}&mem_name=${pay_name}"/>">				     
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
			        <a class="page-link" href="<c:url value = "/admin_member/mv_popUp.do?page=${nowPageGroup*pageGroupSize+1}&pageSize=${pageSize}&mv_pop=${pay_member_idx}&mem_name=${pay_name}"/>">
			        다음
			        </a>
			      </li>
			    </c:if>
			  </c:if>
	        </ul>	        
	    </div>
	    <button class="mvp_close" onclick="window.close();">닫기
	    	<a href="javascript:window.close();"></a>
	    </button>
    </div>
    <script>
    function deletecheck() {
    	/* frmM.memPay_delete.value = getElementsById('payIdx').value; */
    	var a = confirm("결제 내역을 삭제하시겠습니까?")
    	if(a == true){
    		
    	} else {
    		return false;
    		window.history.go(0);
    	}
		/* return false; */
    }    
    /* var url = window.location.href
	
	if (self.name != 'reload' ) {
	    self.name = 'reload';
	    self.location.reload(true);
	}
	else self.name = '';  */ 
    </script>
    
</body>
</html>
