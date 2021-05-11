<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
response.setHeader("Pragma", "no-cache"); 
response.setHeader("Cache-Control", "no-cache"); 
response.setHeader("Cache-Control", "no-store"); 
response.setDateHeader("Expires", 0L); 
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
  }else if(!member_id.equals("admin")) {
	response.sendRedirect("/project_ezen/main.do");
  }
  %>
  
  <div class="mypage_header_img"></div>  
  
  <!-- 현재위치표시 영역 시작 -->    
  <div class="where">
    <a href="/project_ezen/main.do">H</a>
    <div>고객센터</div>
    <div>FAQ</div>
  </div>
  <!-- 현재위치표시 영역 끝 -->
  
  <!-- admin_faq 영역 시작 -->
  <div class="admin_faq_wrap">
  
    <!-- 상단타이틀 -->
    <div class="admin_faq_title">
  	  <h4><small class="adminService_small">▌</small>FAQ리스트</h4>
  	</div>
  	
  	<!-- 표 -->
    <div class="admin_faq_table">
      <table class="admin_faq_table_wrap">
        <c:forEach var="dto" items="${ faq_list }"> 
          <tr onclick="location.href='/project_ezen/admin_service/adminfaq_view.do?faq_idx=${ dto.faq_idx }';" style="cursor:pointer;">
            <th>질문</th>
            <td>${ dto.faq_title }</td>
          </tr>
        </c:forEach>
      </table>
    </div>
    
    <!-- 버튼 -->
    <div>
      <input class="fwritebtn" type="button" value="글쓰기" onclick="location.href='/project_ezen/admin_service/adminfaq_write.jsp';"/>
    </div>
      
  </div>
  <!-- admin_faq 영역 끝 -->
  
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>

  <c:import url="/footer.jsp" />