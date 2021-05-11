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
      <div>관리자 커뮤니티</div>
      <div>공지사항 글쓰기</div>
   </div>
        <div class="admin_notice_write_wrap">
                    
   <div class="admin_notice_write_content">
      <form name="nwrite" method="post" action="nwrite.do" onsubmit="return adWriteCheck()">
        <table class="admin_notice_write_table">
          <tr>
            <th style="border-left: 1px solid rgba(116, 116, 116, 0.5); width:130px;">제목</th>
            <td class="admin_notice_write_td" >
              <input class="ntitle" type="text" name="notice_title" placeholder="제목을 입력해 주세요!">
          	  <input type="hidden" name="notice_name" value="관리자">	
         </tr>
          <tr >
            <td colspan="2">
              <textarea name="notice_content" class="ckeditor" cols="52" value=""></textarea> 
            </td>
          </tr>
        </table>
        <div class="notibuttons">
          <input class="notiwritesub" type="submit" value="등록"/>
		  <a href="admin_notice.do?page=1">
            <input class="notibutton" type="button" value="취소"/>
         
          </a>	
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
		if(!nwrite.notice_title.value) {
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

 
