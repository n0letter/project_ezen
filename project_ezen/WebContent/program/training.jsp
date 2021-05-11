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
	
	<div class="mypage_header_img">
    </div>
    
<!-- 현재 위치 표시 -->
	<div class="where">
		<a href="/project_ezen/main.do">H</a>
		<div>프로그램</div>
		<div>Training</div>
	</div>
	
<!-- 섹션 영역 시작 -->
	<div class="training_wrap">
		<div class="tr01_wrap">
			<div class="tr01">
				<div class="tr01_img"></div>
				<div class="tr01_text">
					<i>굿초이스만의 차별화된 <br>트레이닝 시스템</i> <br><br>
					<h3 class="tr_text_gcolor">
						굿초이스는 세계적으로 권위있는 <br> ACSM(미국 스포츠 의학회)을 <br>
						트레이닝 표준으로 삼아 <br> 회원분들에게 보다 체계적이고 <br>
						전문화된 트레이닝을 제공합니다. <br> 굿초이스의 트레이너는 ACSM 교육을 <br>
						이수하여 회원님들께 더욱 안전하고 <br> 효과적인 운동을 제공할 것을 <br>
						약속 드립니다. 
					</h3>
				</div>
			</div>
		</div>
		<div class="tr02">
			<div class="tr02_img"></div>
			<div class="tr02_text">
				<h1 class="tr_text_gcolor">ACSM 이란?</h1> <br>
				<p>
					미국 스포츠의학회 건강&피트니스 전문가를 인증하는 최초의 조직으로 <br>
					전 세계에서 명성과 권위를 갖고 있는 최고의 운동 과학 단체입니다.
				</p>
			</div>
		</div>
		<div class="tr01_wrap">
			<div class="tr03">
				<div class="tr03_img"></div>
				<div class="tr03_text">
					<h2 class="tr_text_gcolor">담당 트레이너 배정</h2> <br>
					<p>
						-시간대별 담당 트레이너 상주 <br>
						-운동, 식이, 생활 정보에 대한 멘토링
					</p>
				</div>
			</div>
			<div class="tr04">
				<div class="tr04_text">
					<h2 class="tr_text_gcolor">전문가와의 상담</h2> <br>
					<p>
						-체성분 분석, 자세 평가, 운동 목표에 따른 식이요법 제공 <br>
						-맞춤형 운동, 생활습관 등의 가이드 제시 <br>
						-매월 체성분 검사를 통한 운동 방향성  가이드 피드백 제공 
					</p>
				</div>
				<div class="tr04_img"></div>
			</div>
			<div class="tr05">
				<div class="tr05_img"></div>
				<div class="tr05_text">
					<h2 class="tr_text_gcolor">3:1 헬스코치</h2> <br>
					<p>
						-운동 기구 및 프리 웨이트 등의 관리 받고 싶은 부위 집중  <br>
						 &nbsp;트레이닝 무료 레슨 서비스 <br>
						-근력 운동에 관심 있는 회원님에게 추천 <br>
						-운동 방법, 하루 운동 스케쥴, 주간 운동 스케쥴에 대한 <br>
						 &nbsp;현실적인 운동 방법 제시
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