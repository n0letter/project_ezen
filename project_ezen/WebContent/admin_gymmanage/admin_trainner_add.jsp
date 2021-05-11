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
 	<div class="mypage_header_img">
    </div>
    	
<!-- 현재 위치 표시 -->
	<div class="where">
		<a href="/project_ezen/main.jsp">H</a>
		<div>헬스장 관리</div>
		<div>트레이너 추가</div>
	</div>
  
  <!-- 현재위치표시 영역 끝 -->
  
   <!-- trainner_modify 영역 시작 -->
  <div class="trainner_modify_wrap">
  <div class="admin_tmsection">
	<div class="admin_tmsection_section-text1"><small class="admin_tm_small">▌</small>트레이너 소개</div>
      
      	<form action="trainner_write.do" method="post" name="trainner_add">
      <table width="100%" class="admin_tmtable">
                <tbody>
                  <tr>
                    <td class="admin_tm_form-left">제목</td>
                    <td class="admin_tm_form-right1">
              <input class="trainner_int" type="text" name="trainner_int" value="">
                 		
                    </td>
                  </tr>
            
                  <tr>
                    <td class="admin_tm-left">트레이너 소개</td>
                    <td class="admin_tm-right">
                      <textarea class="trainner_modify_textarea" name="trainner_content" cols="52"></textarea>
                    </td>
                  </tr>
               </tbody>
      </table>
      		
      		<input class="tm_btnC" type="button" name="tm_btnC" value="추가" onClick="getPost('01'),getPost('02')"/>
         	<a href="/project_ezen/admin_gymmanage/admin_trainner.do?trainner_idx=${dto.trainner_idx }"><input class="tm_btnC" type="button" name="tm_btnB" value="목록으로"/></a>
     		<div class="admin_tmfileup">
     		<input type="file" name="filename" />
     	
     		</div>
     </form>
    
    </div>
  </div>
  
	<!-- trainner_modify 영역 끝 -->
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>	
	
<script> 
function getPost(mode) { 
	var theForm = document.trainner_add; 
	if(mode == "01") 
	{ theForm.method = "post"; 
	theForm.target = "_self"; 
	theForm.action = "trainner_write.do"; } 

	else if(mode == "02") 
{ theForm.method = "post"; 
theForm.target = "_blank"; 
theForm.enctype = "multipart/form-data"
theForm.action = "fileupload.do" } 
theForm.submit(); } 
	</script>


  <c:import url="/footer.jsp" />