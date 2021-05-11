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
  
  <%
  String member_idx = (String)session.getAttribute("member_idx");
  String uri = request.getRequestURI();
  System.out.println("현재 주소:" + uri);
  System.out.println("member_idx:" + member_idx);
  if(uri.indexOf("pay") != -1 && member_idx == null) {
	response.sendRedirect("/project_ezen/member/loginForm.jsp");
  }
  %> 
    
  <div class="mypage_header_img"></div>  
  
  <!-- 현재위치표시 영역 시작 -->    
  <div class="where">
    <a href="/project_ezen/main.do">H</a>
    <div>온라인 결제</div>
    <div>결제</div>
  </div>
  <!-- 현재위치표시 영역 끝 -->
  
  <body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="pay.jsp">
  
  <!-- pay 영역 시작 --> 
  <div class="pay_wrap">
  
  	<div class="pay_title">
  	  <h4><small class="payment_small">▌</small>결제하기</h4> <hr>
  	</div>
  	
  	<form class="payform" name="payform" action="pay.do" method="post" onsubmit="return paycheck()">
  	
      <%  
	    String pay_membership = (String)session.getAttribute("pay_membership");
        String choice_amount = (String)session.getAttribute("choice_amount");
        String pay_start_date = (String)session.getAttribute("pay_start_date");
        String pay_end_date = (String)session.getAttribute("pay_end_date");
        String coupon_amount = (String)session.getAttribute("coupon_amount");
        String pay_amount = (String)session.getAttribute("pay_amount");
    
        System.out.println("pay_membership : "+ pay_membership);	  
	    System.out.println("choice_amount : "+ choice_amount);
        System.out.println("pay_start_date : "+ pay_start_date);
	    System.out.println("pay_end_date : "+ pay_end_date);
	    System.out.println("coupon_amount : "+ coupon_amount);
	    System.out.println("pay_amount : "+ pay_amount);
	  %> 
	  
	  <input type="hidden" name="pay_coupon_num" id="pay_coupon_num" value="0"/>
	  <input type="hidden" name="pay_member_idx" value="${member_idx}"/>
	  
  	  <!-- 회원정보 --> 
      <div class="pay_A">
    
        <div class="pay_A_title">
          <h5><small class="payment_small">▌</small>회원정보 확인</h5>
          <input class="pay_btnA" type="button" value="회원정보 수정" onClick="location.href='/project_ezen/mypage/mypage_modify.do?member_idx=${member_idx}'"/>
        </div>
       
        <div class="pay_A_table">
          <table>
            <tr>
              <th>아이디</th>
              <td>
                <input type="text" class="paytext" name="pay_id" value="${member_id}" readonly>
              </td>
            </tr>
            <tr>
              <th>이름</th>
              <td>
                <input type="text" class="paytext" name="pay_name" value="${member_name}" readonly>
              </td>
            </tr>
            <tr>
              <th>연락처</th>
              <td>
                <input type="text" class="paytext" value="${member_phone}" readonly>
              </td>
            </tr>
            <tr>
              <th>이메일</th>
              <td>
                <input type="text" class="paytext" value="${member_email}" readonly>
              </td>
            </tr>
          </table>
        </div>
      
      </div>
    
      <!-- 결제하기+버튼 --> 
      <h5 class="pay_B_title"><small class="payment_small">▌</small>결제금액 확인 및 결제수단 선택</h5>
      
      <div class="pay_B">	
        <table>
          <tr>
            <th>결제 상품</th>
  		    <td>
  		      <input name="pay_membership" type="text" class="paytext" value="${pay_membership}" readonly>
  		    </td>
          </tr>
          <tr>
            <th>시작일</th>
            <td>
              <input name="pay_start_date" type="text" class="paytext" value="${pay_start_date}" readonly>
            </td>
          </tr>  
          <tr>  
            <th>종료일</th>
            <td>
              <input name="pay_end_date" type="text" class="paytext" value="${pay_end_date}" readonly>
            </td>
          </tr>
          <tr>
            <th>총 상품 금액</th>
            <td>
              <input name="choice_amount" type="text" class="payamount" value="${choice_amount}" readonly>
              <lable>원</lable>
            </td>
          </tr>
          <tr>
            <th>쿠폰 사용</th>
            <td>
              <lable>-</lable>
              <input name="coupon_amount" id="coupon_amount" type="text" class="pay_coupon" placeholder="0" readonly>         
              <input class="pay_coupon_btn" type="button"  onclick="pay_coupon()" value="쿠폰선택" />
            </td>
          </tr>
          <tr>
            <th>총 결제 금액</th>
            <td>
              <input name="pay_amount" id="pay_amount" type="text" class="payamount" value="${choice_amount}"readonly>
              <lable>원</lable>
            </td>
          </tr>
          <tr>
            <th>결제 수단</th>
            <td>
          	  <input class="pay_radio" type="radio" name="pay_radio" value="카드 결제" checked/>카드 결제 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <input class="pay_radio" type="radio" name="pay_radio" value="토스 결제">토스 결제 <br>
              <input class="pay_radio" type="radio" name="pay_radio" value="네이버페이 결제">네이버페이 결제 &nbsp;&nbsp;&nbsp;&nbsp;
              <input class="pay_radio" type="radio" name="pay_radio" value="카카오페이 결제">카카오페이 결제 <br>
              <input class="pay_radio" type="radio" name="pay_radio" value="페이코 결제">페이코 결제 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <input class="pay_radio" type="radio" name="pay_radio" value="휴대폰 결제">휴대폰 결제
            </td>
          </tr>
        </table>
        
        <div>
          <hr class="pay_hr">
          <input class="pay_btnB" type="submit"  value="결제하기"/>
          <input class="pay_btnC" type="button"  value="취소" onClick="paycancel()"/>
        </div>
      </div>
    </form>
  
  </div>
  <!-- pay 영역 끝 -->
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>  
  <!-- 취소버튼 되묻기 -->
  <script>
    function paycancel() {	
      var a = confirm("진행중인 결제를 취소하시겠습니까?")
      if(a == true){
        location.href = "/project_ezen/payment/paychoice.do";
      }
    }
  </script>
  
  <!-- 쿠폰함 -->
  <script>
    function pay_coupon(){  
      var url = "pay_coupon.jsp";
	  var title = "pay_coupon";
	  var status = "top=200, left=500, width=440, height=175, toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no";
	  window.open(url, title, status);
    }
  </script>
  
  <!-- 유효성검사 -->
  <script>
    function paycheck() {
      var a = confirm("결제하시겠습니까?")
      if(a == true){
        payform.submit();
      }
      return false;
	}
  </script>
  
  <!-- 다시실행막기 -->
  <script>
     window.history.forward();
     
     function noBack(){
       window.history.forward();
     }
  </script>


  <c:import url="/footer.jsp" />