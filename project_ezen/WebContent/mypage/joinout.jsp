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
  
  <div class="mypage_header_img"></div>  
  
  <!-- 현재위치표시 영역 시작 -->    
  <div class="where">
    <a href="/project_ezen/main.do">H</a>
    <div>마이페이지</div>
    <div>회원탈퇴</div>
  </div>
  <!-- 현재위치표시 영역 끝 -->
  
  <!-- joinout 영역 시작 --> 
  <div class="mypage_wrap">
  
    <!-- 사이드메뉴 -->
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
		      <a href="/project_ezen/mypage/password.do?member_idx=${member_idx}"> > 비밀번호 변경</a><br>
			  <a class="myclick" href="/project_ezen/mypage/joinout.do?member_idx=${member_idx}"> > 회원탈퇴</a>
			 </td>
		  </tr>
	    </tbody>
      </table>    
    
      <div class="joinout">
         <h4><small class="payment_small">▌</small>회원탈퇴</h4> <hr>
         <div class="joinout_content">
           <h5><small class="re_span03">●</small>회원탈퇴 안내</h5>
           <div class="joinout_01">
             <p>고객님! 지금까지 저희 헬스장을 이용해 주셔서 감사합니다. <br>
                저희 헬스장에 부족한 점이 있었다면 너그러운 양해 바라며, 아래의 사항을 <br>
                확인 하시고, 개선해야 할 점이 있다면 남겨 주세요! <br>
                더욱 고객님의 의견을 적극 반영하여 이용에 불편이 없도록 개선하겠습니다.</p>
           </div>
         </div>
         <div class="joinout_content">
           <h5><small class="re_span03">●</small>회원탈퇴 시 꼭 확인해 주세요.</h5>
           <div class="joinout_01">
             <p>- 회원 탈퇴 후 30일간 재가입이 불가능합니다. <br>
                - 탈퇴 이후 등록한 게시물, 보유 쿠폰 등 이용기록이 모두 삭제 됩니다.</p>
           </div>  
         </div>
         <form name="joinout" method="post" action="joinoutAction.do" > 
         	 <input type="hidden" name="member_idx"  value="${dto.member_idx}" />
	         <input type="hidden" name="member_id"  value="${dto.member_id}" />
	         <input type="hidden" name="member_name"  value="${dto.member_name}" />
	         <input type="hidden" name="member_pay_sum"  value="${dto.member_pay_sum}" />
	         <input type="hidden" name="member_join_date"  value="${dto.member_join_date}" />
	         <div class="joinout_contentA">
	           <h5><small class="re_span03">●</small>탈퇴사유를 선택해 주세요.</h5>
	           <div class="joinout_01">
	             <input type="checkbox" name="joinout_checkbox1" value="이용률 감소" id="jout1"><label class="joinout_checkbox" for="jout1">이용률 감소</label>
	             <input type="checkbox" name="joinout_checkbox2" value="가격 불만" id="jout2"><label class="joinout_checkbox" for="jout2">가격 불만</label>
	             <input type="checkbox" name="joinout_checkbox3" value="고객서비스 불만" id="jout3"><label class="joinout_checkbox" for="jout3">고객서비스 불만</label>
	             <input type="checkbox" name="joinout_checkbox4" value="개인정보유출 우려" id="jout4"><label class="joinout_checkbox" for="jout4">개인정보유출 우려</label>
	           </div>
	         </div>
	         <div class="joinout_content">
	           <h5><small class="re_span03">●</small>개선 사항이 있다면 의견을 남겨 주세요.</h5>
	           <textarea maxlength="100" class="joinout_opinion" name="joinout_opinion" placeholder="100글자 이내로 작성하세요."></textarea>
	         </div>
	         <div class="joinout_contentB">
	           <h5><small class="re_span03">●</small>비밀번호 입력</h5>
	           <input class="joinout_password" type="password" name="joinout_password">
	         </div>
	         <%
		        int pw_check_result = (Integer)session.getAttribute("pw_check_result") == null? 1:(Integer)session.getAttribute("pw_check_result"); 
		        
				System.out.println("수정 페이지 : "+pw_check_result);
				if( pw_check_result == 2 )  
				{ 
				%>
				<div>
					<p colspan="2" style="text-align:center; color:red;">비밀번호가 올바르지 않습니다.</p>
				</div>
				<%	
				session.removeAttribute("pw_check_result");  
				}  
			 %> 
	         <hr>
	         <a href="/project_ezen/main.jsp">
	           <input class="joinout_btnA" name="joinout_btnA" type="submit" value="확인"/>
	         </a>
	         <a href="javascript:joinout.reset();">
	           <input class="joinout_btnB" name="joinout_btnB" type="button" value="취소"/>
	         </a>
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
	var joinout_btnA = document.getElementsByClassName('joinout_btnA');
	
	joinout_btnA[0].onclick = function() {
      console.log("click");
      if(document.joinout.joinout_password.value == "") {
	       alert('비밀번호를 입력해주세요');
	       return false;
      } else {
		  var a = confirm("회원탈퇴 하시겠습니까?")
      	  if(a == true){
	    		
	      } else {
	    		window.history.go(0);
	    		return false;
	      }
      }
};
</script>
  <!-- joinout 영역 끝 -->
  
  <c:import url="/footer.jsp" />