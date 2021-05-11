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
  </div>
  <!-- 현재위치표시 영역 끝 -->
     
  <!-- FAQ 영역 시작 -->   
  <div class="faq_wrap">
  
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
    
    <!-- FAQ 목록 -->
    <div class="faq_content">
      <h4 class="faq_title"><small class="service_small">▌</small>FAQ</h4>
      <table class="faq_table">
        <c:forEach var="dto" items="${ faq_list }"> 
          <tr onclick="location.href='/project_ezen/service/faq_view.do?faq_idx=${ dto.faq_idx }';" style="cursor:pointer;">
            <th>질문</th>
            <td>${ dto.faq_title }</td>
          </tr>
        </c:forEach>
      </table>
    </div>
    
  </div> 
  <!-- FAQ 영역 끝 -->
  
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>

  <c:import url="/footer.jsp" />