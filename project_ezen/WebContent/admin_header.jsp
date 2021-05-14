<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
  <title>메인 페이지</title>
    
    <link rel="stylesheet" href="/project_ezen/css/main_style.css"> 
    <link rel="stylesheet" href="/project_ezen/css/admin_main_style.css">
    <link rel="stylesheet" href="/project_ezen/css/admin_trainner_modify_style.css">
    <link rel="stylesheet" href="/project_ezen/css/Mypage_style.css">
    <link rel="stylesheet" href="/project_ezen/css/adminMem_style.css">
    <link rel="stylesheet" href="/project_ezen/css/adminPay_style.css">
    <link rel="stylesheet" href="/project_ezen/css/adminService_style.css">
    <link rel="stylesheet" href="/project_ezen/css/admin_notice_style.css">
    <!-- css 아래 것도 가져옴 -->
    <link rel="stylesheet" href="/project_ezen/css/notice_style.css">
        
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
    <script type="text/javascript" src="/project_ezen/js/backToTop.js"></script>
	<!-- <script type="text/javascript" src="/project_ezen/js/jquery-ui.min.js"></script>
	<script type="text/javascript" src="/project_ezen/js/jquery.min.js"></script> -->
<!-- 	<script>
		if (self.name != 'reload') {
		    self.name = 'reload';
		    self.location.reload(true);
		}
		else self.name = '';
	</script> -->
<script>
var zoomx = 100;
  $(document).ready(function() {
    $(".admin_gnb").hover(
      function() {
        $(".admin_snb").stop().slideDown(400);
      },
      function() {
        $(".admin_snb").stop().slideUp(600);
      }
    );

    $(".admin_snb").hover(
      function() {
        $(".admin_snb").stop().slideDown(400);
      },
      function() {
        $(".admin_snb").stop().slideUp(600);
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
<%
	String fileFullPath = (String)request.getAttribute("fileFullPath");
%>
<body>
<div id="wrap">
  <div class="top">
    <div class="topMenu">
      <span class="home"><a href="/project_ezen/admin_member/member_list.do?member_name=${member_name}&page=1">HOME</a></span>
	  <%
	    String member_idx = (String)session.getAttribute("member_idx");
	    String member_name = (String)session.getAttribute("member_name");
		/* String member_id = (String)session.getAttribute("member_id");  */
	    /* String member_phone = (String)session.getAttribute("member_phone");
	    String member_email = (String)session.getAttribute("member_email"); */ 
	    
		//null체크
		if( member_idx != null) 
		{
			//로그인 상태
	  %>
	    <span onclick="location.href='/project_ezen/admin_member/member_list.do?member_name=${member_name}&page=1';" style="cursor:pointer; color: #5467F5;">
	    <%= member_name %>님&nbsp;
	     	<a href="/project_ezen/admin_member/member_list.do?member_name=${member_name}&page=1"></a> 
	    </span>
		<span><a href="/project_ezen/member/logout.jsp">로그아웃</a></span>
	  <%
		}
		else
		{
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
<div class="admin_navi" style="/* float:left; */ width:100%; height:150px; position:absolute;">
  <div class="admin_gnb" style="width:100%; height:150px; margin:0 auto; border-bottom: 6px solid #5467F5; ">
 <!--    <h1 style="float:left; margin:50px 0 0; margin-right: 0px;"> -->
<!--  	<div class="logo"> -->
<!--   </div> -->
<!--     </h1> -->
    <ul class="admin_gnb_list" style="/* float:center;  */margin:0px 0 0; padding:0; width:100%; list-style:none; font-size: 26px;">
      <li style="float:left;margin-right:30px; width:230px;"><a href="/project_ezen/main.do"><img src="/project_ezen/img/main_img/LOGO_003.png" alt="로고"></a></li>
     
      <li style="float:left;margin-right:10px; width:180px;"><a href="/project_ezen/admin_member/member_list.do?member_name=${member_name}&page=1">회원관리</a> </li>
      <li style="float:left;margin-right:10px; width:180px;"><a href="/project_ezen/admin_gymmanage/admin_trainner.do">헬스장관리</a></li>
      <li style="float:left;margin-right:10px; width:180px;"><a href="/project_ezen/admin_payment/admin_paymain.do">온라인결제관리</a></li>
      <li style="float:left;margin-right:10px; width:180px;"><a href="/project_ezen/admin_community/admin_notice.do?page=1">커뮤니티관리</a></li>
      <li style="float:left;margin-right:10px; width:180px;"><a href="/project_ezen/admin_service/admin_inquiry.do?page=1">고객센터관리</a></li>
    </ul>
  </div>
  
  <div class="admin_snb" style="display: none;">
      <ul style="width:100%; height:158opx; margin:0px 0 0 268px; padding:0; list-style:none; color:white; letter-spacing:-0.07em; text-align:center;">
        <li style="width:250px; height:178px;margin-right:-45px;">																			
          <ul class="admin_navint" style="width:105px; margin-top:20px; padding:0; list-style:none;"> 
            <li style="margin:0 0 15px;"><a href="/project_ezen/admin_member/member_list.do?member_name=${member_name}&page=1">회원리스트</a></li>
            <li style="margin:0 0 15px;"><a href="/project_ezen/admin_member/outMember_list.do?member_name=${member_name}&page=1">탈퇴회원<br>목록</a></li>
          </ul>
        </li>
        <li style="width:250px; height:178px;margin-right:-50px;">
          <ul class="admin_gym_ma" style="width:105px; margin-top:20px; padding:0; list-style:none; ">
            <li style="margin:0 0 15px;"><a href="/project_ezen/admin_gymmanage/admin_trainner.do">트레이너<br>수정</a></li>
            <li style="margin:0 0 15px;"><a href="/project_ezen/admin_gymmanage/admin_schedule.do?member_idx=${member_idx}">시간표수정</a></li>
          </ul>
        </li>
        <li style="width:300px; height:178px;margin-right:-110px;">
          <ul class="admin_navpay" style="width:105px; margin-top:20px; padding:0; list-style:none; ">
            <li style="margin:0 0 15px;"><a href="/project_ezen/admin_payment/admin_paymain.do">온라인결제관리</a></li>
          </ul>
        </li>
        <li style="width:220px; height:178px;margin-right:-40px;">
          <ul class="admin_navcom" style="width:105px; margin-top:20px; padding:0; list-style:none; ">
            <li style="margin:0 0 15px;"><a href="/project_ezen/admin_community/admin_notice.do?page=1">공지사항</a></li>
            <li style="margin:0 0 15px;"><a href="/project_ezen/admin_community/admin_event.do?page=1">이벤트</a></li>
            <li style="margin:0 0 15px;"><a href="/project_ezen/admin_community/adminReview.do?page=1">이용후기</a></li>
            <li style="margin:0 0 15px;"><a href="/project_ezen/admin_community/admin_recruitment.do?page=1">채용안내</a></li>
          </ul>
        </li>
        <li style="width:180px; height:178px; margin-right:-65px;">
          <ul class="admin_navcus" style="width:105px; margin-top:20px; padding:0; list-style:none; ">
            <li style="margin:0 0 15px;"><a href="/project_ezen/admin_service/admin_inquiry.do?page=1">1:1문의</a></li><br>
            <li style="margin:0 0 15px;"><a href="/project_ezen/admin_service/admin_faq.do">FAQ</a></li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</div>
