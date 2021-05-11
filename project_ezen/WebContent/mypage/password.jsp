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
		<div>비밀번호변경</div>
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
		      <a href="/project_ezen/mypage/mypage_modify.do?member_idx=${member_idx}"> > 개인정보 수정</a> <br>
		      <a class="myclick" href="/project_ezen/mypage/password.do?member_idx=${member_idx}"> > 비밀번호 변경</a><br>
			  <a href="/project_ezen/mypage/joinout.do?member_idx=${member_idx}"> > 회원탈퇴</a>
			 </td>
		  </tr>
	    </tbody>
      </table>   

	<!-- 비밀번호변경 -->
		
		<div class="mypage_passch">
		  <h4><small class="service_small">▌</small>비밀번호변경</h4>
			<p><span class="re_span02">※</span> 비밀번호는 영문/최소 1개의 숫자 또는 특수문자[8~16자리]<span class="re_span02">※</span></p>
			<form name="myPwModify" method="post" action="myPwModify.do">
				<input type="hidden" name="member_idx"  value="${dto.member_idx}" />
				<table>
					<tbody>
						<tr>
							<th>현재비밀번호입력</th>
							<td><input type="password" id="pass_box1" name="modify_pw"></td>
						</tr>
			     		<tr>
							<th>새로운비밀번호입력</th>
							<td><input type="password" id="pass_box2" name="new_pw01"></td>
						</tr>
			            <tr>
							<th>새로운비밀번호확인</th>
							<td><input type="password" id="pass_box3" name="new_pw02"></td>
						</tr>
						<%
				        int pw_check_result = (Integer)session.getAttribute("pw_check_result") == null? 1:(Integer)session.getAttribute("pw_check_result"); 
				        
						System.out.println("탈퇴 페이지 : "+pw_check_result);
						if( pw_check_result == 2 )  
						{ 
						%>
						<tr>
							<td colspan="2" class="login_red" style="text-align:center;">현재 비밀번호가 올바르지 않습니다.</td>
						</tr>
						<%	
						session.removeAttribute("pw_check_result");  
						}  
						%> 
					</tbody>
				 </table>


					<input class="pass_submitbtn" type="submit" value="수정" name="Submit">
					<a id="cancel" href="javascript:myPwModify.reset();">
					  <input class="pass_btn" type="button" value="취소"></a>
					
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
	var submitBtn = document.getElementsByClassName('pass_submitbtn');
    var box1 = document.getElementById('pass_box1');
    var box2 = document.getElementById('pass_box2');
	var box3 = document.getElementById('pass_box3');
	
    submitBtn[0].onclick = function() {
      console.log("click");
      if(document.myPwModify.modify_pw.value == "") {
	       alert('비밀번호를 입력해주세요');
	       return false;
   	  } else if(!/^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{8,16}$/.test( $("#pass_box2").val())) {
	       alert('변경될 비밀번호를 입력해주세요(영문/최소 1개의 숫자 또는 특수문자[8~16자리])');
	       return false;
	  } else if(document.myPwModify.new_pw02.value == "") {
	       alert('한 번 더 비밀번호를 입력해주세요');
	       return false;
      } else if (document.myPwModify.new_pw01.value !== document.myPwModify.new_pw02.value) {
           alert('비밀번호가 일치하지 않습니다.');
           return false;
      }
	  else {
		  var a = confirm("비밀번호를 변경하시겠습니까?")
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