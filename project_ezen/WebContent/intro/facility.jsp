<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
response.setHeader("Pragma", "no-cache"); //HTTP 1.0
response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
response.setDateHeader("Expires", 0L); // Do not cache in proxy server
%>      
  <c:import url="/header.jsp" />
    
  <!-- 현재위치표시 영역 시작 -->  
  
  <div class="mypage_header_img"></div>
  
  <div class="where">
    <a href="/project_ezen/main.jsp">H</a>
    <div>헬스장소개</div>
    <div>시설소개</div>
  </div>



 	<div class="facility_wrap">						
		
				
		<div class="fac01_wrap">
			<div class="fac01">
				<div class="fac01_img_wrap">
					<div class="fac01_img"></div>
				</div>
				<div class="fac02_img_wrap">
					<div class="fac02_img"></div>
				</div>
				<div class="fac03_img_wrap">
					<div class="fac03_img"></div>
					
				</div>
			</div>
		</div>
			
		<div class="fac04_wrap">
			<div class="fac04">
				<div class="fac04_img_wrap">
					<div class="fac04_img"></div>
						</div>
					<div class="fac05_img_wrap">
					<div class="fac05_img"></div>
						</div>
					<div class="fac06_img_wrap">
					<div class="fac06_img"></div>
				</div>
				</div>
				</div>
				
						<div class="fac07_wrap">
			<div class="fac07">
				<div class="fac07_img_wrap">
					<div class="fac07_img"></div>
					</div>
					<div class="fac08_img_wrap">
					<div class="fac08_img"></div>
					</div>
					<div class="fac09_img_wrap">
					<div class="fac09_img"></div>
				</div>
				</div>
				</div>
	
  	<!-- mypage 영역 끝 -->
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>
  <c:import url="/footer.jsp" />