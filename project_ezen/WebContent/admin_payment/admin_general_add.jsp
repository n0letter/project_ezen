<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
  
  <!-- 현재위치표시 영역 시작 -->    
  <div class="where">
    <a href="/project_ezen/main.jsp">H</a>
    <div>결제관리</div>
    <div>결제내역</div>
    <div>일반 회원권 추가</div>
  </div>
  <!-- 현재위치표시 영역 끝 -->
  
  <!-- general_add 영역 시작 -->
  <div class="genraladd_wrap">
  
    <!-- 상단타이틀 -->
    <div class="genraladd_title">
  	  <h4><small class="adminPay_small">▌</small>일반 회원권 결제내역 추가</h4>
  	</div>
  	 
  	<!-- 표 -->
  	<div class="genraladd_table">
      <form name="genralform" action="genral" method="post" onsubmit="checkgenral()">		
	    <table class="genraladd_table_wrap">	
	      <tr>      		
		    <th>번호</th>
		    <td>
		      <input class="gtext" type="text" name="gnum" maxlength="3" value="${generalnum}" readonly>
		    </td>
		  </tr>
		  <tr>      		
		    <th>유형</th>
		    <td>
		      <input class="gtext" type="text" name="paytype" value="현장" readonly>
		    </td>
		  </tr>	
		  <tr>      		
		    <th>결제일시</th>
		    <td>
		      <input class="gdate" type="date" name="gpaydate">
		    </td>
		  </tr>	
		  <tr>      		
		    <th>결제상품</th>
		    <td>
		      <select class="gselect" name="gselect">
			    <option value="">결제상품선택</option>
				<option value="50,000">일반회원권1개월</option>
				<option value="130,000">일반회원권3개월</option>
				<option value="220.000">일반회원권6개월</option>
				<option value="370,000">일반회원권12개월</option>
			  </select>
		    </td>
		  </tr>	
		  <tr>      		
		    <th>시작일</th>
		     <td>
		      <input class="gdate" type="date" name="gstart">
		    </td>
		  </tr>	
		  <tr>      		
		    <th>만료일</th>
		    <td>
		      <input class="gdate" type="text" name="gend" maxlength="15" value="년-월-일" readonly>
		    </td>
		  </tr>	
		  <tr>      		
		    <th>고객명</th>
		    <td>
			  <input class="gtext" type="text" name="gname" maxlength="10">
			</td>
		  </tr>	
		  <tr>      		
		    <th>쿠폰사용</th>
		    <td>
		     <span class="gspanA" >-</span>
		     <input class="gCoupon" type="text" name="gpayCoupon" placeholder="0" maxlength="10">
		     <span class="gspanB">원</span>
		    </td>
		  </tr>	
		  <tr>      	
		    <th>결제금액</th>
		    <td>
		     <input class="gtextA" type="text" name="gpaysum" maxlength="10" readonly>
		     <span class="gspanB">원</span>
		    </td>
		  </tr>		  	
	    </table>
	    <div class="gaddbuttons">
          <input class="gaddsub" type="submit" value="추가하기"/>
		  <a href="admin_general.jsp">
            <input class="gaddbtn" type="button" value="취소"/>
          </a>	
	    </div>
      </form>
    </div>
    
  </div>
  
  <!-- general_add 영역 끝 -->
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>  
  <script>
  function checkgenral(){
 
  }
  </script>
  

  <c:import url="/footer.jsp" />