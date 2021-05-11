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
		<div>P.T</div>
	</div>

<!-- 섹션 영역 시작 -->
	<div class="PT_wrap">
		<div class="pt01_wrap">
			<div class="pt01">
				<div class="pt01_img_wrap">
					<div class="pt01_img"></div>
					<p>
						ACSM(미국 스포츠 의학회) 공식 인증 등 <br>
						각종 트레이닝 전문 교육을 이수한 <br>
						굿초이스 트레이너로부터 체계적인 <br>
						퍼스널 트레이닝을 받아 보세요!
					</p>
				</div>
				<div class="pt01_text">
					<h2>P.T란 무엇인가?</h2> <br>
					<p>
						개인의 신체적 조건과 라이프 스타일에 <br>
						최적화하여 <br>
						쳬계적인 트레이닝이 이루어지는 과정을 <br>
						의미합니다. <br>
						굿초이스의 퍼스널 트레이너는 <br>
						회원의 신체적 조건과 운동 목적에 맞게 식단 <br>
						관리부터 체형 교정 및 생활 습관 개선까지 <br>
						회원이 보다 나은 하루를 맞이할 수 있도록 <br>
						전반적인 헬스케어 서비서를 제공합니다.
					</p>
				</div>
			</div>
		</div>
		<div class="pt02_wrap">
			<div class="pt02">
				<div class="pt02_text">
					<h2>PT/Rehabilitation</h2> <br>
					<p>
						굿초이스에서는 체형 분석 및 운동 처방 <br>
						전문가가 최신 측정 장비를 통한 신체 구성 및 <br>
						체형 분석, 체력 검사를 진행하여 <br>
						굿초이스에서 독자적으로 개발한 개인별 맞춤 <br>
						운동 프로그램을 디자인해 드립니다.
					</p>
				</div>
				<div class="pt02_img_wrap">
					<div class="pt02_img"></div>
				</div>
			</div>
		</div>
		<div class="pt01_wrap">
			<div class="pt03">
				<div class="pt03_img_wrap">
					<div class="pt03_img"></div>
				</div>
				<div class="pt03_text">
					<h2>전문적이고 체계적인 <br>
					                         Personal Training System
					</h2> <br>
					<p>
						개인의 운동 목적은 물론 건강 상태와 체력 <br>
						수준을 고려한 프로그램으로 과학적 분석을 <br>
						통해 가장 적합한 운동 프로그램 및 <br>
						영양 프로그램을 제공하며 모든 프로그램은 <br>
						전문 트레이너와 1:1 수업으로 진행됩니다.
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
	