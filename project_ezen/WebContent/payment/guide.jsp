<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

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
    <div>온라인 결제</div>
    <div>결제 안내</div>
  </div>
  <!-- 현재위치표시 영역 끝 -->
  
  <!-- guide 영역 시작 -->
  <div class="guide_wrap">
  
    <input type="hidden" name="member_idx" value="${member_idx}">
  
    <!-- 결제안내 -->
    <div class="guide_A">
      <h2><small class="payment_small">▌</small>온라인 결제 시 안내 사항</h2>
      <hr>
      <p>0. 온라인 결제 시 ‘입회비 3만원’이 면제 됩니다.</p>
      <p>1. 온라인 결제 후 반드시 결제한 날짜로부터 30일 내에 헬스장을 방문해 주세요.</p>
      <p>2. 일반회원권 또는 스페셜 회원권 이용 시 개인 사물함과 운동복 대여는 무료로 이용 가능합니다. <br>
        개인 사물함 번호와 열쇠는 헬스장 방문 시 지급해 드립니다.</p>
      <p>3. 퍼스널 트레이닝(P.T)은 온라인 결제가 불가능합니다. <br>
        헬스장방문 또는 온라인상담으로 문의 해주세요. </p>
      <p>4. 그룹 운동은 온라인 결제 후, 회원권 만료전까지 무료로 이용 가능합니다.</p>
      <p>5. 스페셜 회원권은 스페셜 프로그램 + 일반회원권 입니다. <br>
        따라서 일반회원권과 동시에 구매 할 수 없습니다. <br>
        스페셜 프로그램에 대한 자세한 설명은 홈페이지의 프로그램 소개를 참고해주세요.</p>
      <p>6. 스페셜 프로그램은 결제 후 다음 달 1일부터 이용가능 합니다.</p>
    </div>
    
    <!-- 이용절차+버튼 -->
    <div class="guide_B">
      <h2><small class="payment_small">▌</small>결제 후 이용절차</h2>
      <div class="guide_B_01">
        <div class="guide_Shape">
          <p>1</p>
        </div>
        <div class="guide_Shape">
          <p>2</p>
        </div>
        <div class="guide_Shape">
          <p>3</p>
        </div>
        <div class="guide_Shape">
          <p>4</p>
        </div>
      </div>
      <div class="guide_B_02">
        <span class="guide_B_text">상품 결제</span>
        <span class="guide_B_text">헬스장 방문</span>
        <span class="guide_B_text">구매 확정</span>
        <span class="guide_B_text">운동 시작</span>
      </div>     
      <input class="guide_btn" type="button" value="확인" onclick="guidecheck();"/>
    </div>

  </div>
  <!-- guide 영역 끝 -->
   <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span> 
  <!-- 유효성검사 -->
  <script>
    function guidecheck() { 	
      if(document.getElementsByName('member_idx')[0].value == "") {
    	var a = confirm("로그인후 이용가능합니다.")
    	if(a == true){
    	  location.href = "/project_ezen/member/loginForm.jsp";
    	}
		return false;
	  }	
      if(document.getElementsByName('member_idx')[0].value != "") {
    	location.href = "/project_ezen/payment/paychoice.do";
    	return true;
  	  }	
    }
  </script>
  

  <c:import url="/footer.jsp" />