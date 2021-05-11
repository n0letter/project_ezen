<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
  <title>메인 페이지</title>
    
    <link rel="stylesheet" href="/project_ezen/css/main_style.css">
	<link rel="stylesheet" href="/project_ezen/css/program_style.css">
    <link rel="stylesheet" href="/project_ezen/css/payment_style.css">
    <link rel="stylesheet" href="/project_ezen/css/Mypage_style.css">
    <link rel="stylesheet" href="/project_ezen/css/notice_style.css">
    <link rel="stylesheet" href="/project_ezen/css/border_style.css">
    <link rel="stylesheet" href="/project_ezen/css/service_style.css">
    <link rel="stylesheet" href="/project_ezen/css/intro_style.css">
    <link rel="stylesheet" href="/project_ezen/css/trainner_modify_style.css">
    <link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">
        
    <!-- 달력 -->
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
    
    <!-- css새로 만들 때마다 추가 기입해야 함 -->
    <style>
	   @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap');
    </style>
    <script type="text/javascript" src="/project_ezen/js/join_check.js"></script>
	<!-- <script type="text/javascript" src="/project_ezen/js/jquery-ui.min.js"></script>
	<script type="text/javascript" src="/project_ezen/js/jquery.min.js"></script> -->
	<script type="text/javascript" src="/project_ezen/js/backToTop.js"></script>
<!--  	<script>
		var url = window.location.href
			substring = "login";

		if (self.name != 'reload' && url.indexOf(substring) == -1 ) {
		    self.name = 'reload';
		    self.location.reload(true);
		}
		else self.name = '';  
	 </script> -->
<script>
var zoomx = 100;
  $(document).ready(function() {
    $(".gnb").hover(
      function() {
        $(".snb").stop().slideDown(400);
      },
      function() {
        $(".snb").stop().slideUp(600);
      }
    );

    $(".snb").hover(
      function() {
        $(".snb").stop().slideDown(400);
      },
      function() {
        $(".snb").stop().slideUp(600);
      }
    );

    $(".tabBtn").hover(
      function() {

        $(this).children(".icon_normal").css("display","none");
        $(this).children(".icon_over").css("display","block");
      },
      function() {
        $(this).children(".icon_over").css("display","none");
        $(this).children(".basic").css("display","block");
      }
    );

    $(".tabBtn").click(
      function() {

        $("."+$(this).attr("tarx")).children(".icon_normal").addClass("basic");
        $("."+$(this).attr("tarx")).children(".icon_over").removeClass("basic");
        $(this).children(".icon_over").addClass("basic");
        $(this).children(".icon_normal").removeClass("basic");

        $("."+$(this).attr("tarx")).children(".icon_over").css("display","none");
        $("."+$(this).attr("tarx")).children(".icon_normal").css("display","none");
        $("."+$(this).attr("tarx")).children(".basic").css("display","block");


        $("."+$(this).attr("tarc")).css("display","none");
        $("#"+$(this).attr("tar")).css("display","block");

        $("#"+$(this).attr("tarmc")).attr("href", $(this).attr("tarm"));

      }
    );

	//class="tabBtn tabBtngroupA" tar="lastA_1" tarc="lastA_1" tarx="tabBtngroupA"
	  });
	function body_zoomin() {
	  zoomx = zoomx + 10;
	  $("body").css("zoom",zoomx + "%");
	}
	function body_zoomout() {
	  zoomx = zoomx - 10;
	  $("body").css("zoom",zoomx + "%");
	}
	function body_zoomdef() {
	  zoomx = 100;
	  $("body").css("zoom",zoomx + "%");
	}
	function newWin(url,w,h) {
	window.open
	(url,'new_win','width='+w+',height='+h+',toolbars=no,menubars=no,scrollbars=auto');
	}
</script>

</head>
<body>
<div id="wrap">
  <div class="top">
    <div class="topMenu">
      <span class="home"><a href="/project_ezen/main.do">HOME</a></span>
	  
	  <%
	    String member_idx = (String)session.getAttribute("member_idx");
	    String member_name = (String)session.getAttribute("member_name");
		String member_id = (String)session.getAttribute("member_id");  
	    /* String member_phone = (String)session.getAttribute("member_phone");
	    String member_email = (String)session.getAttribute("member_email"); */ 
	    
	    
		//null체크
		if( member_idx != null  &&  !member_id.equals("admin") ) 
		{
			//로그인 상태
	  %>
	  	<input type="hidden" name="member_idx" value="${ member_idx }" />
	  	
	    <span onclick="location.href='/project_ezen/mypage/Mypage.do?member_idx=${member_idx}';" style="cursor:pointer; color: #5467F5;">
	    <%= member_name %>님&nbsp;
	    	<a href="/project_ezen/mypage/Mypage.do?member_idx=${member_idx}">마이페이지</a>
	    </span>
		<span><a href="/project_ezen/member/logout.jsp">로그아웃</a></span>
	  <%
		} else if(member_idx != null && member_id.equals("admin") ) {
	  %>
		<span onclick="location.href='/project_ezen/admin_member/member_list.do?member_name=${member_name}&page=1';" style="cursor:pointer; color: #5467F5;">
	    <%= member_name %>님&nbsp;
	    	<a href="/project_ezen/admin_member/member_list.do?member_name=${member_name}&page=1">관리자페이지</a>
	    </span>
		<span><a href="/project_ezen/member/logout.jsp">로그아웃</a></span>
	  <%
		} else {
	  %>
		<span><a href="/project_ezen/member/loginForm.jsp">로그인</a></span>
        <span><a href="/project_ezen/member/join_agree.jsp">회원가입</a></span>
	  <%
		}
	  %>   
    </div>
  </div>
  <!-- 네비 -->

    <!--top-->
