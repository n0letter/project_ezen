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
		<div>Special course</div>
	</div>

<!-- 섹션 영역 시작 -->
	<div class="spe_wrap">
		<div class="spe00">
			<i><h2>Special Course</h2></i>
		</div>
		<div class="spe01_wrap">
			<div class="spe01">
				<div class="spe01_img_wrap">
					<div class="spe01_img"></div>
				</div>
				<div class="spe01_text">
					<h2>스크린 골프/실내 골프</h2> <br>
					<p>
						최첨담 GDR 스윙 분석기를 통한 정확한 스윙 분석이   <br>
						가능한 시설로 완비되어 있는 굿초이스에서  <br>
						합리적인 비용으로 골프 이용권 등록 시   <br>
						무료 레슨과 실내 골프 연습장 & 스크린 골프  <br>
						시설을 이용하실 수 있으며 골프 이용 시 <br>
 						헬스 + G.X 시설을 무료로 이용하실 수 있습니다. 
					</p>
				</div>
			</div>
		</div>
		<div class="spe02_wrap">
			<div class="spe02">
				<div class="spe02_text">
					<h2>필라테스</h2> <br>
					<p>
						50분 동안 1명의 강사와 1:1로 리포머,   <br>
						캐딜락, 체어 등 기구를 활용하며   <br>
						근력 증진과 척추 및 관절의 분절, 교정에  <br>
						도움이 되는 운동입니다.
					</p>
				</div>
				<div class="spe02_img_wrap">
					<div class="spe02_img"></div>
				</div>
			</div>
		</div>
		<div class="spe01_wrap">
			<div class="spe03">
				<div class="spe03_img_wrap">
					<div class="spe03_img"></div>
				</div>
				<div class="spe03_text">
					<h2>그룹 P.T</h2> <br>
					<p>
						개인 레슨 가격에 부담을 느끼거나 혼자하는  <br>
						운동으로는 운동량이 부족하신 분들을 <br>
						소규모로 모아 보다 합리적인 가격으로 <br>
						진행되는 P.T 프로그램입니다. 
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