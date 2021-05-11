<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> session logout </title>
</head>
<body>
	<%
		session.invalidate();
	    String referer = request.getHeader("referer");
		System.out.println("이전 주소" + referer); 
		/* 이렇게 안 한 경우, 로그인한 직후 메인 페이지에서 로그아웃하면 로그인페이지로 이동함 */
		if(referer.indexOf("mypage") != -1 || referer.indexOf("admin") != -1) {
			response.sendRedirect("/project_ezen/member/loginForm.jsp");
		} else if(referer.indexOf("review") != -1){
			response.sendRedirect("/project_ezen/member/loginForm.jsp");
		} else {
			response.sendRedirect(referer); 
		}  
	%>
	<script>
	/* 로그아웃 시 다른 페이지로 이동하지 않는다 */
		/* location.href = document.referrer;  */
	</script>
</body>
</html>