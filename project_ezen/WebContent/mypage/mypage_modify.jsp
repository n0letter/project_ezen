<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
response.setHeader("Pragma", "no-cache"); //HTTP 1.0
response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
response.setDateHeader("Expires", 0L); // Do not cache in proxy server
%>      
  <c:import url="/header.jsp" />
<%
String member_idx = (String)session.getAttribute("member_idx");
String uri = request.getRequestURI();
System.out.println("현재 주소:" + uri);
System.out.println("member_idx:" + member_idx);
if(uri.indexOf("mypage") != -1 && member_idx == null) {
	response.sendRedirect("/project_ezen/member/loginForm.jsp");
}
%>
 
  		<div class="mypage_header_img">
	  	
	    </div>
 
<!-- 현재 위치 표시 -->
	<div class="where">
		<a href="/project_ezen/main.jsp">H</a>
		<div>마이페이지</div>
		<div>회원정보수정</div>
	</div>
  
  <!-- 현재위치표시 영역 끝 -->
  

  
   <!-- mypage 영역 시작 -->
  <div class="mypage_wrap">
	 <div class="mypage_menu">
      <table class="mypage_menutable">
	    <tbody>
		  <tr>
		    <th>마이페이지</th>
          </tr>
          <tr>
		    <td><a href="/project_ezen/mypage/Mypage.do?member_idx=${member_idx}"> > 회원정보</a> </td>
          </tr>
		  <tr>
		    <th> 결제내역</th>
		  </tr>
		  <tr>
		    <td><a href="/project_ezen/mypage/paylist.do?member_idx=${member_idx}&page=1"> > 결제내역</a></td>
		  </tr>
		  <tr>
		    <th> 게시판 이용 내역</th>
		  </tr>
		  <tr>
		    <td>
		      <a href="/project_ezen/mypage/oneonone.do?member_idx=${member_idx}&page=1">> 1:1문의</a> <br>
			  <a href="/project_ezen/mypage/myafter.do?member_idx=${member_idx}&page=1"> >나의 후기</a>
		    </td>
		  </tr>
		  <tr>
		    <th> 개인정보 수정</th>
	      </tr>
		  <tr>
		    <td>
		      <a class="myclick"  href="/project_ezen/mypage/mypage_modify.do?member_idx=${member_idx}"> > 개인정보 수정</a> <br>
		      <a href="/project_ezen/mypage/password.do?member_idx=${member_idx}"> > 비밀번호 변경</a><br>
			  <a href="/project_ezen/mypage/joinout.do?member_idx=${member_idx}"> > 회원탈퇴</a>
			 </td>
		  </tr>
	    </tbody>
      </table>  

	  <div class="mypage_member_top">
  	    <h4><small class="service_small">▌</small>개인정보수정</h4>
	
		<!-- 개인정보수정 -->
	  <form name="mypage_memModify" method="post" action="myMemModify.do">
	    <input type="hidden" name="member_idx" value="${dto.member_idx }">
		<table class="mypage_modify_table">
			<tbody>
				<tr>
					<th>아이디</th>
					<td>${dto.member_id}
					<!-- <input type="text" id="modify_box1"> -->
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>${dto.member_name}
					<!-- <input type="text" id="modify_box2" value=""> -->
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td><input class="modify_texts" type="text" id="modify_box3" name="tel" placeholder="숫자만 입력" value="${dto.member_phone}"></td>
				</tr>
				<tr>
					<th>생년월일</a></th>
					<td>
						<input class="choice_date DatePicker" type="text" id="modify_box4" name="choice_date" value="${dto.member_birth_date}">
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input class="modify_texts" type="text" id="modify_box5" name="email" value="${dto.member_email}"></td>
				</tr>
				<tr>
					<th>메일 수신여부</th>
					<c:set var="trans" value="${dto.member_email_receive}"/>
		   	      	<c:choose>
						<c:when test="${ trans eq '0' }">
				        <td >
							<label for="gudoc1">
								<input type="radio" name="member_email_receive" id="gudoc1" value="1"> 예 
							</label> 
							<label for="gudoc2">
								<input type="radio" name="member_email_receive" id="gudoc2" value="0" checked=""> 아니오
							</label>
						</td>
						</c:when>
						<c:otherwise>
						<td>
							<label for="gudoc1">
								<input type="radio" name="member_email_receive" id="gudoc1" value="1" checked=""> 예 
							</label> 
							<label for="gudoc2">
								<input type="radio" name="member_email_receive" id="gudoc2" value="0"> 아니오
							</label>
						</td>
						</c:otherwise>
					</c:choose>
					
				</tr>
			</tbody>
		</table>
		
		<table class="mypage_pass">
			<tbody>
				<tr>
					<!-- <th></th> -->
					<th>비밀번호입력&nbsp;&nbsp;&nbsp;&nbsp;<input class="modify_texts"  type="password" name="modify_pw" id="modify_box6"></th>
				</tr>
				<%
		        int pw_check_result = (Integer)session.getAttribute("pw_check_result") == null? 1:(Integer)session.getAttribute("pw_check_result"); 
		        
				System.out.println("수정 페이지 : "+pw_check_result);
				if( pw_check_result == 2 )  
				{ 
				%>
				<tr>
					<td class="login_red" style="text-align:center;">비밀번호가 올바르지 않습니다.</td>
				</tr>
				<%	
				session.removeAttribute("pw_check_result");  
				}  
				%> 
				
				<tr>
					<td>
						<div class="modify_submit">
							<input class="modify_sub" type="submit" value="수정">&nbsp;&nbsp;&nbsp;
							<a  id="cancel" href="javascript:mypage_memModify.reset();">
								<input class="modify_btn" type="button" value="취소">
							</a>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		  
	  </form>	  
   </div>
   </div>
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
	<script>
	var modify_submitBtn = document.getElementsByClassName('modify_submit');
    var box1 = document.getElementById('modify_box1');
    var box2 = document.getElementById('modify_box2');
	var box3 = document.getElementById('modify_box3');
	var box4 = document.getElementById('modify_box4');
	var box5 = document.getElementById('modify_box5');
	var box6 = document.getElementById('modify_box6');

	

    modify_submitBtn[0].onclick = function() {
     	console.log("click");
      	if(!/^\d{3}\d{3,4}\d{4}$/.test( $("#modify_box3").val())) {
	    	   alert('전화번호를 입력해주세요');
	    	   return false;
		} else if(document.mypage_memModify.choice_date.value == "" ) {
		       alert('생년월일을 입력해주세요');
		       return false;
		} else if(document.mypage_memModify.email.value == "" ) {
		       alert('이메일을 입력해주세요');
		       return false;
		} else if(document.mypage_memModify.modify_pw.value == "") {
		       alert('비밀번호를 입력해주세요');
		       return false;
        } else {
        	var a = confirm("회원정보를 변경하시겠습니까?")
        	if(a == true){
	    		
	    	} else {
	    		window.history.go(0);
	    		return false;
	    	}
        }
      	
		
	};
</script>

 
  
	<!-- mypage 영역 끝 -->

  <c:import url="/footer.jsp" />