<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
  </div>  
  <!-- 현재위치표시 영역 끝 -->
  
  <!-- paymain 영역 시작 -->
  <div class="paymain_wrap">
  
    <!-- 회원권 결제 한눈에 보기 -->
    <form class="paymainform" name="paymainform" action="paymainform.do" method="post">
      
      <%  
	    String generalnum = (String)session.getAttribute("generalnum");
        String specialnum = (String)session.getAttribute("specialnum");
        String generalmoney = (String)session.getAttribute("generalmoney");
        String specialmoney = (String)session.getAttribute("specialmoney");
	  %> 
      
      <div class="paymain_top">
        <h4 class="paymain_top_A"><small class="adminPay_small">▌</small>회원권 결제 한눈에 보기</h4>
        
        <!-- 결제 수 한눈에 보기 -->
        <div class="paymain_square">
          <span class="paymain_square_text">일반 회원권<br>총 결제 수</span>
          <span class="paymain_square_text">스페셜 회원권<br>총 결제 수</span>
          <span class="paymain_square_text_A">회원권<br>총 결제 수</span>
        </div>
        <div class="paymain_top_B">
          <div class="paymain_Shape">
            <input type="text" name="gnum" class="paymain_num" value="${generalnum}건" readonly>
          </div>   
          <div class="paymain_Shape_A">
            <span class="paymain_Symbol">+</span> 
          </div>
          <div class="paymain_Shape">    
            <input type="text" name="snum" class="paymain_num" value="${specialnum}건" readonly>
          </div>
          <div class="paymain_Shape_A">
            <span class="paymain_Symbol">=</span>
          </div>
          <div class="paymain_Shape_B">
            <input type="text" name="tnum" class="paymain_tnum" readonly>
          </div>
        </div>

        <!-- 결제 수 한눈에 보기 -->
        <div class="paymain_square">
          <span class="paymain_square_text">일반 회원권<br>총 결제 금액</span>
          <span class="paymain_square_text">스페셜 회원권<br>총 결제 금액</span>
          <span class="paymain_square_text_A">회원권<br>총 결제 금액</span>
        </div>
        <div class="paymain_top_B">
          <div class="paymain_Shape">
            <input type="text" name="gmoney" class="paymain_num" value="${generalmoney}원" readonly>
          </div>   
          <div class="paymain_Shape_A">
            <span class="paymain_Symbol">+</span> 
          </div>
          <div class="paymain_Shape">    
            <input type="text" name="smoney" class="paymain_num" value="${specialmoney}원" readonly>
          </div>
          <div class="paymain_Shape_A">
            <span class="paymain_Symbol">=</span>
          </div>
          <div class="paymain_Shape_B">
            <input type="text" name="tmoney" class="paymain_tnum" value="{00}건" readonly>
          </div>
        </div>
        
      </div>
     
    </form>
    
    <!-- 결제내역 보기+버튼 -->
    <div class="paymain_bottom">
      <div class="paymain_bottom_A">
        <h5>일반 회원권 결제내역</h5>
        <input class="paymain_btn" type="button" value="보기" onClick="location.href='/project_ezen/admin_payment/admin_general.do?page=1'"/>
      </div>
      <div class="paymain_bottom_B">
        <h5>스페셜 회원권 결제내역</h5>
        <input class="paymain_btn" type="button" value="보기" onClick="location.href='/project_ezen/admin_payment/admin_special.do?page=1'"/>
      </div>
    </div>  
    
  </div> 
  <!-- paymain 영역 끝 -->
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>  
  <!-- 총 결제수/총 결제금액 -->  
  <script> 
    var tnum = ${generalnum} + ${specialnum};
    var tmoney = ${generalmoney} + ${specialmoney};
    
    document.getElementsByName('tnum')[0].value = tnum + "건";
    document.getElementsByName('tmoney')[0].value = tmoney + "원";  
  </script> 
  

  <c:import url="/footer.jsp" />