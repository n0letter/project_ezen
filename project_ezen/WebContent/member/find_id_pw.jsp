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
	<%  //로그인 상태에서 못 들어오게(주로 뒤로가기 클릭시) 
		String member_idx = (String)session.getAttribute("member_idx");
		String referer = request.getHeader("referer");
		System.out.println("referer:" + referer);
		String uri = request.getRequestURI();
		System.out.println("현재 주소:" + uri);
		System.out.println("member_idx:" + member_idx);
		if(uri.indexOf("find_id_pw") != -1 && member_idx != null) {
			response.sendRedirect("/project_ezen/main.do");
		}
		/* if(member_idx != null && referer.indexOf("loginForm") != -1) {
			response.sendRedirect("/project_ezen/main.do");
		} else if(member_idx != null && referer.indexOf("find_id_pw") == -1) {
			response.sendRedirect(referer); 
		} else if(member_idx != null && referer.indexOf("find_id_pw") != -1) {
			response.sendRedirect("/project_ezen/main.do");
		} */
	%>  

	<div class="mypage_header_img">
    </div>
<!-- 현재 위치 표시 -->
	<div class="where">
		<a href="/project_ezen/main.do">H</a>
		<div>아이디/패스워드 찾기</div>
	</div>

<!-- 섹션 영역 시작 -->
	<div class="find_wrap">
		<h2><image src="/project_ezen/img/member_image/LOGO_002.png"></image></h2>
		<div class="find_box">
			<div class="find_inbox">
				<div class="find_left">
					<form class="find_id_form" name="findId" method="post" action="idFind.do" onsubmit="return checkFindId()">
						<div class="find">
							<h5>아이디 찾기</h5>
							<p>회원가입 시 입력하신 이메일을 입력해 주세요.<br>
							   궁금하신 사항은 고객센터로 문의하시기 바랍니다.
						    </p>
						    
						    <%
								String member_id = (String)session.getAttribute("member_id");
									//null체크
								if (member_id != null) {
							%>
							<!-- 찾은 아이디 출력 -->
							<ul>
								회원님의 아이디는 <br>
								<li>
									<input type="text" name="finded_id" value="<%= member_id %>"  maxlength="16" 
									tabindex="1"  id="finded_id"  readonly /> 입니다.
								</li>
								<div class="login_btn01">
									<input type="submit" formaction="id_move" class="btnJoin" id="id_move"  value="로그인">
							    </div>
							</ul>
							<%
								//아래 처럼 아이디 정보 지워주지 않으면 다음페이지에서 뒤로가기로 본 페이지 나올시
								//아이디 찾은 것으로 보이게 됨. 초기화시켜주기 위한 코드 controller와 연결
								//(수정)아래 코드 때문에 아이디 찾기 후 로그인, 이후 뒤로가기 2번하면 오류 발생->따라서 삭제
									/* session.removeAttribute("member_id"); */
								} else {
							%>
							<!-- 아이디 찾기 -->
							<ul>
								<li>
									<input type="text" name="find_name" value="" size="12" maxlength="20" 
									tabindex="1" placeholder="이름" id="find_name"  />
								</li>
								<li>
									<input type="text" name="find_mail01" value="" size="12" maxlength="30" 
									tabindex="2" placeholder="이메일" id="find_mail01">
								</li>
								
								<%
						        String id_find_failed = (String)request.getAttribute("id_find_failed") == null? "none":(String)request.getAttribute("id_find_failed"); 
								System.out.println("아이디 찾기 페이지 실패" + id_find_failed);
								//null체크
								if( id_find_failed.equals("failed"))  
								{ 
								%>
								<div class="login_red">일치하는 아이디가 없습니다.</div>
								<%	
								}  
								%> 
								
								<div class="btnJoin_wrap find_img_wrap">
									<!-- <div class="login_btn01 find_img"><a href="#" class="btnJoin wide"><input type="image" src="/project_ezen/img/member_image/find.png" class="find_img"></a></div> -->
									<div class="login_btn01 find_img"><a href="#" class="btnJoin find_wide"><input type="submit"  value="확인"></a></div>
									
									<div class="login_btn02"><a href="javascript:findId.reset();" class="btnJoin find_wide joinType1" >취소</a></div>
								</div>
							</ul>
							<%
								}
							%>
						</div>
					</form>
				</div>
				<div class="find_right">
					<form class="find_pw_form" name="findPw" method="post" action="find_pw.do" onsubmit="return checkFindPw()">
						<div class="find">
							<h5>비밀번호 찾기</h5>
							<p>회원가입 시 입력하신 이메일을 입력해 주세요.<br>
							   궁금하신 사항은 고객센터로 문의하시기 바랍니다.
						    </p>
						    <%
								String member_pw = (String)session.getAttribute("member_pw");
						    	System.out.println("찾기 페이지 pw : "+member_pw);
									//null체크
								if (member_pw != null) {
							%>
							<!-- 바뀐 비밀번호 출력 -->
							<ul>
								회원님의 비밀번호는 <br>
								<li>
									<input type="text" name="find_pw" value="<%= member_pw %>"  maxlength="16" 
									tabindex="1"  id="finded_id"  readonly /> 입니다.
								</li>
								<div class="login_btn01"><a href="/project_ezen/member/loginForm.jsp" class="btnJoin"  id="pw_move">로그인</a></div>
							</ul>
							<%
									/* session.removeAttribute("member_pw"); */
								} else {
							%>
							<!-- 비민번호 찾기 -->
							<ul>
								<li>
									<input type="text" name="find_id" value="" size="12" maxlength="16" 
									tabindex="1" placeholder="아이디" id="find_id">
								</li>
								<li>
									<input type="text" name="find_mail02" value="" size="12" maxlength="30" 
									tabindex="2" placeholder="이메일" id="find_mail02">
								</li>
								<%
						        String pw_find_failed = (String)request.getAttribute("pw_find_failed") == null? "none":(String)request.getAttribute("pw_find_failed"); 
								System.out.println("비번찾기 페이지 실패"  + pw_find_failed);
								//null체크
								if( pw_find_failed.equals("failed"))  
								{ 
								%>
								<div class="login_red">일치하는 비밀번호가 없습니다.</div>
								<%	
								}  
								%> 
								<div class="btnJoin_wrap find_img_wrap">
									<div class="login_btn01 find_img"><a href="#" class="btnJoin find_wide"><input type="submit" class="find_img" value="확인"></a></div>
									<div class="login_btn02"><a href="javascript:findPw.reset();" class="btnJoin find_wide joinType1" >취소</a></div>
								</div>
							</ul>
							<%
								}
							%>
						</div>
					</form>
				</div>
			</div>
			<div class="joinArea">
			아직 굿초이스 회원이 아니신가요? 
				<span class="joinArea_btn"><a href="join_agree.jsp" class="btnJoin find_wide">회원가입</a></span>
			</div>
		</div>
	</div>
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>

	<script>
		//입력창에 글을 쓰고 찾기 버튼 외에 다른 페이지 이동 버튼으로 이동한 뒤 뒤로가기 누른
		//경우 입력창에 글자가 남아있지 않게 하는 코드
		if((!document.findId.find_name.value || !document.findId.find_mail01.value)
				&& (!document.findPw.find_id.value || !document.findPw.find_mail02.value)) {  
			if (self.name != 'reload') {
			    self.name = 'reload';
			    self.location.reload(true);
			}
			else self.name = '';
		}  
	
		function checkFindId()
		{
			if(!document.findId.find_name.value){
				alert("아이디를 입력해주세요");
				document.getElementById('find_name').focus();
				return false;
			}
			if(!document.findId.find_mail01.value){
				alert("이메일을 입력해주세요");
				document.getElementById('find_mail01').focus();
				return false;
			}
		}
		function checkFindPw()
		{
			if(!document.findPw.find_id.value){
				alert("아이디를 입력해주세요");
				document.getElementById('find_id').focus();
				return false;
			}
			if(!document.findPw.find_mail02.value){
				alert("이메일을 입력해주세요");
				document.getElementById('find_mail02').focus();
				return false;
			}
		
		}
		
	</script>



<!-- 섹션 영역 끝 -->

	<c:import url="/footer.jsp" />	