<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
response.setHeader("Pragma", "no-cache"); //HTTP 1.0
response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
response.setDateHeader("Expires", 0L); // Do not cache in proxy server
%>  
	<c:import url="/admin_header.jsp" />

<%
String member_idx = (String)session.getAttribute("member_idx");
String member_id = (String)session.getAttribute("member_id");
String uri = request.getRequestURI();
System.out.println("현재 주소:" + uri);
System.out.println("member_idx:" + member_idx);
if(uri.indexOf("admin") != -1 && member_idx == null) {
	response.sendRedirect("/project_ezen/member/loginForm.jsp");
} else if(!member_id.equals("admin")) {
	response.sendRedirect("/project_ezen/main.do");
}
%>
	<div class="mypage_header_img">
    </div>
    	
<!-- 현재 위치 표시 -->
	<div class="where">
		<a href="/project_ezen/main.jsp">H</a>
		<div>프로그램</div>
		<div>Schedule Modify</div>
	</div>

<!-- 섹션 영역 시작 -->
	<div class="schdule_wrap">
		<div class="sch_top">
			<h2>GOOD CHOICE FITNESS <br> 프로그램 시간표</h2>
		</div>		
		
		
		<div class="sch_section">
	
	        <div class="schedule1">
	        	<h3><span class="star01_img"></span> GX 프로그램</h3> 
	        	
	        	<form  method="post" name="schedule_update" action="schedule_update.do">
	        	<%--  <input type="hidden" name="schedule_idx" value="${member_idx}"/> --%>
	        	 <input type="hidden" name="gym_schedule_idx" value="${ dto.gym_schedule_idx }" />
		    	<input type="hidden" name="gym_schedule_content" value="${ dto.gym_schedule_content }" />
		    	
		   
	        	<table class="main_table">
	            	<tbody>
	                	<tr>
					        <th></th>
					        <td>SUN</td>
					        <td>TUE</td>
					        <td>WED</td>
					        <td>THU</td>
					        <td>FRI</td>
					        <td>SAT</td>
					        <td>SUN</td>
					    </tr>
				        <tr>
					        <th>AM10:00 <br>~10:50</th>
					        <td>
					        <input type="text" style="width:110%" name="gym_mon101"  
					        value="${ dto.gym_mon101 }">
					        </td>
					        <td><input type="text" style="width:110%" name="gym_tue101"  
					        value="${ dto.gym_tue101 }"></td>
					        <td><input type="text" style="width:110%" name="gym_wed101"  
					        value="${ dto.gym_wed101 }"></td>
					        <td><input type="text" style="width:110%" name="gym_thu101"  
					        value="${ dto.gym_thu101 }"></td>
					        <td><input type="text" style="width:110%" name="gym_fri101"  
					        value="${ dto.gym_fri101 }"></td>
					        <td><input type="text" style="width:110%" name="gym_sat101"  
					        value="${ dto.gym_sat101 }"></td>
					        <td><input type="text" style="width:110%" name="gym_sun101"  
					        value="${ dto.gym_sun101 }"></td>
						      </tr>
					     <tr>
					        <th>AM11:00 <br>~11:50</th>
					        <td>  <input type="text" style="width:110%" name="gym_mon102"  
					        value="${ dto.gym_mon102 }"></td>
					        <td><input type="text" style="width:110%" name="gym_tue102"  
					        value="${ dto.gym_tue102 }"></td>
					        <td><input type="text" style="width:110%" name="gym_wed102"  
					        value="${ dto.gym_wed102 }"></td>
					        <td><input type="text" style="width:110%" name="gym_thu102"  
					        value="${ dto.gym_thu102 }"></td>
					        <td><input type="text" style="width:110%" name="gym_fri102"  
					        value="${ dto.gym_fri102 }"></td>
					        <td><input type="text" style="width:110%" name="gym_sat102"  
					        value="${ dto.gym_sat102 }"></td>
					        <td><input type="text" style="width:110%" name="gym_sun102"  
					        value="${ dto.gym_sun102 }"></td>
					     </tr>
					     <tr>
					        <th>pm20:00 <br>~20:50</th>
					        <td><input type="text" style="width:110%" name="gym_mon103"  
					        value="${ dto.gym_mon103 }"></td>
					        <td><input type="text" style="width:110%" name="gym_tue103"  
					        value="${ dto.gym_tue103 }"></td>
					        <td><input type="text" style="width:110%" name="gym_wed103"  
					        value="${ dto.gym_wed103 }"></td>
					        <td><input type="text" style="width:110%" name="gym_thu103"  
					        value="${ dto.gym_thu103 }"></td>
					        <td><input type="text" style="width:110%" name="gym_fri103"  
					        value="${ dto.gym_fri103 }"></td>
					        <td><input type="text" style="width:110%" name="gym_sat103"  
					        value="${ dto.gym_sat103 }"></td>
					        <td><input type="text" style="width:110%" name="gym_sun103"  
					        value="${ dto.gym_sun103 }"></td>
					     </tr>
					     <tr>
					        <th>pm21:00 <br>~21:50</th>
					        <td><input type="text" style="width:110%" name="gym_mon104"  
					        value="${ dto.gym_mon104 }"></td>
					        <td><input type="text" style="width:110%" name="gym_tue104"  
					        value="${ dto.gym_tue104 }"></td>
					        <td><input type="text" style="width:110%" name="gym_wed104"  
					        value="${ dto.gym_wed104 }"></td>
					        <td><input type="text" style="width:110%" name="gym_thu104"  
					        value="${ dto.gym_thu104 }"></td>
					        <td><input type="text" style="width:110%" name="gym_fri104"  
					        value="${ dto.gym_fri104 }"></td>
					        <td><input type="text" style="width:110%" name="gym_sat104"  
					        value="${ dto.gym_sat104 }"></td>
					        <td><input type="text" style="width:110%" name="gym_sun104"  
					        value="${ dto.gym_sun104 }"></td>
					     </tr>
					   
					     
				    </tbody>
				</table>  
				
												<div class="admin_tmbtn6">
					<input class="tm_btnC" type="submit" value="수정"/>
				
					 </div>  
				  	</form>
			
           		
			
			
          			
				<h3><span class="star01_img"></span> Special 프로그램</h3> 
				<form  method="post" name="schedule2_update" action="schedule2_update.do">
			<!-- 	<input type="hidden" name="schedule2_idx" value="${member_idx}"/> -->
	        	 <input type="hidden" name="gym_schedule2_idx" value="${ dto2.gym_schedule2_idx }" />
		    	<input type="hidden" name="gym_schedule2_content" value="${ dto2.gym_schedule2_content }" />
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
				        <td><input type="text" style="width:110%" name="gym_mon201"  
					        value="${ dto2.gym_mon201 }"></td>
				        <td><input type="text" style="width:110%" name="gym_tue201"  
					        value="${ dto2.gym_tue201 }"></td>
				        <td><input type="text" style="width:110%" name="gym_wed201"  
					        value="${ dto2.gym_wed201 }"></td>
				        <td><input type="text" style="width:110%" name="gym_thu201"  
					        value="${ dto2.gym_thu201 }"></td>
				        <td><input type="text" style="width:110%" name="gym_fri201"  
					        value="${ dto2.gym_fri201 }"></td>
				        <td><input type="text" style="width:110%" name="gym_sat201"  
					        value="${ dto2.gym_sat201 }"></td>
				        <td><input type="text" style="width:110%" name="gym_sun201"  
					        value="${ dto2.gym_sun201 }"></td>
				      </tr>
				      <tr>
				        <th>AM11:00 <br>~11:50</th>
				        <td><input type="text" style="width:110%" name="gym_mon202"  
					        value="${ dto2.gym_mon202 }"></td>
				        <td><input type="text" style="width:110%" name="gym_tue202"  
					        value="${ dto2.gym_tue202 }"></td>
				        <td><input type="text" style="width:110%" name="gym_wed202"  
					        value="${ dto2.gym_wed202 }"></td>
				        <td><input type="text" style="width:110%" name="gym_thu202"  
					        value="${ dto2.gym_thu202 }"></td>
				        <td><input type="text" style="width:110%" name="gym_fri202"  
					        value="${ dto2.gym_fri202 }"></td>
				        <td><input type="text" style="width:110%" name="gym_sat202"  
					        value="${ dto2.gym_sat202 }"></td>
				        <td><input type="text" style="width:110%" name="gym_sun202"  
					        value="${ dto2.gym_sun202 }"></td>
				      </tr>
				      <tr>
				        <th>pm20:00 <br>~20:50</th>
				        <td><input type="text" style="width:110%" name="gym_mon203"  
					        value="${ dto2.gym_mon203 }"></td>
				        <td><input type="text" style="width:110%" name="gym_tue203"  
					        value="${ dto2.gym_tue203 }"></td>
				        <td><input type="text" style="width:110%" name="gym_wed203"  
					        value="${ dto2.gym_wed203 }"></td>
				        <td><input type="text" style="width:110%" name="gym_thu203"  
					        value="${ dto2.gym_thu203 }"></td>
				        <td><input type="text" style="width:110%" name="gym_fri203"  
					        value="${ dto2.gym_fri203 }"></td>
				        <td><input type="text" style="width:110%" name="gym_sat203"  
					        value="${ dto2.gym_sat203 }"></td>
				        <td><input type="text" style="width:110%" name="gym_sun203"  
					        value="${ dto2.gym_sun203 }"></td>
				      </tr>
				      <tr>
				        <th>pm21:00 <br>~21:50</th>
				        <td><input type="text" style="width:110%" name="gym_mon204"  
					        value="${ dto2.gym_mon204 }"></td>
				        <td><input type="text" style="width:110%" name="gym_tue204"  
					        value="${ dto2.gym_tue204 }"></td>
				        <td><input type="text" style="width:110%" name="gym_wed204"  
					        value="${ dto2.gym_wed204 }"></td>
				        <td><input type="text" style="width:110%" name="gym_thu204"  
					        value="${ dto2.gym_thu204 }"></td>
				        <td><input type="text" style="width:110%" name="gym_fri204"  
					        value="${ dto2.gym_fri204 }"></td>
				        <td><input type="text" style="width:110%" name="gym_sat204"  
					        value="${ dto2.gym_sat204 }"></td>
				        <td><input type="text" style="width:110%" name="gym_sun204"  
					        value="${ dto2.gym_sun204 }"></td>
				      </tr>
				     
				    </tbody>
			    </table> 
		 
		   									<div class="admin_tmbtn6">
					<input class="tm_btnC" type="submit" value="수정"/>
				
					 </div>  
		   		</form>
		   	
		 
		   
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