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
    <div>스페셜 회원권 추가</div>
  </div>
  <!-- 현재위치표시 영역 끝 -->
  
  <!-- special_add 영역 시작 -->
  <div class="specialadd_wrap">
  
    <!-- 상단타이틀 -->
    <div class="specialadd_title">
  	  <h4><small class="adminPay_small">▌</small>스페셜 회원권 결제내역 추가</h4>
  	</div>
  	 
  	<!-- 표 -->
  	<div class="specialadd_table">
      <form>		
	    <table class="specialadd_table_wrap">	
	      <tr>      		
		    <th>번호</th>
		    <td>
		      <input class="stext" type="text" name="snum" maxlength="3" value="${specialnum}" readonly>
		    </td>
		  </tr>
		  <tr>      		
		    <th>유형</th>
		    <td>
		      <input class="stext" type="text" name="paytype" value="현장" readonly>
		    </td>
		  </tr>	
		  <tr>      		
		    <th>결제일시</th>
		    <td>
		      <input class="sdate" type="date" name="spaydate">
		    </td>
		  </tr>	
		  <tr>      		
		    <th>결제상품</th>
		    <td>
		      <select class="sselect" name="sselect">
			    <option value="">결제상품선택</option>
				<option value="400,000">스페셜회원권-그룹PT</option>
				<option value="450,000">스페셜회원권-골프</option>
				<option value="560.000">스페셜회원권-필라테스</option>
			  </select>
		    </td>
		  </tr>	
		  <tr>      		
		    <th>시작일</th>
		     <td>
		      <input class="sdate" type="text" name="sstart" maxlength="15" value="년-월-일" readonly>
		    </td>
		  </tr>	
		  <tr>      		
		    <th>만료일</th>
		    <td>
		      <input class="sdate" type="text" name="send" maxlength="15" value="년-월-일" readonly>
		    </td>
		  </tr>	
		  <tr>      		
		    <th>고객명</th>
		    <td>
			  <input class="stext" type="text" name="sname" maxlength="10">
			</td>
		  </tr>	
		  <tr>      		
		    <th>쿠폰사용</th>
		    <td>
		     <span class="sspanA" >-</span>
		     <input class="sCoupon" type="text" name="spayCoupon" placeholder="0" maxlength="10">
		     <span class="sspanB">원</span>
		    </td>
		  </tr>	
		  <tr>      	
		    <th>결제금액</th>
		    <td>
		     <input class="stextA" type="text" name="spaysum" maxlength="10" readonly>
		     <span class="sspanB">원</span>
		    </td>
		  </tr>		  	
	    </table>
	    <div class="saddbuttons">
          <input class="saddsub" type="submit" value="추가하기"/>
		  <a href="admin_special.jsp">
            <input class="saddbtn" type="button" value="취소"/>
          </a>	
	    </div>
      </form>
    </div>
    
  </div> 
  <!-- special_add 영역 끝 -->
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>  
  <script>

  </script>
  

  <c:import url="/footer.jsp" />