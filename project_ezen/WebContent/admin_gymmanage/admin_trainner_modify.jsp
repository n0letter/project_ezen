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
		<div>트레이너 수정</div>
	</div>
  
  <!-- 현재위치표시 영역 끝 -->
  
   <!-- trainner_modify 영역 시작 -->
  <div class="trainner_modify_wrap">
  <div class="admin_tmsection">
	<div class="admin_tmsection_section-text1"><small class="admin_tm_small">▌</small>트레이너 소개</div>
     	
     	<form  action="trainner_modify.do" method="post" name="trainner_modify"  onsubmit="return checkImg()">
			<input type="hidden" name="trainner_idx" value="${ dto.trainner_idx }" />
			<table width="100%" class="admin_tmtable">
                <tbody>
                  <tr>
                    <td class="admin_tm_form-left">제목</td>
                    <td class="admin_tm_form-right1">
               <input class="trainner_int" type="text" name="trainner_int" value="${ dto.trainner_int }">
                    
                    </td>
                  </tr>
            	  <tr style="border-top: none;">
            	  	<td class="admin_tm_form-left" style="border-top: none;">트레이너 사진</td>
            	  	<td class="admin_tm_form-right1" style="border-top: none;">
            	      <input name="trainnerImg" type="text" class="trainner_int" readonly="readonly" title="File Route" id="file_route1" value="">
		              <label>찾아보기<input type="file" name="filename" onchange="javascript:document.getElementById('file_route1').value=this.value">
		              </label>
		            </td>
            	  </tr>            
                  <tr>
                    <td class="admin_tm-left">소개</td>
                    <td class="admin_tm-right">
                    	<textarea class="trainner_modify_textarea" name="trainner_content" class="" cols="52"> ${ dto.trainner_content } </textarea>
  					</td>
                  </tr>
                 
		        </tbody>
		     </table>
      
			 <input class="tm_btnC" type="button" name="tm_btnC" value="수정" onClick="getPost('01'),getPost('02')"/>
			 <a href="/project_ezen/admin_gymmanage/admin_trainner.do?trainner_idx=${dto.trainner_idx }">
			 <input class="tm_btnC" type="button" name="tm_btnD" value="목록으로"/> </a>
 		 </form>
    	
    </div>
  </div>
 
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>  
  <script> 
function getPost(mode) { 
	var theForm = document.trainner_modify; 
	
	if(!theForm.trainner_int.value) { 
		alert("제목을 입력해주세요");
		theForm.trainner_int.focus();
		return false;
		
	} else if(!theForm.trainnerImg.value) {
		alert("사진을 선택해 주세요");
		theForm.trainnerImg.focus();
		return false;
	} else {
		if(mode == "01") { 
			theForm.method = "post"; 
			theForm.target = "_self"; 
			theForm.action = "trainner_modify.do"; 
		} 

		else if(mode == "02") { 
			theForm.method = "post"; 
			theForm.target = "_blank"; 
			theForm.enctype = "multipart/form-data"
			theForm.action = "fileupload.do" 
		} 
		theForm.submit(); 
	}
	
	
} 
	</script>
  
	<!-- trainner_modify 영역 끝 -->


  <c:import url="/footer.jsp" />