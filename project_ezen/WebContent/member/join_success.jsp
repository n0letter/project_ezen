<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 가입 성공!!!</title>
	<link rel="stylesheet" href="/project_ezen/css/adminMem_style.css">
	<style>
		* {
			margin: 0; padding: 4px;	
		}
		.success_wrap {
			margin: 0 auto;
		}
		.join_success {
			position: relative; text-align: center;
		}
		.join_success h3 {
			color: #5467F5; margin-bottom: 15px;
		}
		.success_close {
			width: 70px; height: 30px; 
			position: absolute; left:41%; bottom: 15px;
			color: #fff; background: #5467F5; border: none;
			text-indent: 0px; outlind: none;
		}
	</style>
</head>
<body>
	<div class="success_wrap">
		<div class="join_success">
        	<image class="success_img" src="/project_ezen/img/member_image/join_success.png"></image>
        	<h3>축하합니다!<br>회원 가입에 성공하셨습니다!</h3> 
        	<p>저희 굿초이스 피트니스에 <br>가입해 주셔서 감사합니다.</p>
        	<p>더욱 멋진 서비스로 <br>고객님의 성원에 보답하겠습니다!</p>
        </div>
        <button class="success_close" onclick="window.close();">확인
	    	<!-- <a href="javascript:window.close();"></a> -->
	    </button>
    </div>
</body>
</html>