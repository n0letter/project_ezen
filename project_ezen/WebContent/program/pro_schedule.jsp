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
		<div>Schdule</div>
	</div>

<!-- 섹션 영역 시작 -->
	<div class="schdule_wrap">
		<div class="sch_top">
			<h2>GOOD CHOICE FITNESS <br> 프로그램 시간표</h2>
		</div>		
		<div class="sch_section">
	 		
	        <div class="schedule1">
	        	<h3><span class="star01_img"></span> GX 프로그램</h3> 
	        	<table class="main_table">
	            	<tbody>
	                	<tr>
					        <th></th>
					        <td>월</td>
					        <td>화</td>
					        <td>수</td>
					        <td>목</td>
					        <td>금</td>
					        <td>토</td>
					        <td>일</td>
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
			
		
				<h3><span class="star01_img"></span> Special 프로그램</h3> 
			    <table class="main_table">
				    <tbody>
				      <tr>
				        <th></th>
				        <td>월</td>
				        <td>화</td>
				        <td>수</td>
				        <td>목</td>
				        <td>금</td>
				        <td>토</td>
				        <td>일</td>
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
		</div>
	</div>

  <!-- back-to-top -->
	<span class="scroll-top">
		<i class="fas fa-arrow-alt-circle-up"></i>
		<!-- <i class="fa fa-arrow-up" aria-hidden="true"></i> -->
	</span>	
<!-- 섹션 영역 끝 -->

	<c:import url="/footer.jsp" />	