<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
response.setHeader("Pragma", "no-cache"); //HTTP 1.0
response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
response.setDateHeader("Expires", 0L); // Do not cache in proxy server
%>      
 	<c:import url="/admin_header.jsp" />

<%
String member_idx = (String)session.getAttribute("member_idx");
String member_id = (String)session.getAttribute("member_id");
String uri = request.getRequestURI();
System.out.println("현재 주소:" + uri);
System.out.println("member_idx:" + member_idx);
if(uri.indexOf("admin") != -1 && member_idx == null) {
	response.sendRedirect("/project_ezen/member/loginForm.jsp");
} else if(!member_id.equals("admin")) {
	response.sendRedirect("/project_ezen/main.do");
}
%>

      <div class="mypage_header_img"></div>

<!-- 현재 위치 표시 -->
   <div class="where">
      <a href="/project_ezen/index.jsp">H</a>
      <div>커뮤니티</div>
      <div>채용안내 보기</div>
   </div>
  <div class="admin_board_wrap">
    
       <form method="post" name="recruitmentModify" action="recruitmentModify.do" >  
 	<input type="hidden" name="recruitment_idx" value="${dto.recruitment_idx }">
 <div class="admin_board_write_wrap">
            
  <div class="board00"></div>
  <div class="board">
    <div class="board-form">
      <table width="100%">
        <tbody>
          <tr>
            <td>
              <table>
                <tbody>
                  <tr>
                    <td class="board-left">제목</td>
                    <td class="board-right">
                      <input type="text" class="name" id="name"
                      value="${dto.recruitment_title }" name="recruitment_title">
                     
                    </td>
                  </tr>
                  
                
                  <tr>
                    <td class="board-left">작성자</td>
                    <td class="board-right">
                      <input type="text" class="name" id="관리자"
                      value="${dto.recruitment_name }" name="recruitment_name">
                                         
                    </td>
                  </tr>
                  <tr>
                    <td class="board-left">작성일</td>
                    <td class="board-right">
                      <input type="text" class="input" id="mail"
                      value="${dto.recruitment_date }" name="recruitment_date">
                     
                    </td>
                  </tr>
                <tr>
                    <td class="board-left">조회수</td>
                    <td class="board-right">
                      ${dto.recruitment_hit }
                    </td>
                  </tr>
                  <tr>
                    <td class="ta-left">내용</td>
                    <td class="ta-right">
                      <textarea name="recruitment_content" class="ckeditor" cols="52" >${dto.recruitment_content }
                     </textarea>
                    </td>
                  </tr>
                </tbody>
              </table>
            </td>
          </tr>
       </tbody>
      </table>
 
         <div class="rbuttons">
          <input class="rwritesub" type="submit" value="수정"/>
		 <!-- <a href="admin_recruitment.jsp"> -->
          <input class="rwritebutton" type="button" value="삭제" onclick="deletecheck()"/>
          <input type="button" class="nwritesub02" value="목록" onClick="location.href='admin_recruitment.do?page=1'"/>   
        </div>
    </div>
       </div>
  </div>  
    </form> 
	<form name="frmM" method="post" target="HiddenFrame">
		<input type="hidden" name="recruitment_delete">
	</form>
</div>

  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>
    <script src="https://cdn.ckeditor.com/4.16.0/standard/ckeditor.js"></script>
<script>
function deletecheck() {
	frmM.recruitment_delete.value = recruitmentModify.recruitment_idx.value;
	var a = confirm("회원을 삭제하시겠습니까?")
	if(a == true){
		frmM.action = "recruitmentDelete.do"
		frmM.submit();
	} else {
		
		window.history.go(0);
	}
	/* return false; */
}
</script>
 
 
 
 
    
   <c:import url="/footer.jsp" />