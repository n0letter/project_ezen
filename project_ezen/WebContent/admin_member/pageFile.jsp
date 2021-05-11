<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <%@ page import="dto.MemberDto" %>
<%@ page import="java.util.ArrayList"%> --%>
<%
response.setHeader("Pragma", "no-cache"); //HTTP 1.0
response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
response.setDateHeader("Expires", 0L); // Do not cache in proxy server
%>  
	<c:import url="/admin_header.jsp" />

<%
String member_idx = (String)session.getAttribute("member_idx");
String uri = request.getRequestURI();
String referer = request.getHeader("referer");
System.out.println("이전 주소" + referer); 
System.out.println("현재 주소:" + uri);
System.out.println("member_idx:" + member_idx);
if(uri.indexOf("admin") != -1 && member_idx == null) {
	response.sendRedirect("/project_ezen/member/loginForm.jsp");
}
System.out.println("임시페이지");
int page1 = 1;

/* int lastPage = (Integer)request.getAttribute("lastPage");
ArrayList<MemberDto> member_list = (ArrayList<MemberDto>)request.getAttribute("member_list");
request.setAttribute("lastPage", lastPage);
request.setAttribute("member_list", member_list); */ 

response.sendRedirect("/project_ezen/admin_member/member_list.do?page="+page1);
%>


</body>
</html>