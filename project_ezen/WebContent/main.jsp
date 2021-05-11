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
    
<!-- 헬스관련 이미지 -->
  <div class="carousel-inner"> 
    <!-- 슬라이드 쇼 --> 
    <div class="carousel-item active"> <!--가로--> 
      <!-- <div class="d-block w-100" > --> 
      <div class="d-block w-100 main_big_img">
	      <div class="carousel-caption d-none d-md-block">
	        <h1>GOODCHOICE FITNESS</h1> <br>
	        <p>최고의 선택 굿초이스와 함께하세요.</p>
	      </div>
      </div>
    </div> 
  </div>
    

<!-- 후기 -->
<br><br>
<div class="product">
  <h1>Before&After</h1>
  <p>굿초이스 회원님의 리얼 다이어트 후기</p>
  <div id="pdAllWrap">
    <div class="pd-wrap">
      <a href="/project_ezen/notice/review.jsp">
        <div class="pd-img"><img src="http://www.hellogym.com/bizdemo42107/component/board/board_14/u_image/71/1232529263_EAB3A0EB8F99ED988420EC8DB8EB84A4EC9DBC-01.jpg" alt="">
        </div>
        <div class="pd-title">
        </div>
      </a>
    </div>
  
    <div class="pd-wrap">
      <a href="/project_ezen/notice/review.jsp">
        <div class="pd-img"><img src="http://www.hellogym.com/bizdemo42107/component/board/board_14/u_image/72/1066163157_EC9DB4EBAFB8ECA78420EC8DB8EB84A4EC9DBC-01.jpg" alt="">
        </div>
        <div class="pd-title">
        </div>
      </a>
    </div>

    <div class="pd-wrap">
      <a href="/project_ezen/notice/review.jsp">
        <div class="pd-img"><img src="http://www.hellogym.com/bizdemo42107/component/board/board_14/u_image/73/1363918959_EAB68CEAB8B0ECA09520EC8DB8EB84A4EC9DBC-01.jpg" alt="">
        </div>
        <div class="pd-title">
        </div>
      </a>
    </div>
    
    <div class="pd-wrap">
      <a href="/project_ezen/notice/review.jsp">
        <div class="pd-img"><img src="http://www.hellogym.com/bizdemo42107/component/board/board_14/u_image/75/873967950_ED9788EC9CA4ECA09520EC8DB8EB84A4EC9DBC-01.jpg" alt="">
        </div>
        <div class="pd-title">
        </div>
      </a>
    </div>
    
    <div class="pd-wrap">
      <a href="/project_ezen/notice/review.jsp">
        <div class="pd-img"><img src="http://www.hellogym.com/bizdemo42107/component/board/board_14/u_image/76/1552250578_EAB980EC8898EBAFB820EC8DB8EB84A4EC9DBC-01.jpg" alt="">
        </div>
        <div class="pd-title">
        </div>
      </a>
    </div>  
        
    <div class="pd-wrap">
      <a href="/project_ezen/notice/review.jsp">
        <div class="pd-img"><img src="http://www.hellogym.com/bizdemo42107/component/board/board_14/u_image/74/2020952978_EBB0B1ECA780ED989C20EC8DB8EB84A4EC9DBC-01.jpg" alt="">
        </div>
        <div class="pd-title">
        </div>
      </a>
    </div>
  </div>
</div>



  <br><br>

  <br>
<div id="sc1" class="tabcontent">
  <h1>Schedule</h1> <br>
  <div class="schedule1">
  <table class="main_table">
    <tbody>
      <tr>
        <th></th>
        <td>MON</td>
        <td>TUE</td>
        <td>WED</td>
        <td>THU</td>
        <td>FRI</td>
        <td>SAT</td>
        <td>SUN</td>
      </tr>
      <tr>
        <th>AM10:00 <br>~10:50</th>
        <td>${dto.gym_mon101 }</td>
        <td>${dto.gym_tue101 }</td>
        <td>${dto.gym_wed101 }</td>
        <td>${dto.gym_thu101 }</td>
        <td>${dto.gym_fri101 }</td>
        <td>${dto.gym_sat101 }</td>
        <td>${dto.gym_sun101 }</td>
      </tr>
      <tr>
        <th>AM11:00 <br>~11:50</th>
        <td>${dto.gym_mon102 }</td>
        <td>${dto.gym_tue102 }</td>
        <td>${dto.gym_wed102 }</td>
        <td>${dto.gym_thu102 }</td>
        <td>${dto.gym_fri102 }</td>
        <td>${dto.gym_sat102 }</td>
        <td>${dto.gym_sun102 }</td>
      </tr>
      <tr>
        <th>pm20:00 <br>~20:50</th>
        <td>${dto.gym_mon103 }</td>
        <td>${dto.gym_thu103 }</td>
        <td>${dto.gym_wed103 }</td>
        <td>${dto.gym_thu103 }</td>
        <td>${dto.gym_fri103 }</td>
        <td>${dto.gym_sat103 }</td>
        <td>${dto.gym_sun103 }</td>
      </tr>
      <tr>
        <th>pm21:00 <br>~21:50</th>
        <td>${dto.gym_mon104 }</td>
        <td>${dto.gym_thu104 }</td>
        <td>${dto.gym_wed104 }</td>
        <td>${dto.gym_thu104 }</td>
        <td>${dto.gym_fri104 }</td>
        <td>${dto.gym_sat104 }</td>
        <td>${dto.gym_sun104 }</td>
      </tr>
    </tbody>
  </table>  
