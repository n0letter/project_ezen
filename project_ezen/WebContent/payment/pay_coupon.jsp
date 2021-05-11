<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
  <link rel="stylesheet" href="/project_ezen/css/payment_style.css">
  <style>
  * {
    margin: 0; padding: 0;	
  }
  </style>
</head>
<body>
  <!-- pay_coupon 영역 시작 -->
  <div class="pcoupon_wrap">  
      
       <input type="hidden" name="choice_amount" value="${choice_amount}"/>
       
       <input type="hidden" id="coupon_amount" name="coupon_amount">
       <input type="hidden" id="pay_amount" name="pay_amount"/>
       <input type="hidden" id="pay_coupon" name="pay_coupon" value="0"/>
       
      <div>
        <h3><small class="payment_small">▌</small>보유중인 쿠폰</h3> <hr>
      </div>
    
      <!-- 쿠폰내용 -->
      <c:set var="c01" value="${member_coupon01}"/>
      <c:set var="c02" value="${member_coupon02}"/>
	    <c:choose>
		  <c:when test="${ c01 == '0' && c02 == '0' }" >
		    보유중인 쿠폰이 없습니다.
		  </c:when>
		  <c:when test="${ c01 > '0' && c02 == '0'}">
		    <input class="pcoupon" id="eventA" type="radio" name="pay_coupon" value="10" onclick="event01();">1주년 감사 이벤트 쿠폰 (10% 할인권)
		  </c:when>
		  <c:when test="${ c01 == '0' && c02 > '0'}">
		    <input class="pcoupon" id="eventB" type="radio" name="pay_coupon" value="10000" onclick="event02();">이용후기 이벤트 쿠폰 (10,000원 할인권)
		  </c:when>  
		  <c:when test="${ c01 > '0' && c02 > '0'}">
            <input class="pcoupon" id="eventA" type="radio" name="pay_coupon" value="10" onclick="event01();">1주년 감사 이벤트 쿠폰 (10% 할인권) <br>
		    <input class="pcoupon" id="eventB" type="radio" name="pay_coupon" value="10000" onclick="event02();">이용후기 이벤트 쿠폰 (10,000원 할인권) 
		  </c:when>  
	    </c:choose>
	    
	  <!-- 버튼 -->  
	  <div class="pcoupon_buttons">
	    <input class="pcoupon_sub" type="button" value="쿠폰 적용" onclick="pcouponcheck();"/>
        <input class="pcoupon_but" type="button" value="적용 안 함" onclick="pcouponout();"/>
	  </div>

  </div>
  <!-- pay_coupon 영역 끝 -->
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>  
  <!-- 1주년쿠폰 -->
  <script>
    function event01() {
      var originPrice =   document.getElementsByName('choice_amount')[0].value;      
      var discountRate = document.querySelector('#eventA').value;
          
      var discounted = Math.round(originPrice * (discountRate / 100));
      var newPrice = originPrice - discounted;
       
      var pay_coupon = 1;
      
      document.getElementsByName('coupon_amount')[0].value = discounted;
      document.getElementsByName('pay_amount')[0].value = newPrice;
      document.getElementsByName('pay_coupon')[0].value = pay_coupon;
    } 
  </script>
  
  <!-- 할인률계산 -->
  <script>
    function event02() {
      var originPrice =   document.getElementsByName('choice_amount')[0].value; 
      var discountRate = document.querySelector('#eventB').value;
      
      var discounted = 10000;
      var newPrice = originPrice - discounted;
      
      var pay_coupon = 2;
      
      document.getElementsByName('coupon_amount')[0].value = discounted;
      document.getElementsByName('pay_amount')[0].value = newPrice;
      document.getElementsByName('pay_coupon')[0].value = pay_coupon;
    }
  </script>
  
  <!-- 쿠폰적용취소 -->
  <script>
    function pcouponout() {    	
      window.opener.document.getElementById("coupon_amount").value = "0"; 
      window.opener.document.getElementById("pay_amount").value = document.getElementsByName('choice_amount')[0].value;
      window.opener.document.getElementById("pay_coupon_num").value = "0";  
      window.close();
	}
  </script>  
  
  <!-- 유효성검사 -->
  <script>
    function pcouponcheck() {    	
      if(document.getElementsByName('pay_amount')[0].value == "" ) {
        alert('사용할 쿠폰을 선택해주세요.');
        return false;
      }else if(document.getElementsByName('pay_amount')[0].value != "") {
        window.opener.document.getElementById("coupon_amount").value = document.getElementsByName('coupon_amount')[0].value; 
        window.opener.document.getElementById("pay_amount").value = document.getElementsByName('pay_amount')[0].value;  
        window.opener.document.getElementById("pay_coupon_num").value = document.getElementsByName('pay_coupon')[0].value;  
        window.close();
      }
	}
  </script>  
</body>
</html>