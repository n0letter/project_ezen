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
		<div>로그인</div>
	</div>

<!-- 섹션 영역 시작 -->
	<div class="login_wrap">
		<!-- <h2>GOOD CHOICE LOGO</h2> -->
		<h2><image src="/project_ezen/img/member_image/LOGO_002.png"></image></h2>
		<div class="login_box">
			<form class="login_form" name="LoginMember" method="post" action="login.do" onsubmit="return checkLogin()">
				<%  //로그인 상태에서 못 들어오게(주로 뒤로가기 클릭시) 
					String member_idx = (String)session.getAttribute("member_idx");
					String referer = request.getHeader("referer"); 
					System.out.println("이전 주소:" + referer);
					if(referer.indexOf("loginForm") != -1 && member_idx != null) {
						response.sendRedirect("/project_ezen/main.do");
					} else if(member_idx != null) {
						response.sendRedirect("/project_ezen/main.do");
						/* response.sendRedirect(referer); */
					}
					if(referer.indexOf("find_id_pw") != -1) {
						referer = "/project_ezen/main.do";
					}
					//아이디 넘겨 받기
					String finded_id = (String)session.getAttribute("finded_id");
					if(finded_id == null) {
						finded_id = "";
					}
				%> 
				<input type="hidden" name="login_referer" value=" <%= referer %>" /> 
				<div class="login">
					<p>회원 아이디와 비밀번호를 입력하여 로그인 하시거나 아직 회원가입을 하지 않으신<br>
					   고객님께서는 회원가입을 하셔서 보다 많은 정보와 서비스의 혜택을 누리시기 바랍니다.
				    </p>
					<ul>
						<li>
							<input type="text" name="member_id" value="<%= finded_id %>" size="12" maxlength="20" 
							tabindex="1" placeholder="아이디" id="member_id" value="">
							<% session.removeAttribute("finded_id"); %>
						</li>
						<li>
							<input type="password" name="member_pw" value="" size="12" maxlength="20" 
							tabindex="2" placeholder="비밀번호" id="member_pw">
						</li>
						
						<input type="submit" class="loginBtn" value="로그인" />
						
				        <%
				        int loginResult = (Integer)request.getAttribute("loginResult") == null? 1:(Integer)request.getAttribute("loginResult"); 
				        
						System.out.println("로그인페이지 loginResult: "+loginResult);
						if( loginResult == 0 || loginResult == -1)  
						{ 
							/* loginResult = 1; */
						%>
						<div class="login_red">아이디와 비밀번호가 올바르지 않습니다.</div>
						<%	
						
						}  
						
						%> 
						<div class="btnJoin_wrap">
							<div class="login_btn01"><a href="/project_ezen/member/join_agree.jsp" class="btnJoin">회원가입</a></div>
							<%-- <%
							if( member_idx != null) {
							%> 
							<div class="login_btn02">
								<a href="javascript:find_alert();" class="btnJoin joinType1" >
								아이디/비밀번호찾기
								</a>
							</div>
							<% 	
							} else {
							%> --%>
							<div class="login_btn02"><a href="/project_ezen/member/find_id_pw.jsp" class="btnJoin joinType1" >아이디/비밀번호찾기</a></div>
							<%-- <% 
							}
							%> --%>
						</div>
					</ul>
				</div>
			</form>
		</div>
	</div>
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>	
	<script>
		/* function find_alert() {
			alert("로그인 상태에서 아이디/비밀번호 찾기를 이용할 수 없습니다.");
			return false;
		}
		 */
		/* 입력창에 글을 쓰고 찾기 버튼 외에 다른 페이지 이동 버튼으로 이동한 뒤 뒤로가기 누른
		경우 입력창에 글자가 남아있지 않게 하는 코드 -> 문제점:무조건 새로고침이 되어 로그인 시 전 페이지로 돌아갈 수 없음. */
		<%-- var mem_idx = "<%= session.getAttribute("member_idx") %>"; --%>
		/* if( document.LoginMember.member_id.value  mem_idx == "null" ) { 
			if (self.name != 'reload') {
			    self.name = 'reload';
			    self.location.reload(true);
			}
			else self.name = '' ; 
		}   */
		function checkLogin()
		{
			if(!document.LoginMember.member_id.value){
				alert("아이디를 입력해주세요");
				document.getElementById('member_id').focus();
				return false;
			} else if(document.LoginMember.member_id.value.search(/\s/) != -1){
        	    alert("아이디는 공백 없이 입력해주세요.");
        	    document.getElementById('member_id').focus();
        	    return false;
	        }
			if(!document.LoginMember.member_pw.value){
				alert("비밀번호를 입력해주세요");
				document.getElementById('member_pw').focus();
				return false;
			} else if(document.LoginMember.member_pw.value.search(/\s/) != -1){
        	    alert("비밀번호는 공백 없이 입력해주세요.");
        	    document.getElementById('member_pw').focus();
        	    return false;
	        }
		}
	</script>
	
<!-- 섹션 영역 끝 -->

	<c:import url="/footer.jsp" />	