<div class="navi" style="/* float:left; */ width:100%; height:150px; position:absolute;">
  <div class="gnb" style="width:100%; height:150px; margin:0 auto; border-bottom: 6px solid #5467F5; ">
 <!--    <h1 style="float:left; margin:50px 0 0; margin-right: 0px;"> -->
<!--  	<div class="logo"> -->
  
  	
<!--   </div> -->
<!--     </h1> -->
    <ul class="gnb_list" style="/* float:center;  */margin:0px 0 0; padding:0; width:100%; list-style:none; font-size: 26px;">
      <li style="float:left;margin-right:30px; width:230px;"><a href="/project_ezen/main.do"><img src="/project_ezen/img/main_img/LOGO_003.png" alt="로고"></a></li>
     
      <li style="float:left;margin-right:10px; width:180px;"><a href="/project_ezen/intro/health.jsp">헬스장소개</a> </li>
      <li style="float:left;margin-right:10px; width:180px;"><a href="/project_ezen/program/training.jsp">프로그램</a></li>
      <li style="float:left;margin-right:10px; width:180px;"><a href="/project_ezen/payment/guide.jsp">온라인결제</a></li>
      <li style="float:left;margin-right:10px; width:180px;"><a href="/project_ezen/community/notice.do?page=1">커뮤니티</a></li>
      <li style="float:left;margin-right:10px; width:180px;"><a href="/project_ezen/service/inquiry.jsp">고객지원</a></li>
    </ul>
  </div>
  
  <div class="snb" style="display: none;">
      <ul style="width:100%; height:158px; margin:0px 0 0 268px; padding:0; list-style:none; color:white; letter-spacing:-0.07em; text-align:center;">
        <li style="width:250px; height:178px;margin-right:-70px;">																			
          <ul class="navint" style="width:114px; margin-top:20px; padding:0; list-style:none;"> 
            <li style="margin:0 0 15px;"><a href="/project_ezen/intro/health.jsp">헬스장소개</a></li>
            <li style="margin:0 0 15px;"><a href="/project_ezen/intro/facility.jsp">시설소개</a></li>
            <li style="margin:0 0 15px;"><a href="/project_ezen/intro/trainner.do">트레이너소개</a></li>
          </ul>
        </li>
        <li style="width:250px; height:178px;margin-right:-70px;">
          <ul style="width:105px; margin-top:20px; padding:0; list-style:none; ">
            <li style="margin:0 0 15px;"><a href="/project_ezen/program/training.jsp">Trainning</a></li>
            <li style="margin:0 0 15px;"><a href="/project_ezen/program/PT.jsp">P.T</a></li>
            <li style="margin:0 0 15px;"><a href="/project_ezen/program/group_exercise.jsp">GroupExercise</a></li>
            <li style="margin:0 0 15px;"><a href="/project_ezen/program/special_course.jsp">SpecialCourse</a></li>
            <li style="margin:0 0 15px;"><a href="/project_ezen/program/pro_schedule.do">Schedule</a></li>

          </ul>
        </li>
        <li style="width:250px; height:178px;margin-right:-70px;">
          <ul class="navpay" style="width:105px; margin-top:20px; padding:0; list-style:none; ">
            <li style="margin:0 0 15px;"><a href="/project_ezen/payment/guide.jsp">온라인결제</a></li>
          </ul>
        </li>
        <li style="width:250px; height:178px;margin-right:-70px;">
          <ul class="navcom" style="width:105px; margin-top:20px; padding:0; list-style:none; ">
            <li style="margin:0 0 15px;"><a href="/project_ezen/community/notice.do?page=1">공지사항</a></li>
            <li style="margin:0 0 15px;"><a href="/project_ezen/community/event.do?page=1">이벤트</a></li>
            <li style="margin:0 0 15px;"><a href="/project_ezen/community/review.do?page=1">이용후기</a></li>
            <li style="margin:0 0 15px;"><a href="/project_ezen/community/recruitment.do?page=1">채용안내</a></li>
          </ul>
        </li>
        <li style="width:250px; height:178px; margin-right:-70px;">
          <ul class="navcus" style="width:105px; margin-top:20px; padding:0; list-style:none; ">
            <li style="margin:0 0 15px;"><a href="/project_ezen/service/inquiry.jsp">1:1문의</a></li><br>
            <li style="margin:0 0 15px;"><a href="/project_ezen/service/faq.do">FAQ</a></li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</div>
