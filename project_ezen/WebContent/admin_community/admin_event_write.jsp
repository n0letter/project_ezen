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
      <div>이벤트 글쓰기</div>
   </div>
        <div class="admin_event_write_wrap">
                    
   <div class="admin_event_write_content">
      <form name="nwrite" method="post" action="ewrite.do" onsubmit="return adWriteCheck()">
      	<input type="hidden" name="event_name" value="${ member_name }">
        <table class="admin_event_write_table">
          <tr>
            <th style="border-left: 1px solid rgba(116, 116, 116, 0.5)">제목</th>
            <td class="admin_event_write_td">
              <input class="ntitle" type="text" name="event_title" placeholder="제목을 입력해 주세요!">
          
              
                  </tr>
          <tr>
            <td colspan="2">
              <textarea name="event_content" class="ckeditor" cols="52" value=""></textarea>
            </td>
          </tr>
        </table>
        <div class="evenbuttons">
          <input class="evenwritesub" type="submit" value="등록"/>
		  <a href="admin_event.do?page=1">
            <input class="evenbutton" type="button" value="취소"/></a>	
	    </div>
      </form>
    </div>
      
  </div>

  
  <script src="https://cdn.ckeditor.com/4.16.0/standard/ckeditor.js"></script>
  
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>
<script>

	function adWriteCheck() {
		if(!nwrite.event_title.value) {
			  alert("제목을 작성해 주세요!")
			  return false;
		}
		var a = confirm("글을 등록하시겠습니까?")
		if(a == true){
			
		} else {
			return false;
			window.history.go(0);
		}
	}
</script>
  <c:import url="/footer.jsp" />

 
