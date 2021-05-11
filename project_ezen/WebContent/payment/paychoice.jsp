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
    <div>결제상품 선택</div>
  </div>
  <!-- 현재위치표시 영역 끝 -->
  
  <!-- choice 영역 시작 --> 
  <div class="choice_wrap">
  
    <!-- 상품선택 -->
    <form class="choiceform" name="choiceform" action="choiceform.do" method="post" onsubmit="return choicecheck()">
     
     <input type="hidden" name="pay_start_dateB"/>
     <input type="hidden" name="pay_end_dateB"/>
     <input type="hidden" name="pay_end_dateA"/> 
     
      <div class="choice">
        <div class="choice_title">
          <h4><small class="payment_small">▌</small>결제상품 선택</h4> <hr>
        </div>
        <div class="choice_A">
          <img class="choice_img_A" src="/project_ezen/img/payment_image/choice01.png">
          <div class=choice_side_A>
            <h6 class="choice_side_A_text_A"><small class="payment_small">▌</small>일반 회원권 선택</h6>
            <select class="choice_select_A" id="choice_select_A" name="pay_membership01" onChange="getSelectValueA(this.form);" onclick="handleOnChangeA(this)">
              <option value=""></option>
              <option value="50000">일반 회원권 1개월</option>
              <option value="130000">일반 회원권 3개월</option>
              <option value="220000">일반 회원권 6개월</option>
              <option value="370000">일반 회원권 12개월</option>
            </select>
            <h6 class="choice_side_A_text_B">시작일 선택 (30일 이내)</h6>
            시작일 : &nbsp;<input id="choice_date" name="pay_start_dateA" type="text" class="DatePicker" placeholder="선택하기" onchange="payend_date();">
          </div>
        </div>
        <div class="choice_A_guide">
          <p><small>●</small> 일반회원권의 종류는 총 4가지(1개월,3개월,6개월,12개월)입니다.</p>
          <p><small>●</small> 일반회원권 이용기간동안 개인 사물함과 운동복대여는 무료로 이용가능 합니다.</p>
          <p class="choice_A_guide_bold"><small>●</small> 시작일은 반드시 결제일로부터 30일 이내로 결정해야합니다.</p>
          <p><small>●</small> 부득이한 사정으로 지정한 시작일에 방문하지 못할 경우, 헬스장으로 전화해주세요</p>
          <p class="choice_A_guide_bold"><small>●</small> 결제일로부터 30일이 지나도 헬스장에 방문하지 않으면, 결제한 일반회원권은 소멸됩니다.</p>
        </div>
        <hr class="choice_hr">
        <div class="choice_B">
      	  <img class="choice_img_B" src="/project_ezen/img/payment_image/choice02.jpg">
          <div class=choice_side_B>
            <h6 class="choice_side_B_text_B"><small class="payment_small">▌</small>스페셜 회원권 선택</h6>
            <select class="choice_select_B" id="choice_select_B" onclick="payend_dateB();" onChange="getSelectValueB(this.form);" onblur="handleOnChangeB(this)">
              <option value=""></option>
              <option value="400000">스페셜 회원권-그룹PT</option>
              <option value="450000">스페셜 회원권-필라테스</option>
              <option value="560000">스페셜 회원권-골프</option>
            </select>
          </div>
        </div>
        <div class="choice_B_guide">
          <p><small>●</small> 스페셜 회원권의 종류는 총 3가지(그룹PT,골프,필라테스)입니다.</p>
          <p class="choice_B_guide_bold"><small>●</small> 스페셜 회원권은 스페셜 프로그램 + 일반회원권을 말합니다. <br>
            &nbsp;&nbsp; (지정된 프로그램 시간외에도 이용기간동안 언제든지 헬스장사용이 가능합니다. </p>
          <p class="choice_B_guide_bold"><small>●</small> 스페셜 회원권의 이용기간은 3개월이며, 결제 후 다음달 1일부터 이용가능 합니다.</p>
          <p><small>●</small> 스페셜 회원권 이용기간동안 개인 사물함과 운동복대여는 무료로 이용가능 합니다.</p>
          <p><small>●</small> 스페셜 프로그램에 대한 자세한일정은 [프로그램>시간표]를 확인해주세요.</p>
          <p class="choice_B_guide_bold"><small>●</small> 결제 후. 방문여부와 상관없이 다음달 1일부터 스페셜 회원권은 자동시작 됩니다. <br>
            &nbsp;&nbsp; 주의해주세요.</p>
        </div>
        <hr>
      </div>
      <div class="choice_amount">
        <div class="choice_amount_A">
          <h5 class="choice_amount_title"><small class="payment_small">▌</small>결제 정보</h5>
          <div class=choice_amount_text>
            <div class="choice_amount_A-01">
              <p>총 상품 금액</p>
              <div>
                <input class="optionValue" type="text" name="optionValue" placeholder="0" readonly>원
              </div>
            </div>
            <div class="choice_amount_A-01">
              <p>배송비</p>
              <p>+0 원</p>
            </div>
          </div>
          <div class="choice_amount_A-02">
            <span>결제예정금액</span>
            <div>
              <input class="pay_amount" type="text" name="choice_amount" placeholder="0" readonly>
              <span>원</span>
            </div>
          </div>
        </div>
        <input class="choice_btn" type="submit" name="choice_btn" value="결제하기"/>
        <input class="hidden" type="text" name='pay_membershipA' readonly/> 
        <input class="hidden" type="text" name='pay_membershipB' readonly/>
      </div>
    </form>
    
  </div> 
  <!-- choice 영역 끝 -->
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>  
  <!-- 금액표시 -->
  <script>
  function getSelectValueA(frm)
  {
   frm.optionValue.value = frm.choice_select_A.options[frm.choice_select_A.selectedIndex].value;
   frm.choice_amount.value = frm.choice_select_A.options[frm.choice_select_A.selectedIndex].value;
  }
  
  function getSelectValueB(frm)
  {
   frm.optionValue.value = frm.choice_select_B.options[frm.choice_select_B.selectedIndex].value;
   frm.choice_amount.value = frm.choice_select_B.options[frm.choice_select_B.selectedIndex].value;
  }
  </script>
  
  <!-- 텍스트표시 -->
  <script>
  function handleOnChangeA(e) {
    const textA = e.options[e.selectedIndex].text;
	
    document.getElementsByName('pay_membershipA')[0].value = textA;
  }  
  function handleOnChangeB(e) {
	const textB = e.options[e.selectedIndex].text;	 
	  
	document.getElementsByName('pay_membershipB')[0].value = textB;
   }  
  </script>
  
  <!-- select중복선택 -->
  <script>
    const selectA = document.getElementById("choice_select_A");
    const selectB = document.getElementById('choice_select_B');
    const choice_date = document.getElementById('choice_date');

    selectA.addEventListener("change", (event) => {
      const elementA = event.target;
      const valueA = elementA.options[elementA.selectedIndex].value;

      if (valueA === "50000" || valueA === "130000" || valueA === "220000" || valueA === "370000") {
        selectB.disabled = true;
        choice_date.disabled = false;

      } else {
    	selectB.disabled = false;
    	choice_date.disabled = true;
      }   
    });
    
    selectB.addEventListener("change", (event) => {
      const elementB = event.target;
      const valueB = elementB.options[elementB.selectedIndex].value;

      if (valueB === "400000" || valueB === "450000" || valueB === "560000") {
        selectA.disabled = true;
      } else {
        selectA.disabled = false;
      }   
    });
  </script>
  
  <!-- 일반회원권 시작일 -->
  <script>
    $(function(){
      $(".DatePicker").datepicker({
        dateFormat: 'yy-mm-dd',
        showOn: "both",
        buttonImage: "/project_ezen/img/payment_image/paydate.PNG",
        buttonImageOnly: true,
        minDate: 0,
        maxDate: "+1M",
        monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        dayNamesMin: ['일','월','화','수','목','금','토'],
        dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
        showMonthAfterYear:true,
        yearSuffix: "년",
        prevText: '이전 달',
        nextText: '다음 달',
        buttonText: "시작일선택"     
      });
      $(".DatePicker").attr('disabled', 'disabled');
      $(".DatePicker").attr('readonly', 'readonly');
    });
  </script>
    
  <!-- 일반회원권 만료일 -->
  <script>
    function payend_date(){
      var userDate = document.getElementsByName('pay_start_dateA')[0].value;
	  var yy = userDate.substr(0,4);
	  var mm = userDate.substr(5,2);
	  var dd = userDate.substr(8,2);
	  var d = new Date();
	  mm--;
	  
	  d.setFullYear(yy);
	  d.setMonth(mm);
	  d.setDate(dd);
	  
	  var m_time = d.getMonth();
	  
	  var A = document.getElementById('choice_select_A').value; 
	  if(A === "50000") {
	    var add_days = 1;		  
	  }else if(A === "130000"){
	    var add_days = 3;  
	  }else if(A === "220000"){
	    var add_days = 6;  
	  }else if(A === "370000"){
	    var add_days = 12;  
	  }else if(A === " ") {
		var add_days = 0;   
	  }

	  var new_time = m_time + add_days; 
	  
	  d.setMonth(new_time);
	  yy = d.getFullYear();
	  mm = d.getMonth() +1;
	  dd = d.getDate() -1;

	  if(mm.toString().length < 2){
	   mm = "0" + mm;
	  }

	  document.getElementsByName('pay_end_dateA')[0].value = yy + "-" + mm + "-" + (dd<10? "0"+dd:dd);
    }
  </script>
  
  <!-- 스페셜회원권 시작일/만료일 -->
  <script>
    function payend_dateB(){
      var date    = new Date();
      var year    = date.getFullYear();
      var yearA    = date.getFullYear();
      var month   = date.getMonth() + 1;
      var day = "";
      
      month = month+1;
	  if(month > 12){
	    year++;
	    month = month-12;
	  }
	  
	  var monthA = (month+2);
	  if(monthA > 12){
		yearA++;
		monthA = monthA-12;
	  }
      
      if(monthA == "1" || monthA == "3" || monthA == "5"|| monthA == "7" || monthA == "8" || monthA == "10" || monthA == "12") {
        day = 31;
      }else if(monthA == "2"){
        if(parseInt(yearA)%4 == 0 && parseInt(yearA)%100 != 0){
          day = "29";
    	}else if(parseInt(yearA)%400 == 0){
          day = "29";
    	}else{
    	  day = "28";
    	}
      }else{
        day = "30";
      }
      
      document.getElementsByName('pay_start_dateB')[0].value = year+"-" +(month<10? "0"+month:month)+ "-"+"01";
      document.getElementsByName('pay_end_dateB')[0].value = yearA+"-" +(monthA<10? "0"+monthA:monthA)+ "-"+day;
    }  
  </script>
  
  <!-- 유효성검사 -->
  <script>
    function choicecheck() {
      var c = document.choiceform;
    	
      if(c.choice_amount.value == "" ) {
        alert('결제할 상품이 없습니다.');
        c.choice_amount.focus();
        return false;
      }
      if(c.pay_membership01.value != "" && c.pay_start_dateA.value == "" && c.pay_end_dateA.value == "" ) {
        alert('일반회원권의 시작일을 선택해주세요.');
        c.choice_amount.focus();
        return false;
      }
	}
  </script>
  

  <c:import url="/footer.jsp" />