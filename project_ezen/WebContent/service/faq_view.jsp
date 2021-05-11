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
    <div>FAQ</div>
    <div>상세보기</div>
  </div>
  <!-- 현재위치표시 영역 끝 -->
  
  <!-- FAQ_view 영역 시작 --> 
  <div class="faq_view_wrap">
  
    <!-- FAQ상세보기 --> 
    <h4 class="faq_view_title"><small class="service_small">▌</small>FAQ</h4>
    <div class="faq_view_table">
       <div class="faq_view_table_top">
          <div class="faq_view_table_left">질문</div>
          <div class="faq_view_table_right">${dto.faq_title}</div>
       </div>
       <div class="faq_view_table_content">${dto.faq_content}</div>
    </div> 
    
    <!-- 버튼 --> 
    <input class="faq_view_btn" type="button" value="목록" onclick="location.href='/project_ezen/service/faq.do';"/>
    
  </div>
  <!-- FAQ 영역 끝 -->
  
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>

  <c:import url="/footer.jsp" />