</div>
</div>

<div id="sc2" class="tabcontent">
<h1>Schedule</h1> <br>
  <table class="main_table">
    <tbody>
      <tr>
        <th></th>
        <td>MON</td>
        <td>TUE</td>
        <td>WED</td>
        <td>THU</td>
        <td>FRI</td>
        <td>SAT</td>
        <td>SUN</td>
      </tr>
      <tr>
        <th>AM10:00 <br>~10:50</th>
         <td>${dto2.gym_mon201 }</td>
        <td>${dto2.gym_tue201 }</td>
        <td>${dto2.gym_wed201 }</td>
        <td>${dto2.gym_thu201 }</td>
        <td>${dto2.gym_fri201 }</td>
        <td>${dto2.gym_sat201 }</td>
        <td>${dto2.gym_sun201 }</td>
      </tr>
      <tr>
         <th>AM11:00 <br>~11:50</th>
        <td>${dto2.gym_mon202 }</td>
        <td>${dto2.gym_tue202 }</td>
        <td>${dto2.gym_wed202 }</td>
        <td>${dto2.gym_thu202 }</td>
        <td>${dto2.gym_fri202 }</td>
        <td>${dto2.gym_sat202 }</td>
        <td>${dto2.gym_sun202 }</td>
      </tr>
      <tr>
         <th>pm20:00 <br>~20:50</th>
        <td>${dto2.gym_mon203 }</td>
        <td>${dto2.gym_thu203 }</td>
        <td>${dto2.gym_wed203 }</td>
        <td>${dto2.gym_thu203 }</td>
        <td>${dto2.gym_fri203 }</td>
        <td>${dto2.gym_sat203 }</td>
        <td>${dto2.gym_sun203 }</td>
      </tr>
      <tr>
        <th>pm21:00 <br>~21:50</th>
        <td>${dto2.gym_mon204 }</td>
        <td>${dto2.gym_thu204 }</td>
        <td>${dto2.gym_wed204 }</td>
        <td>${dto2.gym_thu204 }</td>
        <td>${dto2.gym_fri204 }</td>
        <td>${dto2.gym_sat204 }</td>
        <td>${dto2.gym_sun204 }</td>
      </tr>
    </tbody>
  </table>  
</div>
<div class="scbtn">
<button class="tablink" onclick="openCity('sc1', this, 'black')" id="defaultOpen">GX프로그램</button>
<button class="tablink" onclick="openCity('sc2', this, 'black')">Special프로그램</button>
</div>

<div class="mapload">
  <h1>Location</h1>
  <br>
  <div class="map">
    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d789.6801588836383!2d127.06181167923162!3d37.655771410482814!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357cb941d9c739c5%3A0x8ecd52574c78556d!2z7J207KCg7JWE7Lm0642w66-47Lu07ZOo7YSw7ZWZ7JuQIOuFuOybkOy6oO2NvOyKpA!5e0!3m2!1sko!2skr!4v1610326407648!5m2!1sko!2skr" 
    width="100%" height="450"  frameborder="0" style="border:0;" allowfullscreen="" aria-hidden="false" tabindex="0"></iframe>
  </div>
  <br>
  <div class="load">
    <table>
      <tbody>
        <tr>
          <th>&nbsp&nbsp<img src="http://www.fareastsports.co.kr/img/ico_bus.png" alt=""> 4호선 노원역
            4호선 노원역 2번출구 도보 200m (4분) <br>
              <img src="http://www.fareastsports.co.kr/img/ico_subway.png" alt="">
            
                노원역2번출구 화랑빌딩
                143|147|148|240|351|362
          </th>
          <td><img src="http://www.fareastsports.co.kr/img/ico_taxi.png" alt="">
            서울시 노원구 상계로 64 화랑빌딩 굿초이스 피트니스 <br>
            &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp- 압구정 현대백화점 맞은편 위치 <br>
            &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp- 압구정로 → 압구정역 사거리 직진 300m → 현대고등학교 앞 유턴 → <br>
          </td>
        </tr>
      </tbody>
    </table>  
  </div>
  </div>
  <br>
  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>
	<c:import url="/footer.jsp" />

