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
	
	  <div class="mypage_header_img"></div>
<!-- 현재 위치 표시 -->
	<div class="where">
		<a href="/project_ezen/main.jsp">H</a>
		<div>헬스장소개</div>
		<div>헬스장소개</div>
	</div>
	

<!-- 섹션 영역 시작 -->
	<div class="health_wrap">
		<div class="he01_wrap">
			<div class="he01">
				<div class="he01_img_wrap">
					<div class="he01_img"></div>
				</div>
				<div class="he01_text">
				
					<h2>굿초이스 피트니스는?</h2> <br>
					<p>
						
					굿초이스 피트니스는 한번 선택을 하면<br>
					절대 후회하지 않는다는 뜻으로 이용해보시면<br> 
					혁신적인 스포츠센터란 것을 알게 되실것입니다.
					</p>
				</div>
			</div>
		</div>
		<div class="he02_wrap">
			<div class="he02">
				<div class="he02_text">
					<h2>고객을 위한 품격있는 운동기구</h2> <br>
					<p>
						고객님의 운동을 편안하고 효율적으로<br>
						하기위해 마련된 효과적인 운동기구와<br>
						고급스러운 시설로 최적의 편안함을<br>
						제공합니다.
					</p>
				</div>
				<div class="he02_img_wrap">
					<div class="he02_img"></div>
				</div>
			</div>
		</div>
		<div class="he03_wrap">
			<div class="he03">
				<div class="he03_img_wrap">
					<div class="he03_img"></div>
				</div>
				<div class="he03_text">
			
				<h2>차별화된 프로그램</h2> <br>
					<p>
					
						굿초이스 피트니스에 오시면<br> 
						헬스만 하는게 아닌 요가, 필라테스<br> 
						스크린골프, 줌바 등 다양한<br> 
						프로그램을 즐기실 수 있으며<br> 
						휴게실을 자유롭게 이용하실 수<br> 
						있습니다.				
					</p>
				</div>
			</div>
		</div>
	</div>


<!-- 섹션 영역 끝 -->
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>
	<c:import url="/footer.jsp" />	