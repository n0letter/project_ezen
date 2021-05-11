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
String uri = request.getRequestURI();
System.out.println("현재 주소:" + uri);
System.out.println("member_idx:" + member_idx);
if(uri.indexOf("admin") != -1 && member_idx == null) {
	response.sendRedirect("/project_ezen/member/loginForm.jsp");
}
%>  
      <div class="mypage_header_img"></div>

<!-- 현재 위치 표시 -->
   <div class="where">
      <a href="/project_ezen/index.jsp">H</a>
      <div>관리자 커뮤니티</div>
      <div>이벤트 보기</div>
   </div>
 
 <div class="admin_board_wrap">
    <form method="post" name="eventModify" action="eventModify.do" >  
 	<input type="hidden" name="event_idx" value="${dto.event_idx }">
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
                      value="${dto.event_title}" name="event_title">
                    </td>
                  </tr>
                  
    
                
                  <tr>
                    <td class="board-left">작성자</td>
                    <td class="board-right">
                      <input type="text" class="name" name="event_name"
                       value="${dto.event_name}" />
              
                    
                    </td>
                  </tr>
                  <tr>
                    <td class="board-left">작성일</td>
                    <td class="board-right">
                    <input type="text" class="input" id="mail" 
                    	value="${dto.event_date}" name="event_date">
                    	
                      <!-- <input type="text" class="input" id="mail"> -->
                    </td>
                  </tr>
                <tr>
                    <td class="board-left">조회수</td>
                    <td class="board-right">
                      ${dto.event_hit }
                    </td>
                  </tr>
                  <tr>
                    <td class="ta-left">내용</td>
                    <td class="ta-right">
                      <textarea name="event_content" class="ckeditor" cols="52">${dto.event_content}
                      </textarea>
                    </td>
                  </tr>
                </tbody>
              </table>
            </td>
          </tr>
                  </tbody>
      </table>
      
      <div class="ebuttons">
          <input class="ewritesub" type="submit" value="수정"/>
          <input class="ewritebutton" type="button" value="삭제" onclick="deletecheck()"/>
          <input type="button" class="nwritesub02" value="목록" onClick="location.href='admin_event.do?page=1'"/> 
      </div>
    </div>
  </div>  
         
    </div>
    </form> 
	<form name="frmM" method="post" target="HiddenFrame">
		<input type="hidden" name="event_delete">
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
	frmM.event_delete.value = eventModify.event_idx.value;
	var a = confirm("회원을 삭제하시겠습니까?")
	if(a == true){
		frmM.action = "eventDelete.do"
		frmM.submit();
	} else {
		
		window.history.go(0);
	}
	/* return false; */
}
</script>
     <c:import url="/footer.jsp" />
