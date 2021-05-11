<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
response.setHeader("Pragma", "no-cache"); //HTTP 1.0
response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
response.setDateHeader("Expires", 0L); // Do not cache in proxy server
%>      
    <c:import url="/header.jsp" />
      <div class="mypage_header_img"></div>

<!-- 현재 위치 표시 -->
   <div class="where">
      <a href="/project_ezen/main.do">H</a>
      <div>커뮤니티</div>
      <div>공지사항</div>
   </div>



  <!-- notice_view 영역 시작 -->
  <div class="review_view_wrap">
  
    <!-- 상단타이틀 -->
    <div class="review_write_title">
  	  <h4><small class="service_small">▌</small>공지사항 상세보기</h4>
  	</div>
  
    <!-- 공지사항 내용 -->
    <div class="review_view_content">

      <table class="review_view_table">
	    <tr>	    
		  <th colspan="1" class="review_view_th01">제목</th>
		  <td colspan="3" class="review_view_td01">${dto.notice_title}</td>	
		  <th class="review_view_th02">작성자</th>
		  <td class="review_view_td02">${dto.notice_name}</td>	  
		</tr>
		<tr>	      
		  <th class="review_view_th01">작성일</th>
		  <fmt:formatDate value="${dto.notice_date}" pattern="yyyy-MM-dd HH:mm:ss" var="reg" />
		  <td class="review_view_td03">${reg}</td>	
		  <th class="review_view_th03">조회수</th>
		  <td class="review_view_td04">${dto.notice_hit}</td>	
		  <td colspan="2" class="review_view_tdN"></td> 
		</tr>
		<tr class="review_view_bottom">
		  <td colspan="6">
		    <div class="reContent" style="white-space:pre;">
		      <span>${dto.notice_content}</span>
		    </div> 
		  </td>
        </tr>
	  </table>
               
   </div>
       <!-- 목록보기 -->
      <div class="notice_list_wrap"> 
		  <input type="button" class="notice_list" value="목록" 
		  onClick="location.href='/project_ezen/community/notice.do?page=1'"/>
 	  </div>	
  </div>
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>   
   
   
   <c:import url="/footer.jsp" />