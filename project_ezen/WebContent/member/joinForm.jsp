<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
response.setHeader("Pragma", "no-cache"); //HTTP 1.0
response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
response.setDateHeader("Expires", 0L); // Do not cache in proxy server
%>
	<c:import url="/header.jsp" />
	
	<div class="mypage_header_img">
    </div>
	    
<!-- 현재 위치 표시 -->
	<div class="where">
		<a href="/project_ezen/main.do">H</a>
		<div>온라인 회원 가입</div>
	</div>

<!-- 섹션 영역 시작 -->
	<div class="join_wrap">
	
		<form name="frmJoin" method="post" action="JoinAction.do" onsubmit="return checkJoin()">
		<% 
			String check_agree = (String)session.getAttribute("check_agree");
			System.out.println("check_agree Y N : "+ check_agree);
		%> 
			<input type="hidden" name="member_agree" value="<%= check_agree %>">
			<input type="hidden" name="idDuplication" value="idUncheck" />
			<!-- <input type="hidden" id="inqRsn" name="inqRsn" value="10"> --> 
		
			<table class="join_table">
				<colgroup>
					<col width="16%">
					<col width="80%">
				</colgroup>
				<tbody>
					<tr>
						<th>아이디</th>
						<td>
							<input type="text" name="member_id" value="" size="20" maxlength="16" 
								style="ime-mode:inactive; width:35%;" id="member_id" onkeydown="inputIdChk()" /> 
							<a href="javascript:idCheck();" class="btn_join">ID 중복체크</a> 
							<span class="join_small">4~16자의 영문/숫자 가능 (공백은 입력불가)</span>
						</td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td>
							<input type="password" name="member_pw" value="" size="20" maxlength="16" 
							style="width:35%;"> &nbsp;
							<span class="join_small">영문/최소 1개의 숫자 또는 특수문자[8~16자리] </span>
						</td>
					</tr>
					<tr>
						<th>비밀번호 확인</th>
						<td>
							<input type="password" name="member_pw2" value="" size="20" maxlength="16" 
							style="width:35%;">
						</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>
							<input type="text" name="member_name" value="" size="20" maxlength="20" 
							style="ime-mode:active;width:35%;" id="join_name">
						</td>
					</tr>
			
					<tr>
						<th>생년월일/성별</th>
						<td class="join_date_wrap">
							<input type="text" name="member_birth_date" class="join_date DatePicker" value="1990-07-01" />&nbsp;&nbsp;&nbsp;&nbsp;
							<select name="member_gender" id="join_gender">
								<option value="M">남자</option>
								<option value="F">여자</option>
							</select>  
						</td>
					</tr>
					
					<tr>
						<th>휴대폰</th>
						<td>
							<select name="htel1" style="width:120px">
								<option value="">선택</option>
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
							</select>
							<span class="bar">-</span>
							<input type="text" name="htel2" value="" size="5" maxlength="4" 
								onkeyup="checkNumber(this);" style="width:10%">
							<span class="bar">-</span>
							<input type="text" name="htel3" value="" size="5" maxlength="4" 
								onkeyup="checkNumber(this);" style="width:10%">
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>
							<input type="text" name="member_email1" value="" size="15" maxlength="20" style="width:20%"> @ 
							<input type="text" name="member_email2" value="" size="15" maxlength="40" style="width:20%">
							&nbsp;
							<select name="email_tail" onchange="CheckEmail(this.value);" style="width:200px">
								<option value="">이메일선택</option>
								<option value="naver.com">naver.com</option>
								<option value="chol.com">chol.com</option>
								<option value="dreamwiz.com">dreamwiz.com</option>
								<option value="empal.com">empal.com</option>
								<option value="freechal.com">freechal.com</option>
								<option value="gmail.com">gmail.com</option>
								<option value="hanmail.net">hanmail.net</option>
								<option value="hanmir.com">hanmir.com</option>
								<option value="hotmail.com">hotmail.com</option>
								<option value="korea.com">korea.com</option>
								<option value="nate.com">nate.com</option>
								<option value="netian.com">netian.com</option>
								<option value="paran.com">paran.com</option>
								<option value="sayclub.com">sayclub.com</option>
								<option value="etc">직접입력</option>
							</select> <br>
							<span class="join_small">이메일 주소를 정확히 입력하시고 메일 수신에 동의하시면 예약 결과 및 이벤트 안내 메일과<br>
								생일, 결혼기념일 등 다양한 할인쿠폰 혜택을 빠르고 정확하게 받으실 수 있습니다. 
							</span>
						</td>
					</tr>
					<tr>
						<th>메일 수신여부</th>
						<td>
							<label for="gudoc1">
								<input type="radio" name="member_email_receive" id="gudoc1" value="1" checked=""> 예 
							</label> 
							<label for="gudoc2">
								<input type="radio" name="member_email_receive" id="gudoc2" value="0"> 아니오
							</label>
						</td>
					</tr>
					
				</tbody>
			</table>
		
			<div class="join_btnArea">
				<input type="submit" class="join_btn" value="회원가입" />
			</div>
		</form>
	</div>

  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>

  <script>
    $(function(){
      $(".DatePicker").datepicker({
        dateFormat: 'yy-mm-dd',
        changeYear: true, //콤보박스에서 년 선택 가능
        changeMonth: true, //콤보박스에서 월 선택 가능 
        showOn: "both",
        buttonImage: "/project_ezen/img/payment_image/paydate.PNG",
        buttonImageOnly: true,
        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        dayNamesMin: ['일','월','화','수','목','금','토'],
        dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
        showMonthAfterYear:true,
        /* yearSuffix: "년", */
        prevText: '이전 달',
        nextText: '다음 달',
        buttonText: "시작일선택"     
      });
      $(".DatePicker").attr('readonly', 'readonly');
    });
  </script>

	<script language="JavaScript">
		if (self.name != 'reload') {
		    self.name = 'reload';
		    self.location.reload(true);
		}
		else self.name = '';
	    function idCheck() {
			var user_id = $('#member_id').val();
			
			if(!user_id){
				alert("아이디를 입력하세요.");
				document.frmJoin.member_id.focus();
				return false;
			} 
			if ( !/^[A-Za-z0-9]{4,16}$/.test(document.frmJoin.member_id.value)) {
				alert("[아이디]는 4~16자의 영문/숫자만 입력가능합니다.");
				document.frmJoin.member_id.focus();
				return false;
			}
			// 아이디 유효성 검사(1 = 중복 / 0 != 중복)
			$.ajax({
	  			url : 'http://localhost:8081/project_ezen/idCheckAjax.do?member_id='+ user_id,
				type : 'get',
				success : function(dat) {
					console.log("1 = 중복됨, 0 = 중복안됨 : "+ dat);							
					
					if (dat === "1") {
						alert("아이디가 중복됩니다.");
						document.frmJoin.member_id.focus();
					} else {
						alert("사용가능한 아이디입니다.");
						document.frmJoin.idDuplication.value = "idCheck";
						document.frmJoin.member_pw.focus();
					}
				}, 
				error : function() {
						console.log("실패");
				}
			});
		} 
