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
		<div>Group exercise</div>
	</div>

<!-- 섹션 영역 시작 -->
	<div class="gx_wrap">
		<div class="gx00">
			<i><h2>G.X는 굿초이스 이용권을 구매하신 회원 모두 무료로 이용하실 수 있습니다</h2></i>
		</div>
		<div class="gx01_wrap">
			<div class="gx01">
				<div class="gx01_img_wrap">
					<div class="gx01_img"></div>
				</div>
				<div class="gx01_text">
					<h2>필라테스</h2> <br>
					<p>
						부상당한 포로들의 건강과 재활을 위해 제 1차  <br>
						세계대전 당시 독일인 요제프 필라테스가 고안한  <br>
						운동법으로 간단한 스트레칭부터 다양한 동작을  <br>
						활용하여 통증 없이 근육 강화를 시켜주는  <br>
						전신운동입니다. 
					</p>
				</div>
			</div>
		</div>
		<div class="gx02_wrap">
			<div class="gx02">
				<div class="gx02_text">
					<h2>요가</h2> <br>
					<p>
						명상과 호흡, 스트레칭이 어우러져  <br>
						진행되응 운동으로 신체와 정신을  <br>
						함께 단련하여 심진 안정에 도움이  <br>
						되는 전신운동입니다.
					</p>
				</div>
				<div class="gx02_img_wrap">
					<div class="gx02_img"></div>
				</div>
			</div>
		</div>
		<div class="gx01_wrap">
			<div class="gx03">
				<div class="gx03_img_wrap">
					<div class="gx03_img"></div>
				</div>
				<div class="gx03_text">
					<h2>줌바댄스</h2> <br>
					<p>
						에어로빅에 라틴댄스를 섞은 줌바댄스, 쉽고 <br>
						반복적인 동작이 많으며 칼로리 소비가 커 <br>
						다이어트에 효과적인 운동입니다.
					</p>
				</div>
			</div>
		</div>
		<div class="gx02_wrap">
			<div class="gx04">
				<div class="gx04_text">
					<h2>스피닝</h2> <br>
					<p>
						강사의 리드에 따라 그룹 사이클링 훈련  <br>
						시스템으로 진행되며 신나는 음악과 함께  <br>
						다양한 방법으로 실내 자전거를 타며 그룹  <br>
						전체가 일체감을 느끼는 운동입니다. <br>
						유산소 운동과 근력 운동 모두 효과적이며 <br>
						스트레스 발산에도 도움이 됩니다. 
					</p>
				</div>
				<div class="gx04_img_wrap">
					<div class="gx04_img"></div>
				</div>
			</div>
		</div>
		<div class="gx01_wrap">
			<div class="gx05">
				<div class="gx05_img_wrap">
					<div class="gx05_img"></div>
				</div>
				<div class="gx05_text">
					<h2>다이어트 댄스</h2> <br>
					<p>
						비트감 있는 음악에 맞춰 쉽고 반복되는 동작을  <br>
						진행하여 자연스럽게 유산소 운동을 진행할 수  <br>
						있습니다. 열량 소모가 크기 때문에 다이어트와  <br>
						전신 운동에 효과적인 운동입니다.
					</p>
				</div>
			</div>
		</div>
		<div class="gx02_wrap">
			<div class="gx06">
				<div class="gx06_text">
					<h2>바디스컬트</h2> <br>
					<p>
						덤벨이나 스텝박스 등 소도구를 활용하여 지도   <br>
						강사님의 동작에 맞춰서 진행하는 전신 근력   <br>
						운동입니다. 신나는 음악과 함께 진행되기   <br>
						때문에 남녀노소 누구나 즐겁게 하실 수  <br>
						있습니다.
					</p>
				</div>
				<div class="gx06_img_wrap">
					<div class="gx06_img"></div>
				</div>
			</div>
		</div>
	</div>
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>
	<script>
	// SCROLL EVENT
/* $(document).ready(function(){
    $(window).scroll(function() {
        var wScroll = $(this).scrollTop();

        if(wScroll > 100) {
            $('.scroll-top').addClass('is-showing');
        } else {
            $('.scroll-top').removeClass('is-showing');
        }
    });

    // SCROLL TOP BUTTON

    $('.scroll-top').on('click', function() {
        $('html, body').animate({scrollTop:0}, '2000', function() {
            $('.scroll-top').removeClass('is-showing');
        });
        return false;

    }); 
});
	 */
	</script>
<!-- 섹션 영역 끝 -->

	<c:import url="/footer.jsp" />	