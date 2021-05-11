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
    <div>고객센터</div>
    <div>1:1문의</div>
  </div>
  <!-- 현재위치표시 영역 끝 -->
  
  <!-- inquiry 영역 시작 -->   
  <div class="inquiry_wrap">
  
    <!-- 고객센터 안내사항 --> 
    <div class="inquiry_header">
      <img src="/project_ezen/img/service_image/inquiry01.PNG">
      <div class="inquiry_header_text">
        <h4>무엇을 도와 드릴까요?</h4>
        <p>궁금한 사항이나 불편한 사항은 저희 헬스장으로 전화 주시거나 <br>
          1:1문의로 남겨주세요. 친절히 안내해 드립니다.</p>
        <P class="inquiry_header_p">헬스장 02-000-0000 (평일 10시~22시 / 공휴일,주말 휴무)</P>
      </div>
    </div>
    
    <!-- 1:1문의 글쓰기 --> 
    <form class="inquiryform" name="inquiryform" action="inquiry.do" method="post" onsubmit="return inquirycheck()">
    
      <input type="hidden" name="inq_member_idx" value="${member_idx}"/>
      <input type="hidden" name="inq_state" value="미답변"/>
    
      <input type="hidden" name="member_idx" value="${member_idx}">
      <input type="hidden" name="inq_name" value="${member_name}">
     
      <!-- 글쓰기 --> 
      <div class="inquiry_content">
       <h4 class="inquiry_title"><small class="service_small">▌</small>1:1 문의</h4>
        <table class="inquiry_table">
          <tr>
            <th class="inquiry_th">제목</th>
            <td class="inquiry_td">
              <select class="inquiry_select" name="inq_type">
                <option value="">질문유형선택</option>
                <option value="결제문의">결제문의</option>
                <option value="환불문의">환불문의</option>
                <option value="회원정보문의">회원정보문의</option>
                <option value="기타문의">기타문의</option>
              </select> <br>
              <input class="inquiry_name" type="text" name="inq_title" maxlength="28" placeholder="제목을 입력해 주세요!">
            </td>
          </tr>
          <tr>
            <th class="inquiry_th">내용</th>
            <td class="inquiry_td">
              <textarea class="inquiry_text" name="inq_content" maxlength="200" placeholder="내용을 입력해 주세요!"></textarea> 
            </td>
          </tr>
        </table>
      </div>
    
      <!-- 1:1문의 안내사항+버튼 --> 
      <div class="inquiry_bottom">
        <div>
          <p>
            <small>●</small> 1:1문의는 비공개로 고객에게 답변을 드립니다<br>
            <small>●</small> 한번 등록한 문의 내용은 수정이 불가능합니다.<br>
            <small>●</small> 1:1문의는 24시간 신청이 가능하며 접수된 내용은 빠른 시간 내에 답변을 드리도록 하겠습니다.<br>
            <small>●</small> 문의한 내용은 [마이페이지>내 게시글]에서 확인 가능합니다.
          </p>
        </div>
        <input class="inquiry_btn" type="submit" value="등록하기"/>
      </div>
    
    </form>
    
  </div>
  <!-- inquiry 영역 끝 -->
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>  
  <!-- 유효성검사 -->
  <script>
    function inquirycheck() {
      var i = document.inquiryform;
    	
      // 로그인확인
      if(i.member_idx.value == "") {
    	var a = confirm("로그인 후 이용 가능합니다.")
    	if(a == true){
    		location.href = "/project_ezen/member/loginForm.jsp";
    	}
		return false;
	  }	
      
      // 값이없는경우
      if (i.inq_type.value == "" ) {
        alert('질문유형을 선택해주세요.');
        i.inq_type.focus();
        return false;
      }
      if (i.inq_title.value == "" ) {
        alert('제목을 입력해주세요.');
        i.inq_title.focus();
        return false;
      }
      if (i.inq_content.value == "" ) {
        alert('내용을 입력해주세요.');
        i.inq_content.focus();
        return false;
      }     
      if (i.inq_content.value != "" && i.inq_title.value != ""  && i.inq_content.value != "") {
        alert('글이 등록되었습니다! \n문의한 내용은 마이페이지에서 확인 가능합니다.');
        i.inq_content.focus();
        i.inq_title.focus();
        i.inq_type.focus();
        return true;
      } 
    }
  </script>
  

  <c:import url="/footer.jsp" />