/* 아이디 중복 체크 후 중복되는 아이디로 바꾸는 것 방지, 체크 후 글자 쓰면 hidden 태그 value값:idCheck->idUncheck */
	    function inputIdChk() {
	    	document.frmJoin.idDuplication.value = "idUncheck";
	    }
	    
		function CheckEmail(mStr){
			var frm = document.frmJoin;
			if (mStr !== "etc") {
				frm.member_email2.readOnly = true;
				frm.member_email2.value = mStr;
			}
			else {
				frm.member_email2.value = "";
				frm.member_email2.readOnly = false;
				frm.member_email2.focus();
			}
		}
		
		function checkJoin(){
			var frm = document.frmJoin;
			
			if(frm.idDuplication.value != "idCheck") {
				alert("아이디 중복 체크를 해주세요. \n중복 체크 후 아이디를 변경하셨다면 다시 중복 체크 해주세요.")
				frm.member_id.focus();
				return false;
			}
	    	if(!/^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{8,16}$/.test(frm.member_pw.value)) {
	            alert('비밀번호는 영문/최소 1개의 숫자 또는 특수문자[8~16자리]');
	            frm.member_pw.focus();
	            return false; 
	        } else if(frm.member_pw.value.search(/\s/) != -1){
        	    alert("비밀번호는 공백 없이 입력해주세요.");
        	    frm.member_pw.focus();
        	    return false;
	        } else if (frm.member_pw.value !== frm.member_pw2.value) {
	            alert('비밀번호가 일치하지 않습니다.');
	            frm.member_pw2.focus();
	            return false;
	        }
			if(!frm.member_name.value){
				alert("[성명]을 입력해주세요");
				frm.member_name.focus();
				return false;
			}
			if (!/^[가-힣]{2,10}$/.test(frm.member_name.value)) {
	            alert('[성명]을 한글로 정확히 입력하세요(2~10자 이내).');
	            frm.member_name.focus();
	            return false;
	        }
			if (frm.member_birth_date.value == "") {
				alert("[생년월일]을 입력해주세요.");
				frm.member_birth_date.focus();
				return false;
			}
			if (frm.htel1.value == "" || frm.htel2.value == "" || frm.htel3.value == "") {
				alert("[전화번호]를 모두 입력해주세요.");
				frm.htel1.focus();
				return false;
			}
			if (EmptyChk(frm.member_email1.value) < 3) {
				alert("[이메일]이 정상적으로 입력되지 않았습니다.");
				frm.member_email1.focus();
				return false;
			}
			if (CheckEmailTail(frm.member_email1.value) == false) {
				alert("[이메일]이 정상적으로 입력되지 않았습니다.");
				frm.member_email1.value = "";
				frm.member_email1.focus();
				return false;
			}
			if (CheckEmailTail(frm.member_email2.value) == false) {
				alert("[이메일]이 정상적으로 입력되지 않았습니다.");
				frm.member_email2.value = "";
				frm.member_email2.focus();
				return false;
			}
			window.open("/project_ezen/member/join_success.jsp", "새창", 
  		  "top=100, left=800, width=340, height=323, toolbar=no, menubar=no, scrollbars=no, resizable=no" );
		}
	
	</script>

<!-- 섹션 영역 끝 -->

	<c:import url="/footer.jsp" />	