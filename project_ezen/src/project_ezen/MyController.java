package project_ezen;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import communityDao.EventDao;
import communityDao.NoticeDao;
import communityDao.RecruitmentDao;
import communityDao.ReviewDao;
import communityDao.ReReplyDao;
import communityDto.EventDto;
import communityDto.NoticeDto;
import communityDto.RecruitmentDto;
import communityDto.ReviewDto;
import communityDto.ReReplyDto;
import gymManageDao.Schedule2Dao;
import gymManageDao.ScheduleDao;
import gymManageDao.TrainnerDao;
import gymManageDto.Schedule2Dto;
import gymManageDto.ScheduleDto;
import gymManageDto.TrainnerDto;
import memDao.MemberDao;
import memDao.OutMemberDao;
import memDto.MemberDto;
import memDto.OutMemberDto;
import serviceDao.FaqDao;
import serviceDao.InquiryDao;
import serviceDao.PayDao;
import serviceDto.FaqDto;
import serviceDto.InquiryDto;
import serviceDto.PayDto;

//@WebServlet(urlPatterns = { "/", "*.do" })
@WebServlet(urlPatterns = { "/" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, 
maxFileSize = 1024 * 1024 * 30, 
maxRequestSize = 1024 * 1024 * 50)
public class MyController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String requestURI = request.getRequestURI();
		int cmdIdx = requestURI.lastIndexOf("/") + 1;
		String command = requestURI.substring(cmdIdx);
		String jspPage = "";

		System.out.println("command:" + command);

		if (command.equals("") || command.equals("/")) {
			response.sendRedirect("main.do");
		}
		else if (command.equals("main.do")) { // 메인 페이지
			//메인페이지 스케줄 정보 불러오기
			ScheduleDto dto = ScheduleDao.scheduleViewmain(request);
			request.setAttribute("dto", dto);
			
			Schedule2Dto dto2 = Schedule2Dao.scheduleViewmain2(request);
			request.setAttribute("dto2", dto2);			

			jspPage = "/main.jsp";
		}

		
		
		// MyController.java

		// 약관 동의 액션 - hidden인 member_agree에 value값(Y, N) 주는 동작
		else if (command.equals("agreement.do")) {
			String marketing = request.getParameter("marketing");
			System.out.println("marketing Y N : " + marketing);

			if (marketing == null) {
				marketing = "N";
			}
			HttpSession session = request.getSession();
			session.setAttribute("check_agree", marketing);
			response.sendRedirect("/project_ezen/member/joinForm.jsp");
		}
		// 회원가입액션
		else if (command.equals("JoinAction.do")) {

			request.setCharacterEncoding("UTF-8");
			MemberDao.insertMember(request);

			response.sendRedirect("main.do");
		}
		// 아이디 중복 체크
		else if (command.equals("idCheckAjax.do")) {

			int result = 0;
			try {
				result = MemberDao.idCheck(request);
			} catch (Exception e) {
				e.printStackTrace();
			}

			if (result == 1) { // 아이디 중복됨
				response.getWriter().print("1");
			} else {
				response.getWriter().print("0");
			}

		}
		// 로그인 액션
		else if(command.equals("login.do")) { 
			request.setCharacterEncoding("UTF-8");

			String login_referer = request.getParameter("login_referer");
			System.out.println("login_referer :" + login_referer);

			HttpSession session = request.getSession();
			
			int loginResult = 0;
			try {
				loginResult = MemberDao.login(request);
				System.out.println("loginResult : " + loginResult);
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			if(loginResult == 2) {
				
				response.sendRedirect("/project_ezen/admin_member/pageFile.jsp");
			}
			else if (loginResult == 1) {
				
				if(login_referer.indexOf("find_id_pw") == -1 && login_referer.indexOf("admin") == -1) {
					response.sendRedirect(login_referer); 
				} else {
					response.sendRedirect("/project_ezen/main.do");
				}
				 
			} else {
				request.setAttribute("loginResult", loginResult);
				System.out.println("loginResult2 : " + loginResult);

				jspPage = "/member/loginForm.jsp";
			}

		}	
		//마이페이지 
		else if(command.equals("Mypage.do")) { 
			
			//DTO 레코드 정보
			MemberDto dto = MemberDao.Mypage( request );
			request.setAttribute("dto", dto);
			
			jspPage = "/mypage/Mypage.jsp";
		}
		//관리자 메인 페이지 - 회원 목록
		else if (command.contains("member_list.do")) { 
			int page = Integer.parseInt(request.getParameter("page"));
			int pageSize = 5;// 한페이지에 나오는 게시물 개수
			int pageGroupSize = 3; // 페이지 번호가 몇개 나오느냐 개수
			System.out.println("콘트롤러:"+page);
	        
			ArrayList<MemberDto> member_list = MemberDao.member_list(page); 
	        
	        int memberCount = MemberDao.member_count();//게시물 총 개수
	        System.out.println("memberCount:"+memberCount);
	       
	        int pageGroupCount = memberCount / (pageSize * pageGroupSize) 
	        		+ (memberCount % (pageSize * pageGroupSize) == 0 ? 0 : 1);//총 그룹개수
	        int nowPageGroup = (int) Math.ceil((double) page / pageGroupSize); //현재 그룹페이지 번호
	        
	        request.setAttribute("member_list", member_list);
	        request.setAttribute("pageSize", pageSize);
	        request.setAttribute("pageGroupSize", pageGroupSize);
	        request.setAttribute("memberCount", memberCount);
	        request.setAttribute("pageGroupCount", pageGroupCount);
	        request.setAttribute("nowPageGroup", nowPageGroup);
	        
			jspPage = "/admin_member/member_list.jsp";
		}
		//아이디 찾기 액션
		else if(command.equals("idFind.do"))
		{
			String id_find_failed = null;
			try 
			{
				id_find_failed = MemberDao.idFind(request);
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
			}
			if(id_find_failed.equals("failed")) {
				request.setAttribute("id_find_failed", id_find_failed);
				
				jspPage = "/member/find_id_pw.jsp";
			} else {
				//위의 코드로 페이지 이동시키면 뒤로가기 연타 시 세션 문제가 발생하므로 아래처럼 보내줘야 함 
				response.sendRedirect("/project_ezen/member/find_id_pw.jsp");
			}
		}
		//찾은 아이디 넘기기
		else if (command.equals("id_move")) {
			String finded_id = request.getParameter("finded_id");
			System.out.println("finded_id : " + finded_id);

			HttpSession session = request.getSession();
			session.setAttribute("finded_id",finded_id);
			response.sendRedirect("/project_ezen/member/loginForm.jsp");
		}
		//비밀번호 찾기 액션
		else if(command.equals("find_pw.do"))
		{
			String pw_find_failed = null;
			try 
			{
				String member_id = request.getParameter("find_id");
				String member_email = request.getParameter("find_mail02");
				System.out.println("name : "+member_id);
				System.out.println("email : "+member_email);
				
				pw_find_failed = MemberDao.find_pw(request);
				
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
			}
			if(pw_find_failed.equals("failed")) {
				request.setAttribute("pw_find_failed", pw_find_failed);
				
				jspPage = "/member/find_id_pw.jsp";
			} else {
				//위의 코드로 페이지 이동시키면 뒤로가기 연타 시 세션 문제가 발생하므로 아래처럼 보내줘야 함 
				response.sendRedirect("/project_ezen/member/find_id_pw.jsp");
			}
		}		
		//관리자 페이지 - 회원 개인 정보 상세 페이지 보기
		else if(command.equals("member_view.do")) { 
			
			MemberDto dto = MemberDao.admin_member_view( request );
			request.setAttribute("dto", dto);
			
			jspPage = "/admin_member/member_view.jsp";
		}
		//관리자 페이지 - 회원 삭제 액션
		else if(command.equals("mem_delete.do")) 
		{	
			MemberDao.mem_delete(request);
			
			response.sendRedirect("/project_ezen/admin_member/member_list.do?page=1");
			
		}
		//관리자 페이지 - 회원 수정 액션
		else if(command.equals("mvModify.do")) //비밀글 수정 update
		{
			MemberDao.member_modify(request);
			response.sendRedirect("/project_ezen/admin_member/member_list.do?page=1");
		}
		//마이페이지 - 개인정보 수정 페이지 보기
		else if(command.equals("mypage_modify.do")) { 
			
			//DTO 레코드 정보
			MemberDto dto = MemberDao.Mypage( request );
			request.setAttribute("dto", dto);
			
			jspPage = "/mypage/mypage_modify.jsp";
		}	
		//마이페이지 - 개인정보 수정 액션, 비번 확인 포함
		else if(command.equals("myMemModify.do"))  
		{
			String member_idx = request.getParameter("member_idx");
			HttpSession session = request.getSession();
			int pw_check_result = MemberDao.modify_pw(request);
			System.out.println("pw_check_result : " + pw_check_result);
			
			if(pw_check_result==1)
			{
				MemberDao.my_mem_modify(request);
				System.out.println("index : "+member_idx);
				response.sendRedirect("/project_ezen/mypage/Mypage.do?member_idx="+member_idx);
			}
			else 
			{
				session.setAttribute("pw_check_result", pw_check_result);
				System.out.println("pw_check_result : " + pw_check_result);
				
				response.sendRedirect("/project_ezen/mypage/mypage_modify.do?member_idx="+member_idx);
			}
			
		}
		//마이페이지 - 비밀번호 수정 페이지 보기
		else if(command.equals("password.do")) { 
			
			MemberDto dto = MemberDao.Mypage( request );
			request.setAttribute("dto", dto);
			
			jspPage = "/mypage/password.jsp";
		}	
		//마이페이지 - 비밀번호 수정 액션(비번 확인 포함)
		else if(command.equals("myPwModify.do"))  
		{
			String member_idx = request.getParameter("member_idx");
			HttpSession session = request.getSession();
			int pw_check_result = MemberDao.modify_pw(request);
			System.out.println("pw_check_result : " + pw_check_result);
			
			if(pw_check_result==1)
			{
				MemberDao.myPwModify(request);
				System.out.println("index : "+member_idx);
				response.sendRedirect("/project_ezen/mypage/Mypage.do?member_idx="+member_idx);
			}
			else 
			{
				session.setAttribute("pw_check_result", pw_check_result);
				System.out.println("pw_check_result : " + pw_check_result);
				
				response.sendRedirect("/project_ezen/mypage/password.do?member_idx="+member_idx);
			}
		}
		//마이페이지 - 회원탈퇴 페이지 보기
		else if(command.equals("joinout.do")) { 
			
			MemberDto dto = MemberDao.Mypage( request );
			request.setAttribute("dto", dto);
			
			jspPage = "/mypage/joinout.jsp";
		}	
		//마이페이지 - 회원탈퇴 액션(비번 확인, 탈퇴 회원 등록, 게시글 삭제 포함)
		else if(command.equals("joinoutAction.do"))  
		{
			String member_idx = request.getParameter("member_idx");
			HttpSession session = request.getSession();
			//비번 확인
			int pw_check_result = OutMemberDao.joinout_pw(request);
			System.out.println("pw_check_result : " + pw_check_result);
			
			if(pw_check_result==1)
			{	//탈퇴회원 등록
				OutMemberDao.joinout_insert(request);
				System.out.println("탈퇴회원 등록 성공!");
				
				//게시글 삭제(문의, 후기)
				String reviewMember_idx = request.getParameter("member_idx");
				String reReply_reviewMem_idx2 = request.getParameter("member_idx");
				String inq_member_idx = request.getParameter("member_idx");
				System.out.println("reviewMember_idx:"+reviewMember_idx);
				//후기 삭제
				ReviewDao.myReviewDelete( reviewMember_idx );
				//삭제되는 후기에 달린 댓글도 삭제 
				ReReplyDao.myReReply_delete(reReply_reviewMem_idx2);	
				
				//문의 삭제
				InquiryDao.myInquiryDelete(inq_member_idx);
				
				//회원 정보 삭제
				OutMemberDao.joinout(request);
				session.invalidate();
				
				response.sendRedirect("/project_ezen/main.do");
			}
			else 
			{
				session.setAttribute("pw_check_result", pw_check_result);
				System.out.println("pw_check_result : " + pw_check_result);
				
				response.sendRedirect("/project_ezen/mypage/joinout.do?member_idx="+member_idx);
			}
		}
		// 프로그램 - 스케줄 페이지 보기
		else if(command.equals("pro_schedule.do")) { 
			System.out.println("스케줄 컨트롤러");
			ScheduleDto dto = ScheduleDao.scheduleViewmain(request);
			request.setAttribute("dto", dto);
			
			Schedule2Dto dto2 = Schedule2Dao.scheduleViewmain2(request);
			request.setAttribute("dto2", dto2);	
			
			jspPage = "/program/pro_schedule.jsp";
		}
		//관리자 페이지 - 결제 내역 보기(팝업창)
		else if(command.equals("mv_popUp.do")) { 
			System.out.println("팝업");
			String pay_member_idx = request.getParameter("mv_pop");	
			String pay_name = request.getParameter("mem_name");
			if(pay_name == null) {
				pay_name = (String)request.getAttribute("pay_name");
			}
			if(pay_member_idx == null) {
				pay_member_idx = (String)request.getAttribute("pay_member_idx");
			}
			HttpSession session = request.getSession();
			
			int page = Integer.parseInt(request.getParameter("page"));
//			int page = 1;
			int pageSize = 5;// 한페이지에 나오는 게시물 개수
			int pageGroupSize = 3; // 페이지 번호가 몇개 나오느냐 개수
			
		    ArrayList<PayDto> pay_list = PayDao.pay_list(page, pay_member_idx); 
		    
		    int mypay_num = PayDao.mypay_num(pay_member_idx);//게시물 총 개수
		    System.out.println("mypay_num:"+mypay_num);
			  
		    int pageGroupCount = mypay_num / (pageSize * pageGroupSize) 
			           + (mypay_num % (pageSize * pageGroupSize) == 0 ? 0 : 1);
	        int nowPageGroup = (int) Math.ceil((double) page / pageGroupSize);
	          
		    request.setAttribute("pageSize", pageSize);
		    request.setAttribute("pageGroupSize", pageGroupSize);
		    request.setAttribute("mypay_num", mypay_num);
		    request.setAttribute("pageGroupCount", pageGroupCount);
		    request.setAttribute("nowPageGroup", nowPageGroup);	 	
		    
		    System.out.println("페이dao갔다오다");
		    request.setAttribute("pay_list", pay_list);
			System.out.println("pay_name:" + pay_name);
			session.setAttribute("pay_name", pay_name);
			session.setAttribute("pay_member_idx", pay_member_idx);
			
			jspPage = "/admin_member/mv_popUp.jsp";
		}		
		//관리자 페이지 - 결제 내역 삭제(결제 취소)
		else if(command.equals("mv_popUp_delete.do")) { 
			System.out.println("결제내역 취소 콘트롤");
			HttpSession session = request.getSession();
			
			String pay_member_idx = request.getParameter("pay_member_idx");	
			String pay_name = request.getParameter("mem_name");
			System.out.println("결제취소pay_member_idx:"+pay_member_idx);
			System.out.println("결제취소pay_name:"+pay_name);
			PayDao.memPay_delete(request);
			
			// 결제금액 합산
			try {
			    PayDao.paySum(request);
		    } catch (Exception e) {
			    e.printStackTrace();
			}
			//팝업창에 지워진 것 반영해서 정보 보여주기 위해 리스트 다시 부름
//			int page = Integer.parseInt(request.getParameter("page"));
			int page = 1;
			int pageSize = 5;// 한페이지에 나오는 게시물 개수
			int pageGroupSize = 3; // 페이지 번호가 몇개 나오느냐 개수
			
			ArrayList<PayDto> pay_list = PayDao.pay_list(page, pay_member_idx);
			
		    int mypay_num = PayDao.mypay_num(pay_member_idx);//게시물 총 개수
		    System.out.println("mypay_num:"+mypay_num);
			  
		    int pageGroupCount = mypay_num / (pageSize * pageGroupSize) 
			           + (mypay_num % (pageSize * pageGroupSize) == 0 ? 0 : 1);
	        int nowPageGroup = (int) Math.ceil((double) page / pageGroupSize);
	          
		    request.setAttribute("pageSize", pageSize);
		    request.setAttribute("pageGroupSize", pageGroupSize);
		    request.setAttribute("mypay_num", mypay_num);
		    request.setAttribute("pageGroupCount", pageGroupCount);
		    request.setAttribute("nowPageGroup", nowPageGroup);	 	
			
		    request.setAttribute("pay_list", pay_list);
		    session.setAttribute("pay_name", pay_name);
		    session.setAttribute("pay_member_idx", pay_member_idx);
		    
		    jspPage = "/admin_member/mv_popUp.jsp";
			
		}
		//관리자 페이지 - 탈퇴 회원 목록 보기
		else if (command.contains("outMember_list.do")) { 
			System.out.println("탈퇴 회원 목록");
			
			int page = Integer.parseInt(request.getParameter("page"));
			int pageSize = 5;// 한페이지에 나오는 게시물 개수
			int pageGroupSize = 3; // 페이지 번호가 몇개 나오느냐 개수
			System.out.println("콘트롤러:"+page);
			
			ArrayList<OutMemberDto> out_member_list = OutMemberDao.out_member_list(page);
			
	        int outMemberCount = OutMemberDao.outMember_count();//게시물 총 개수
	        System.out.println("outMemberCount:"+outMemberCount);
	       
	        int pageGroupCount = outMemberCount / (pageSize * pageGroupSize) 
	        		+ (outMemberCount % (pageSize * pageGroupSize) == 0 ? 0 : 1);//총 그룹개수
	        int nowPageGroup = (int) Math.ceil((double) page / pageGroupSize); //현재 그룹페이지 번호
	              
	        request.setAttribute("out_member_list", out_member_list);
	        request.setAttribute("pageSize", pageSize);
	        request.setAttribute("pageGroupSize", pageGroupSize);
	        request.setAttribute("outMemberCount", outMemberCount);
	        request.setAttribute("pageGroupCount", pageGroupCount);
	        request.setAttribute("nowPageGroup", nowPageGroup);
	        
			jspPage = "/admin_member/outMember_list.jsp";
		}
		//관리자 페이지 - 탈퇴 회원 정보 상세 페이지 보기
		else if(command.equals("outMember_view.do")) { 
			
			OutMemberDto dto = OutMemberDao.out_member_view( request );
			request.setAttribute("dto", dto);
			
			jspPage = "/admin_member/outMember_view.jsp";
		}
		//관리자 페이지 - 탈퇴 회원 선택 삭제 액션
		else if(command.equals("outMem_delete.do")) { 
			
			String[] strArry = request.getParameterValues("chk");
			if(strArry != null) {
				for(int i=0; i<strArry.length; i++) {
					int out_member_idx = Integer.parseInt(strArry[i]);
					System.out.println(out_member_idx);
					
					OutMemberDao.out_mem_delete(out_member_idx);
				}
			}
			response.sendRedirect("/project_ezen/admin_member/outMember_list.do?page=1");
		}
		//관리자 페이지 - 회원 검색
		else if(command.equals("memList_search.do")) { 
			int page = Integer.parseInt(request.getParameter("page"));
			String keyword = request.getParameter("keyword");
			String ms_title = request.getParameter("ms_title");
			System.out.println("page:"+page);
			int pageSize = 5;// 한페이지에 나오는 게시물 개수
			int pageGroupSize = 3; // 페이지 번호가 몇개 나오느냐 개수
	        
			ArrayList<MemberDto> member_list = MemberDao.mem_search(request);  
	        
	        int memberCount = MemberDao.memSearch_count(request);//게시물 총 개수
	        System.out.println("memberCount:"+memberCount);
	       
	        int pageGroupCount = memberCount / (pageSize * pageGroupSize) 
	        		+ (memberCount % (pageSize * pageGroupSize) == 0 ? 0 : 1);//총 그룹개수
	        int nowPageGroup = (int) Math.ceil((double) page / pageGroupSize); //현재 그룹페이지 번호
	        
	        int size = member_list.size();
			System.out.println("size"+size);
			int searchResult = 1;
			
			request.setAttribute("searchResult", searchResult);
			request.setAttribute("keyword", keyword);
			request.setAttribute("ms_title", ms_title);
			request.setAttribute("size", size);
	        request.setAttribute("member_list", member_list);
	        request.setAttribute("pageSize", pageSize);
	        request.setAttribute("pageGroupSize", pageGroupSize);
	        request.setAttribute("memberCount", memberCount);
	        request.setAttribute("pageGroupCount", pageGroupCount);
	        request.setAttribute("nowPageGroup", nowPageGroup);
	        
//			
	        jspPage = "/admin_member/member_list.jsp";
		}
		//관리자 페이지 - 탈퇴 회원 검색
		else if(command.equals("outMemList_search.do")) { 
			int page = Integer.parseInt(request.getParameter("page"));
			String keyword = request.getParameter("keyword");
			String ms_title = request.getParameter("ms_title");
			System.out.println("page:"+page);
			int pageSize = 5;// 한페이지에 나오는 게시물 개수
			int pageGroupSize = 3; // 페이지 번호가 몇개 나오느냐 개수
	        
			ArrayList<OutMemberDto> out_member_list = OutMemberDao.oMem_search(request);  
	        
	        int outMemberCount = OutMemberDao.oMemSearch_count(request);//게시물 총 개수
	        System.out.println("outMemberCount:"+outMemberCount);
	       
	        int pageGroupCount = outMemberCount / (pageSize * pageGroupSize) 
	        		+ (outMemberCount % (pageSize * pageGroupSize) == 0 ? 0 : 1);//총 그룹개수
	        int nowPageGroup = (int) Math.ceil((double) page / pageGroupSize); //현재 그룹페이지 번호
	        
	        int size = out_member_list.size();
			System.out.println("size"+size);
			int searchResult = 1;
			
			request.setAttribute("searchResult", searchResult);
			request.setAttribute("keyword", keyword);
			request.setAttribute("ms_title", ms_title);
			request.setAttribute("size", size);
	        request.setAttribute("out_member_list", out_member_list);
	        request.setAttribute("pageSize", pageSize);
	        request.setAttribute("pageGroupSize", pageGroupSize);
	        request.setAttribute("outMemberCount", outMemberCount);
	        request.setAttribute("pageGroupCount", pageGroupCount);
	        request.setAttribute("nowPageGroup", nowPageGroup);
	        
	        jspPage = "/admin_member/outMember_list.jsp";
		}
		
		
		
		
		
		// MyController_A.java
		//관리자 시간표 페이지 보기
		else if(command.equals("admin_schedule.do")) { 
			//DTO 레코드 정보
			System.out.println("시간표 :" );
			ScheduleDto dto = ScheduleDao.scheduleView(request);
			request.setAttribute("dto", dto);
			
			Schedule2Dto dto2 = Schedule2Dao.scheduleView2(request);
			request.setAttribute("dto2", dto2);
			
			jspPage = "/admin_gymmanage/admin_schedule.jsp";
		}
		//트레이너 페이지 보기
		else if(command.equals("trainner.do")) { 
			
		    ArrayList<TrainnerDto> list = TrainnerDao.list();
		    request.setAttribute("list", list);
		    
			jspPage = "/intro/trainner.jsp";
		}
		
	
	
		else if(command.equals("admin_trainner.do")) { 
		
		    ArrayList<TrainnerDto> list = TrainnerDao.list();
		    request.setAttribute("list", list);
		    
			jspPage = "/admin_gymmanage/admin_trainner.jsp";
		}
		else if(command.equals("trainner_add.do")) { //추가화면으로 이동
			jspPage = "/admin_gymmanage/admin_trainner_add.jsp";
		}
		
		
		else if(command.equals("fileupload.do")) {
				
			
				FileUpload.upload(request);
				
				request.setAttribute("message", "파일업로드에 성공 하였습니다.!");
	
				jspPage = "/project_ezen/admin_gym_manage/admin_trainner.do";	
		}
		
		else if(command.equals("trainner_write.do")) { //글쓰기 액션 
			String trainner_int = request.getParameter("trainner_int");
			String trainner_content = request.getParameter("trainner_content");
			String trainner_img = request.getParameter("filename");
	
			TrainnerDao.trainner_write(trainner_int, trainner_content, trainner_img);
			System.out.println("업로드");
		
			response.sendRedirect("/project_ezen/admin_gym_manage/admin_trainner.do");
		}
		//트레이너 삭제
		else if(command.equals("trainner_delete.do")) { 
			String trainner_idx = request.getParameter("trainner_idx");
		
			
			TrainnerDao.trainner_delete( trainner_idx );
			
			response.sendRedirect("/project_ezen/admin_member/admin_trainner.do");
		}
		
		//트레이너 수정페이지로 이동
		else if(command.equals("modify_move.do")) { 
			String trainner_idx = request.getParameter("trainner_idx");
			TrainnerDto dto = TrainnerDao.trainner_modifyView( trainner_idx );
			request.setAttribute("dto", dto);
			
			
			
			jspPage = "/admin_gymmanage/admin_trainner_modify.jsp";
		}
		
//		트레이너 수정
		else if(command.equals("trainner_modify.do")) { //글수정 액션 
			String trainner_idx = request.getParameter("trainner_idx");
			String trainner_int = request.getParameter("trainner_int");
			String trainner_content = request.getParameter("trainner_content");
			String trainner_img = request.getParameter("filename");
		
			
			System.out.println("trainner_idx:"+trainner_idx);
			System.out.println("trainner_int"+trainner_int);
			System.out.println("trainner_content"+trainner_content);
			System.out.println("trainner_img"+trainner_img);


		
			TrainnerDao.trainner_modify( trainner_idx, trainner_int, trainner_content, trainner_img  );
			
			response.sendRedirect("/project_ezen/admin_gymmanage/admin_trainner.do");
		}
		
		//스케줄1 수정
		else if(command.equals("schedule_update.do")) 
		{
			String gym_schedule_idx = request.getParameter("gym_schedule_idx");
			System.out.println("schedule_update:" + gym_schedule_idx);
			ScheduleDao.schedule_update(request);
		

			response.sendRedirect("/project_ezen/admin_member/member_list.do?page=1");		
		}
		//스케줄2 수정
		else if(command.equals("schedule2_update.do")) 
		{
			String gym_schedule2_idx = request.getParameter("gym_schedule2_idx");
			Schedule2Dao.schedule2_update(request);
			response.sendRedirect("/project_ezen/admin_member/member_list.do?page=1");	
		}
		
		
		
		
		// MyController_B.java

		// (온라인 결제)		
		// 상품선택 페이지
		else if(command.equals("paychoice.do")) { 		
		  jspPage = "/payment/paychoice.jsp";
		}
		// 상품선택 액션	 
		else if (command.equals("choiceform.do")) { 							
		  String pay_membershipA = request.getParameter("pay_membershipA");
		  String pay_membershipB = request.getParameter("pay_membershipB");	  
	      String choice_amount = request.getParameter("choice_amount");	  
		  String pay_start_dateA = request.getParameter("pay_start_dateA");
		  String pay_start_dateB = request.getParameter("pay_start_dateB");	  
		  String pay_end_dateA = request.getParameter("pay_end_dateA");
		  String pay_end_dateB = request.getParameter("pay_end_dateB");	  	
		  String pay_membership = null;
		  String pay_start_date = null;
		  String pay_end_date = null;

		  if (pay_membershipA != null) {
		    pay_membership = pay_membershipA;
		    pay_start_date = pay_start_dateA;
	        pay_end_date = pay_end_dateA;
		  }
		  if (pay_membershipB != "") {
		    pay_membership = pay_membershipB;
			pay_start_date = pay_start_dateB;
			pay_end_date = pay_end_dateB;
		  }
		  
		  HttpSession session = request.getSession();
		  session.setAttribute("pay_membership", pay_membership);
		  session.setAttribute("choice_amount", choice_amount);
		  session.setAttribute("pay_start_date", pay_start_date);
		  session.setAttribute("pay_end_date", pay_end_date);
		      
		  response.sendRedirect("pay.jsp");
		}	
        // 결제액션
		else if(command.equals("pay.do")) { 	  
		  request.setCharacterEncoding("UTF-8");
		  
		  // 결제정보 서버에 보내기
		  PayDao.payment(request);
		  
		  // 결제금액 합산
		  try {
		    PayDao.paySum(request);
		  } catch (Exception e) {
		    e.printStackTrace();
		  }
		  
		  // 쿠폰사용시 빼기
		  String pay_coupon_num = request.getParameter("pay_coupon_num");
		  
	      try {
	        if(pay_coupon_num.equals("1")){   
	          PayDao.paySub01(request);
	        }
	        else if(pay_coupon_num.equals("2"))
	        {
	          PayDao.paySub02(request);
	        }
	    	  
	      }catch (Exception e) {
	        e.printStackTrace();    	  
	      }

		  response.sendRedirect("paymentend.jsp");
		}
		
		// (고객센터)
		// 1대1문의 액션
		else if(command.equals("inquiry.do")) { 			
	      request.setCharacterEncoding("UTF-8");
		  InquiryDao.inquiry(request);

		  response.sendRedirect("/project_ezen/main.jsp");
		}
		// FAQ 액션
		else if (command.equals("faq.do")) { 
		  ArrayList<FaqDto> faq_list = FaqDao.faq_list(); 
	      request.setAttribute("faq_list", faq_list);
	        
		  jspPage = "/service/faq.jsp";
		}
		// FAQ 상세보기 액션
		else if(command.equals("faq_view.do")) { 
		  String faq_idx = request.getParameter("faq_idx");
			
		  FaqDto dto = FaqDao.faq_view( faq_idx );
		  request.setAttribute("dto", dto);
		  
		  jspPage = "/service/faq_view.jsp";
		}
		
        // (마이페이지)
		// 결제내역
//		else if(command.equals("paylist.do")) { 
//		  String pay_member_idx = request.getParameter("member_idx");	
//			
//		  ArrayList<PayDto> pay_list = PayDao.pay_list(pay_member_idx); 
//		  request.setAttribute("pay_list", pay_list);
//				
//		  jspPage = "/mypage/paylist.jsp";
//		}
		else if(command.equals("paylist.do")) { 
			  String pay_member_idx = request.getParameter("member_idx");
				
			  int page = Integer.parseInt(request.getParameter("page"));
			  int pageSize = 5;// 한페이지에 나오는 게시물 개수
			  int pageGroupSize = 3; // 페이지 번호가 몇개 나오느냐 개수
		        
			  ArrayList<PayDto> pay_list = PayDao.pay_list(page, pay_member_idx); 
		        
		      int mypay_num = PayDao.mypay_num(pay_member_idx);//게시물 총 개수
		      System.out.println("mypay_num:"+mypay_num);
			  
		      int pageGroupCount = mypay_num / (pageSize * pageGroupSize) 
			           + (mypay_num % (pageSize * pageGroupSize) == 0 ? 0 : 1);
	          int nowPageGroup = (int) Math.ceil((double) page / pageGroupSize);
	          
		      request.setAttribute("pageSize", pageSize);
		      request.setAttribute("pageGroupSize", pageGroupSize);
		      request.setAttribute("mypay_num", mypay_num);
		      request.setAttribute("pageGroupCount", pageGroupCount);
		      request.setAttribute("nowPageGroup", nowPageGroup);	        	
		      		
			  request.setAttribute("pay_list", pay_list);
						
			  jspPage = "/mypage/paylist.jsp";
		}
		// 1:1문의
		else if(command.equals("oneonone.do")) { 
		  String inq_member_idx = request.getParameter("member_idx");	
			
		  int page = Integer.parseInt(request.getParameter("page"));
		  int pageSize = 5;// 한페이지에 나오는 게시물 개수
		  int pageGroupSize = 3; // 페이지 번호가 몇개 나오느냐 개수
		  System.out.println("콘트롤러:"+page);
	        
		  ArrayList<InquiryDto> inq_list = InquiryDao.inq_list(page, inq_member_idx); 
	        
	      int myinq_num = InquiryDao.myinq_num(inq_member_idx);//게시물 총 개수
	      System.out.println("myinq_num:"+myinq_num);
		  
	      int pageGroupCount = myinq_num / (pageSize * pageGroupSize) 
		           + (myinq_num % (pageSize * pageGroupSize) == 0 ? 0 : 1);
          int nowPageGroup = (int) Math.ceil((double) page / pageGroupSize);
          
	      request.setAttribute("pageSize", pageSize);
	      request.setAttribute("pageGroupSize", pageGroupSize);
	      request.setAttribute("myinq_num", myinq_num);
	      request.setAttribute("pageGroupCount", pageGroupCount);
	      request.setAttribute("nowPageGroup", nowPageGroup);	        	
	        	
	      request.setAttribute("inq_list", inq_list);	
			
		  jspPage = "/mypage/oneonone.jsp";
		}
		// 1:1문의 상세보기
		else if(command.equals("oneononeans.do")) {
		  String inq_idx = request.getParameter("inq_idx");
			
		  InquiryDto dto = InquiryDao.inq_view( inq_idx );
		  request.setAttribute("dto", dto);
				
		  jspPage = "/mypage/oneononeans.jsp";
	    }
		
		// (관리자페이지-온라인결제)
		// 결제관리 메인화면
		else if(command.equals("admin_paymain.do")) {	
	    
	      // 일반회원권 결제 수
		  int generalnum = PayDao.general_num();
		  // 스페셜회원권 결제 수
		  int specialnum = PayDao.special_num();
		  // 일반회원권 결제 금액
		  int generalmoney = PayDao.general_money();
		  // 스페셜회원권 결제 금액
		  int specialmoney = PayDao.special_money();
		  
		       
	      request.setAttribute("generalnum", generalnum);
	      request.setAttribute("specialnum", specialnum);
	      request.setAttribute("generalmoney", generalmoney);
	      request.setAttribute("specialmoney", specialmoney);
	      
		  jspPage = "/admin_payment/admin_paymain.jsp";
		}
		// 일반회원권 결제관리
		else if(command.equals("admin_general.do")) {				
		  int page = Integer.parseInt(request.getParameter("page"));
		  int pageSize = 5; // 한페이지에 나오는 게시물 개수
		  int pageGroupSize = 3; // 페이지 번호가 몇개 나오느냐 개수
		  
		  ArrayList<PayDto> admingpay_list = PayDao.admingpay_list(page); 
		  
		  int paycount = PayDao.general_num();
		  System.out.println("paycount:"+paycount);
		  
		  int pageGroupCount = paycount / (pageSize * pageGroupSize) 
	        	         	   + (paycount % (pageSize * pageGroupSize) == 0 ? 0 : 1);
	      int nowPageGroup = (int) Math.ceil((double) page / pageGroupSize); 
	      
	      request.setAttribute("admingpay_list", admingpay_list);
	      
	      request.setAttribute("pageSize", pageSize);
	      request.setAttribute("pageGroupSize", pageGroupSize);
	      request.setAttribute("paycount", paycount);
	      request.setAttribute("pageGroupCount", pageGroupCount);
	      request.setAttribute("nowPageGroup", nowPageGroup);
	
		  jspPage = "/admin_payment/admin_general.jsp";		  
		}
		// 스페셜회원권 결제관리
		else if(command.equals("admin_special.do")) {	
		  System.out.println("일반회원권 결제내역");	
					
		  int page = Integer.parseInt(request.getParameter("page"));
		  int pageSize = 5; // 한페이지에 나오는 게시물 개수
		  int pageGroupSize = 3; // 페이지 번호가 몇개 나오느냐 개수
				  
		  ArrayList<PayDto> adminspay_list = PayDao.adminspay_list(page); 
				  
		  int paycount = PayDao.special_num();
		  System.out.println("paycount:"+paycount);
				  
		  int pageGroupCount = paycount / (pageSize * pageGroupSize) 
			        	         	   + (paycount % (pageSize * pageGroupSize) == 0 ? 0 : 1);
		  int nowPageGroup = (int) Math.ceil((double) page / pageGroupSize); 
			      
		  request.setAttribute("adminspay_list", adminspay_list);
			      
		  request.setAttribute("pageSize", pageSize);
		  request.setAttribute("pageGroupSize", pageGroupSize);
		  request.setAttribute("paycount", paycount);
		  request.setAttribute("pageGroupCount", pageGroupCount);
		  request.setAttribute("nowPageGroup", nowPageGroup);
			
		  jspPage = "/admin_payment/admin_special.jsp";		  
		}		
		
		// (관리자페이지-고객센터)
		// 1:1문의 게시글
		else if(command.equals("admin_inquiry.do")) {				
		  int page = Integer.parseInt(request.getParameter("page"));
		  int pageSize = 5; // 한페이지에 나오는 게시물 개수
		  int pageGroupSize = 3; // 페이지 번호가 몇개 나오느냐 개수
		  
		  ArrayList<InquiryDto> admininq_list = InquiryDao.admininq_list(page); 
			  
		  int inqcount = InquiryDao.admininq_num();
		  System.out.println("inqcount:"+inqcount);
			  
		  int pageGroupCount = inqcount / (pageSize * pageGroupSize) 
		        	           + (inqcount % (pageSize * pageGroupSize) == 0 ? 0 : 1);
		  int nowPageGroup = (int) Math.ceil((double) page / pageGroupSize); 
		      
		  request.setAttribute("admininq_list", admininq_list);
		      
		  request.setAttribute("inqcount", inqcount);
		  request.setAttribute("pageGroupCount", pageGroupCount);
		  request.setAttribute("nowPageGroup", nowPageGroup);
		  request.setAttribute("pageSize", pageSize);
		  request.setAttribute("pageGroupSize", pageGroupSize);
          		  
		  jspPage = "/admin_service/admin_inquiry.jsp";		  
		}	
		// 1:1문의 미답변 게시글
  	    else if(command.equals("admin_inquiryNo.do")) { 
		  int page = Integer.parseInt(request.getParameter("page"));
	      int pageSize = 5; // 한페이지에 나오는 게시물 개수
		  int pageGroupSize = 3; // 페이지 번호가 몇개 나오느냐 개수
		  
		  int inqNO=1;
		  System.out.println("inqNO:"+inqNO);
			  
		  ArrayList<InquiryDto> admininqN_list = InquiryDao.admininqN_list(page);
			  
		  int inqNcount = InquiryDao.admininqN_num();
		  System.out.println("inqNcount:"+inqNcount);
			  
		  int pageGroupCountN = inqNcount / (pageSize * pageGroupSize) 
	   	                        + (inqNcount % (pageSize * pageGroupSize) == 0 ? 0 : 1);
	      int nowPageGroupN = (int) Math.ceil((double) page / pageGroupSize);
	          
	      request.setAttribute("admininqN_list", admininqN_list);
		      
		  request.setAttribute("inqNcount", inqNcount);
	      request.setAttribute("pageGroupCountN", pageGroupCountN);
		  request.setAttribute("nowPageGroupN", nowPageGroupN);
	      request.setAttribute("pageSize", pageSize);
	      request.setAttribute("pageGroupSize", pageGroupSize);
	      
	      request.setAttribute("inqNO", inqNO);

	      jspPage = "/admin_service/admin_inquiry.jsp";
		}
		// 1:1문의 상세보기
  	    else if(command.equals("admininquiry_view.do")) {  
  	      String inq_idx = request.getParameter("inq_idx");
 			
  		  InquiryDto dto = InquiryDao.inq_view( inq_idx );
  		  request.setAttribute("dto", dto);
  		  
  	      jspPage = "/admin_service/admininquiry_view.jsp";
  	    }
		// 1:1문의 답변하기
  	    else if(command.equals("iAnswer.do")) {  
  	      request.setCharacterEncoding("UTF-8");
  		  InquiryDao.inq_answer(request);
  		  
  		  response.sendRedirect("/project_ezen/admin_service/admin_inquiry.do?page=1");
  	    }
		// FAQ 게시글
  	    else if(command.equals("admin_faq.do")) {  
  		  ArrayList<FaqDto> faq_list = FaqDao.faq_list(); 
	      request.setAttribute("faq_list", faq_list);
	        
		  jspPage = "/admin_service/admin_faq.jsp";
  	    }
		// FAQ 글쓰기
  	    else if(command.equals("fwrite.do")) {  
  		  request.setCharacterEncoding("UTF-8");
  	   	  FaqDao.Faq(request);
  		  
  	      response.sendRedirect("admin_faq.do");
  	    }
		// FAQ 상세보기
  	    else if(command.equals("adminfaq_view.do")) {  
          String faq_idx = request.getParameter("faq_idx");
   			
          FaqDto dto = FaqDao.faq_view( faq_idx );
      	  request.setAttribute("dto", dto);
      		  
      	  jspPage = "/admin_service/adminfaq_view.jsp";
  	    }
		// FAQ 수정
  	    else if(command.equals("Faq_modify.do")) {  
  	      request.setCharacterEncoding("UTF-8");
  	      FaqDao.Faq_modify(request);
  		  
  		  response.sendRedirect("/project_ezen/admin_service/admin_faq.do");
  	    }		
		// FAQ 삭제
		else if(command.equals("faq_delete.do")) {			  
		  FaqDao.faq_delete(request);
			
		  response.sendRedirect("/project_ezen/admin_service/admin_faq.do");
        }

		
			
		
		
		
		
		
		
		
		// MyController_C.java
		//관리자페이지 - 공지사항 목록
		else if(command.equals("admin_notice.do")) 
		{
			int page = Integer.parseInt(request.getParameter("page"));
			int pageSize = 5;// 한페이지에 나오는 게시물 개수
			int pageGroupSize = 3; // 페이지 번호가 몇개 나오느냐 개수
			System.out.println("콘트롤러:"+page);
	        
			ArrayList<NoticeDto> notice_list = NoticeDao.notice_list(page); 
	        
	        int noticeCount = NoticeDao.notice_count();//게시물 총 개수
	        System.out.println("noticeCount:"+noticeCount);
	       
	        int pageGroupCount = noticeCount / (pageSize * pageGroupSize) 
	        		+ (noticeCount % (pageSize * pageGroupSize) == 0 ? 0 : 1);//총 그룹개수
	        int nowPageGroup = (int) Math.ceil((double) page / pageGroupSize); //현재 그룹페이지 번호
	        
	        request.setAttribute("pageSize", pageSize);
	        request.setAttribute("pageGroupSize", pageGroupSize);
	        request.setAttribute("noticeCount", noticeCount);
	        request.setAttribute("pageGroupCount", pageGroupCount);
	        request.setAttribute("nowPageGroup", nowPageGroup);
			
	        request.setAttribute("notice_list", notice_list);
	        
			jspPage = "/admin_community/admin_notice.jsp";
			
		}
		//관리자페이지 - 공지사항 내용
		else if(command.equals("admin_notice_view.do")) {
			
			String notice_idx = request.getParameter("notice_idx");
			//조회수 증가 
			NoticeDao.noticeHit( notice_idx );
			
			System.out.println("notice_idx:"+notice_idx);
			NoticeDto dto = NoticeDao.noticeview( notice_idx );
			request.setAttribute("dto", dto);
			
			jspPage = "/admin_community/admin_notice_view.jsp";
		}
		//관리자페이지 - 공지사항 수정
		else if(command.equals("noticeModify.do")) { //글수정 액션 
			String notice_idx = request.getParameter("notice_idx");
			String notice_name = request.getParameter("notice_name");
			String notice_title = request.getParameter("notice_title");
			String notice_content = request.getParameter("notice_content");
			
			System.out.println("notice_idx:"+notice_idx);
			System.out.println("notice_name:"+notice_name);
			
			NoticeDao.modify( notice_idx, notice_name, notice_title, notice_content  );
			
			//수정된 글 조회
			response.sendRedirect("/project_ezen/admin_community/admin_notice.do?page=1");
		}
		//공지사항 내용 삭제
		else if(command.equals("noticeDelete.do")) { //글삭제 액션
			String notice_idx = request.getParameter("notice_delete");
			System.out.println("notice_idx:"+notice_idx);
			
			NoticeDao.noticeDelete( notice_idx );
			
			response.sendRedirect("/project_ezen/admin_community/admin_notice.do?page=1");
		}
		//공지사항 내용 글쓰기
		else if(command.equals("nwrite.do")) { //글쓰기 액션 
			String notice_name = request.getParameter("notice_name");
			String notice_title = request.getParameter("notice_title");
			String notice_content = request.getParameter("notice_content");
			System.out.println("notice_name:"+notice_name);
			System.out.println("notice_title:"+notice_title);
			System.out.println("board_content:"+notice_content);
			
			NoticeDao.noticeWrite(notice_name, notice_title, notice_content);
			
			response.sendRedirect("/project_ezen/admin_community/admin_notice.do?page=1");
		}
		//관리자페이지 - 이벤트 목록
		else if(command.equals("admin_event.do")) 
		{
			int page = Integer.parseInt(request.getParameter("page"));
			int pageSize = 5;// 한페이지에 나오는 게시물 개수
			int pageGroupSize = 3; // 페이지 번호가 몇개 나오느냐 개수
			System.out.println("콘트롤러:"+page);
	        
			ArrayList<EventDto> event_list = EventDao.event_list(page); 
	        
			 int eventCount = EventDao.event_count();//게시물 총 개수
		        System.out.println("eventCount:"+eventCount);
	       
	        int pageGroupCount = eventCount / (pageSize * pageGroupSize) 
	        		+ (eventCount % (pageSize * pageGroupSize) == 0 ? 0 : 1);//총 그룹개수
	        int nowPageGroup = (int) Math.ceil((double) page / pageGroupSize); //현재 그룹페이지 번호
	        
	        request.setAttribute("pageSize", pageSize);
	        request.setAttribute("pageGroupSize", pageGroupSize);
	        request.setAttribute("eventCount", eventCount);
	        request.setAttribute("pageGroupCount", pageGroupCount);
	        request.setAttribute("nowPageGroup", nowPageGroup);
	        
	        request.setAttribute("event_list", event_list);
	        
			jspPage = "/admin_community/admin_event.jsp";
			
		}
		//관리자페이지 - 이벤트 내용
		else if(command.equals("admin_event_view.do")) {
			
			String event_idx = request.getParameter("event_idx");
			//조회수 증가 
			EventDao.eventHit( event_idx );
			
			System.out.println("event_idx:"+event_idx);
			EventDto dto = EventDao.eventview( event_idx );
			request.setAttribute("dto", dto);
			
			jspPage = "/admin_community/admin_event_view.jsp";
		}
		//관리자페이지 - 이벤트 수정
		else if(command.equals("eventModify.do")) { //글수정 액션 
			String event_idx = request.getParameter("event_idx");
			String event_name = request.getParameter("event_name");
			String event_title = request.getParameter("event_title");
			String event_content = request.getParameter("event_content");
			
			System.out.println("event_idx:"+event_idx);
			System.out.println("event_name:"+event_name);
			
			EventDao.modify( event_idx, event_name, event_title, event_content  );
			
			//수정된 글 조회
			response.sendRedirect("/project_ezen/admin_community/admin_event.do?page=1");
		}
		
		//이벤트 내용 삭제
		else if(command.equals("eventDelete.do")) { //글삭제 액션
			String event_idx = request.getParameter("event_delete");
			System.out.println("event_idx:"+event_idx);
			
			EventDao.eventDelete( event_idx );
			
			response.sendRedirect("/project_ezen/admin_community/admin_event.do?page=1");
		}
		//이벤트 내용 글쓰기
		else if(command.equals("ewrite.do")) { //글쓰기 액션 
			//코드를 작성하시오.
			String event_name = request.getParameter("event_name");
			String event_title = request.getParameter("event_title");
			String event_content = request.getParameter("event_content");
			System.out.println("event_name:"+event_name);
			System.out.println("event_title:"+event_title);
			System.out.println("event_content:"+event_content);
			
			EventDao.eventWrite(event_name, event_title, event_content);
			
			response.sendRedirect("/project_ezen/admin_community/admin_event.do?page=1");
		}
		
		
		//관리자페이지 - 채용안내 목록
		else if(command.equals("admin_recruitment.do")) 
		{
			int page = Integer.parseInt(request.getParameter("page"));
			int pageSize = 5;// 한페이지에 나오는 게시물 개수
			int pageGroupSize = 3; // 페이지 번호가 몇개 나오느냐 개수
			System.out.println("콘트롤러:"+page);
	        
			ArrayList<RecruitmentDto> recruitment_list = RecruitmentDao.recruitment_list(page); 
	        
			 int recruitmentCount = RecruitmentDao.recruitment_count();//게시물 총 개수
		        System.out.println("recruitmentCount:"+recruitmentCount);
	       
	        int pageGroupCount = recruitmentCount / (pageSize * pageGroupSize) 
	        		+ (recruitmentCount % (pageSize * pageGroupSize) == 0 ? 0 : 1);//총 그룹개수
	        int nowPageGroup = (int) Math.ceil((double) page / pageGroupSize); //현재 그룹페이지 번호
	        
	        request.setAttribute("pageSize", pageSize);
	        request.setAttribute("pageGroupSize", pageGroupSize);
	        request.setAttribute("recruitmentCount", recruitmentCount);
	        request.setAttribute("pageGroupCount", pageGroupCount);
	        request.setAttribute("nowPageGroup", nowPageGroup);
	        
	        request.setAttribute("recruitment_list", recruitment_list);
	        
			jspPage = "/admin_community/admin_recruitment.jsp";
			
		}
		//관리자페이지 - 채용안내 내용
		else if(command.equals("admin_recruitment_view.do")) {
			
			String recruitment_idx = request.getParameter("recruitment_idx");
			//조회수 증가 
			RecruitmentDao.recruitmentHit( recruitment_idx );
			
			System.out.println("recruitment_idx:"+recruitment_idx);
			RecruitmentDto dto = RecruitmentDao.recruitmentview( recruitment_idx );
			request.setAttribute("dto", dto);
			
			jspPage = "/admin_community/admin_recruitment_view.jsp";
		}
		//관리자페이지 - 채용안내 수정
		else if(command.equals("recruitmentModify.do")) { //글수정 액션 
			String recruitment_idx = request.getParameter("recruitment_idx");
			String recruitment_name = request.getParameter("recruitment_name");
			String recruitment_title = request.getParameter("recruitment_title");
			String recruitment_content = request.getParameter("recruitment_content");
			
			System.out.println("recruitment_idx:"+recruitment_idx);
			System.out.println("recruitment_name:"+recruitment_name);
			
			RecruitmentDao.modify( recruitment_idx, recruitment_name, recruitment_title, recruitment_content  );
			
			//수정된 글 조회
			response.sendRedirect("/project_ezen/admin_community/admin_recruitment.do?page=1");
		}
		
		//채용안내 내용 삭제
		else if(command.equals("recruitmentDelete.do")) { //글삭제 액션
			String recruitment_idx = request.getParameter("recruitment_delete");
			System.out.println("recruitment_idx:"+recruitment_idx);
			
			RecruitmentDao.recruitmentDelete( recruitment_idx );
			
			response.sendRedirect("/project_ezen/admin_community/admin_recruitment.do?page=1");
		}
		//채용안내 내용 글쓰기
		else if(command.equals("rwrite.do")) { //글쓰기 액션 
			String recruitment_name = request.getParameter("recruitment_name");
			String recruitment_title = request.getParameter("recruitment_title");
			String recruitment_content = request.getParameter("recruitment_content");
			System.out.println("recruitment_name:"+recruitment_name);
			System.out.println("recruitment_title:"+recruitment_title);
			System.out.println("recruitment_content:"+recruitment_content);
			
			RecruitmentDao.recruitmentWrite(recruitment_name, recruitment_title, recruitment_content);
			
			response.sendRedirect("/project_ezen/admin_community/admin_recruitment.do?page=1");
		}	
	
		//이용자페이지 - 공지사항 목록
		else if(command.equals("notice.do")) 
		{
			int page = Integer.parseInt(request.getParameter("page"));
			int pageSize = 5;// 한페이지에 나오는 게시물 개수
			int pageGroupSize = 3; // 페이지 번호가 몇개 나오느냐 개수
			System.out.println("콘트롤러:"+page);
	        
			ArrayList<NoticeDto> notice_list = NoticeDao.notice_list(page); 
	        
	        int noticeCount = NoticeDao.notice_count();//게시물 총 개수
	        System.out.println("noticeCount:"+noticeCount);
	       
	        int pageGroupCount = noticeCount / (pageSize * pageGroupSize) 
	        		+ (noticeCount % (pageSize * pageGroupSize) == 0 ? 0 : 1);//총 그룹개수
	        int nowPageGroup = (int) Math.ceil((double) page / pageGroupSize); //현재 그룹페이지 번호
	        
	        request.setAttribute("pageSize", pageSize);
	        request.setAttribute("pageGroupSize", pageGroupSize);
	        request.setAttribute("noticeCount", noticeCount);
	        request.setAttribute("pageGroupCount", pageGroupCount);
	        request.setAttribute("nowPageGroup", nowPageGroup);
	        request.setAttribute("notice_list", notice_list);
	        
			jspPage = "/community/notice.jsp";
			
		}
		
		//이용자페이지 - 공지사항 내용
		else if(command.equals("notice_view.do")) {
			
			String notice_idx = request.getParameter("notice_idx");
			//조회수 증가 
			NoticeDao.noticeHit( notice_idx );
			
			System.out.println("notice_idx:"+notice_idx);
			NoticeDto dto = NoticeDao.noticeview( notice_idx );
			request.setAttribute("dto", dto);
			
			jspPage = "/community/notice_view.jsp";
		}
		
		
		
		//이용자페이지 - 이벤트 목록
		else if(command.equals("event.do")) 
		{
			int page = Integer.parseInt(request.getParameter("page"));
			int pageSize = 5;// 한페이지에 나오는 게시물 개수
			int pageGroupSize = 3; // 페이지 번호가 몇개 나오느냐 개수
			System.out.println("콘트롤러:"+page);
	        
			ArrayList<EventDto> event_list = EventDao.event_list(page); 
	        
	        int eventCount = EventDao.event_count();//게시물 총 개수
	        System.out.println("eventCount:"+eventCount);
	       
	        int pageGroupCount = eventCount / (pageSize * pageGroupSize) 
	        		+ (eventCount % (pageSize * pageGroupSize) == 0 ? 0 : 1);//총 그룹개수
	        int nowPageGroup = (int) Math.ceil((double) page / pageGroupSize); //현재 그룹페이지 번호
	        
	        request.setAttribute("pageSize", pageSize);
	        request.setAttribute("pageGroupSize", pageGroupSize);
	        request.setAttribute("eventCount", eventCount);
	        request.setAttribute("pageGroupCount", pageGroupCount);
	        request.setAttribute("nowPageGroup", nowPageGroup);
	        request.setAttribute("event_list", event_list);
	        
			jspPage = "/community/event.jsp";
			
		}
		//이용자페이지 - 이벤트 내용
		else if(command.equals("event_view.do")) {
			
			String event_idx = request.getParameter("event_idx");
			//조회수 증가 
			EventDao.eventHit( event_idx );
			
			System.out.println("event_idx:"+event_idx);
			EventDto dto = EventDao.eventview( event_idx );
			request.setAttribute("dto", dto);
			
			jspPage = "/community/event_view.jsp";
		}
		
		
		
		//이용자페이지 - 채용안내 목록
		else if(command.equals("recruitment.do")) 
		{
			int page = Integer.parseInt(request.getParameter("page"));
			int pageSize = 5;// 한페이지에 나오는 게시물 개수
			int pageGroupSize = 3; // 페이지 번호가 몇개 나오느냐 개수
			System.out.println("콘트롤러:"+page);
	        
			ArrayList<RecruitmentDto> recruitment_list = RecruitmentDao.recruitment_list(page); 
	        
			 int recruitmentCount = RecruitmentDao.recruitment_count();//게시물 총 개수
		        System.out.println("recruitmentCount:"+recruitmentCount);
	       
	        int pageGroupCount = recruitmentCount / (pageSize * pageGroupSize) 
	        		+ (recruitmentCount % (pageSize * pageGroupSize) == 0 ? 0 : 1);//총 그룹개수
	        int nowPageGroup = (int) Math.ceil((double) page / pageGroupSize); //현재 그룹페이지 번호
	        
	        request.setAttribute("pageSize", pageSize);
	        request.setAttribute("pageGroupSize", pageGroupSize);
	        request.setAttribute("recruitmentCount", recruitmentCount);
	        request.setAttribute("pageGroupCount", pageGroupCount);
	        request.setAttribute("nowPageGroup", nowPageGroup);
	        
	        request.setAttribute("recruitment_list", recruitment_list);
	        
			jspPage = "/community/recruitment.jsp";
			
		}
		//이용자페이지 - 채용안내 내용
		else if(command.equals("recruitment_view.do")) {
			
			String recruitment_idx = request.getParameter("recruitment_idx");
			//조회수 증가 
			RecruitmentDao.recruitmentHit( recruitment_idx );
			
			System.out.println("recruitment_idx:"+recruitment_idx);
			RecruitmentDto dto = RecruitmentDao.recruitmentview( recruitment_idx );
			request.setAttribute("dto", dto);
			
			jspPage = "/community/recruitment_view.jsp";
		}

		
		
		
		
		
		
		
		//관리자페이지 - 이용후기 목록
		else if(command.equals("adminReview.do")) 
		{
			int page = Integer.parseInt(request.getParameter("page"));
			int pageSize = 5;// 한페이지에 나오는 게시물 개수
			int pageGroupSize = 3; // 페이지 번호가 몇개 나오느냐 개수
			System.out.println("콘트롤러:"+page);
	        
			ArrayList<ReviewDto> review_list = ReviewDao.review_list(page); 
	        
	        int reviewCount = ReviewDao.review_count();//게시물 총 개수
	        System.out.println("reviewCount:"+reviewCount);
	       
	        int pageGroupCount = reviewCount / (pageSize * pageGroupSize) 
	        		+ (reviewCount % (pageSize * pageGroupSize) == 0 ? 0 : 1);//총 그룹개수
	        int nowPageGroup = (int) Math.ceil((double) page / pageGroupSize); //현재 그룹페이지 번호
	        
	        request.setAttribute("pageSize", pageSize);
	        request.setAttribute("pageGroupSize", pageGroupSize);
	        request.setAttribute("reviewCount", reviewCount);
	        request.setAttribute("pageGroupCount", pageGroupCount);
	        request.setAttribute("nowPageGroup", nowPageGroup);
	        	
	        request.setAttribute("review_list", review_list);
	        
			jspPage = "/admin_community/adminReview.jsp";
			
		}
		//이용자 페이지 - 이용후기 목록
		else if(command.equals("review.do")) 
		{
			int page = Integer.parseInt(request.getParameter("page"));
			int pageSize = 5;// 한페이지에 나오는 게시물 개수
			int pageGroupSize = 3; // 페이지 번호가 몇개 나오느냐 개수
			System.out.println("콘트롤러:"+page);
	        
			ArrayList<ReviewDto> review_list = ReviewDao.review_list(page); 
			
	        int reviewCount = ReviewDao.review_count();//게시물 총 개수
	        System.out.println("reviewCount:"+reviewCount);
	       
	        int pageGroupCount = reviewCount / (pageSize * pageGroupSize) 
	        		+ (reviewCount % (pageSize * pageGroupSize) == 0 ? 0 : 1);//총 그룹개수
	        int nowPageGroup = (int) Math.ceil((double) page / pageGroupSize); //현재 그룹페이지 번호
	        
	        request.setAttribute("pageSize", pageSize);
	        request.setAttribute("pageGroupSize", pageGroupSize);
	        request.setAttribute("reviewCount", reviewCount);
	        request.setAttribute("pageGroupCount", pageGroupCount);
	        request.setAttribute("nowPageGroup", nowPageGroup);
	        	
	        request.setAttribute("review_list", review_list);
	        
			jspPage = "/community/review.jsp";
			
		}
		//관리자페이지 - 이용후기 내용
		else if(command.equals("adminReview_view.do")) {
			
			String review_idx = request.getParameter("review_idx");
			System.out.println("review_idx:"+review_idx);
			
			ReviewDto dto = ReviewDao.reviewView( review_idx );
			request.setAttribute("dto", dto);
			
			//댓글 목록
			ArrayList<ReReplyDto> reply_list = ReviewDao.reply_list( review_idx );
			request.setAttribute("reply_list", reply_list);
			
			jspPage = "/admin_community/adminReview_view.jsp";
		}
		//이용자페이지 - 이용후기 내용
		else if(command.equals("review_view.do")) {
			
			String review_idx = request.getParameter("review_idx");
			//조회수 증가 
			ReviewDao.reviewHit( review_idx );
			System.out.println("review_idx:"+review_idx);
			
			ReviewDto dto = ReviewDao.reviewView( review_idx );
			request.setAttribute("dto", dto);
			
			//댓글 목록
			ArrayList<ReReplyDto> reply_list = ReviewDao.reply_list( review_idx );
			request.setAttribute("reply_list", reply_list);
			
			jspPage = "/community/review_view.jsp";
		}		
		//이용자 페이지 - 후기 수정 액션
		else if(command.equals("reviewModify.do")) {
			String review_idx = request.getParameter("review_idx");
			String review_title = request.getParameter("review_title");
			String review_content = request.getParameter("review_content");
			
			System.out.println("review_idx:"+review_idx);
			
			ReviewDao.reviewModify( review_idx, review_title, review_content  );
			
			response.sendRedirect("/project_ezen/community/review.do?page=1");
		}
		//이용자페이지 - 이용후기 수정 페이지 보기
		else if(command.equals("review_modify.do")) {
			
			String review_idx = request.getParameter("review_idx");
			
			System.out.println("review_idx:"+review_idx);
			ReviewDto dto = ReviewDao.reviewView( review_idx );
			request.setAttribute("dto", dto);
			
			jspPage = "/community/review_modify.jsp";
		}	
		//이용자 페이지 - 후기 내용 삭제 액션
		else if(command.equals("reviewDelete.do")) { 
			String review_idx = request.getParameter("review_idx");
			String reReply_review_idx = request.getParameter("review_idx");
			System.out.println("review_idx:"+review_idx);
			
			ReviewDao.reviewDelete( review_idx );
			
			//후기에 달린 댓글 삭제
			ReReplyDao.reReply_delete(reReply_review_idx);
			
			response.sendRedirect("/project_ezen/community/review.do?page=1");
		}
		//관리자 페이지 - 후기 내용 삭제 액션
		else if(command.equals("adReviewDelete.do")) { 
			String review_idx = request.getParameter("review_idx");
			String reReply_review_idx = request.getParameter("review_idx");
			System.out.println("review_idx:"+review_idx);
			
			ReviewDao.reviewDelete( review_idx );
			
			//후기에 달린 댓글 삭제
			ReReplyDao.reReply_delete(reReply_review_idx);
			
			response.sendRedirect("/project_ezen/admin_community/adminReview.do?page=1");
		}
		//이용자 페이지 - 후기 내용 글쓰기 액션
		else if(command.equals("reviewWrite.do")) { 
			
			ReviewDao.reviewWrite(request);
			
			response.sendRedirect("/project_ezen/community/review.do?page=1");
		}
		//이용자 페이지 - 후기 댓글달기 액션
		else if(command.equals("reReply.do")) { 
			String reReply_review_idx = request.getParameter("reReply_review_idx");
			
			ReReplyDao.reReply(request);
			//댓글 수 +1
			ReviewDao.reReplyHitAdd(request);
			
			response.sendRedirect("/project_ezen/community/review_view.do?review_idx="+reReply_review_idx);
		}
		//이용자 페이지 - 후기 댓글 삭제 액션
		else if(command.equals("reReply_delete.do")) { 
			String reReply_idx = request.getParameter("reReply_idx");
			String reReply_review_idx = request.getParameter("reReply_review_idx");
			System.out.println("reReply_idx:"+reReply_idx);
			System.out.println("review_idx:"+reReply_review_idx);
			
			ReReplyDao.reply_delete( reReply_idx );
			//댓글 수 -1
			ReviewDao.reReplyHitMinus(request);
			
			response.sendRedirect("/project_ezen/community/review_view.do?review_idx="+reReply_review_idx);
		}	
		
		//이용자페이지 - 이용후기 댓글 수정 페이지 보기
		else if(command.equals("reReply_modify.do")) {
			
			String reReply_idx = request.getParameter("reReply_idx");
			
			System.out.println("reReply_idx:"+reReply_idx);
			ReReplyDto dto = ReReplyDao.reReplyView( reReply_idx );
			request.setAttribute("dto", dto);
			
			jspPage = "/community/reReply_modify.jsp";
		}
		
		//이용자 페이지 - 후기 댓글 수정 액션
		else if(command.equals("reReplyModify.do")) {
			String reReply_idx = request.getParameter("reReply_idx");
			String reReply_review_idx = request.getParameter("reReply_review_idx");
			String reReply_content = request.getParameter("reReplyCon");
			
			System.out.println("reReply_idx:"+reReply_idx);
			
			ReReplyDao.reReplyModify( reReply_idx, reReply_review_idx, reReply_content  );
			
			response.sendRedirect("/project_ezen/community/review_view.do?review_idx="+reReply_review_idx);
		}		
		//관리자 페이지 - 후기 댓글 삭제 액션
		else if(command.equals("adReReply_delete.do")) { 
			String reReply_idx = request.getParameter("reReply_idx");
			String reReply_review_idx = request.getParameter("reReply_review_idx");
			System.out.println("reReply_idx:"+reReply_idx);
			System.out.println("review_idx:"+reReply_review_idx);
			
			ReReplyDao.reply_delete( reReply_idx );
			//댓글 수 -1
			ReviewDao.reReplyHitMinus(request);
			
			response.sendRedirect("/project_ezen/admin_community/adminReview_view.do?review_idx="+reReply_review_idx);
		}		
		
		
		//마이 페이지 - 이용 후기 목록 보기
		else if(command.equals("myafter.do")) { 		
			String reviewMember_idx = request.getParameter("member_idx");	
			
			int page = Integer.parseInt(request.getParameter("page"));
			int pageSize = 5;// 한페이지에 나오는 게시물 개수
			int pageGroupSize = 3; // 페이지 번호가 몇개 나오느냐 개수
			System.out.println("콘트롤러:"+page);
	        
			ArrayList<ReviewDto> myReview_list = ReviewDao.myReview_list(page, reviewMember_idx);  
	        
	        int myReviewCount = ReviewDao.myReview_count(reviewMember_idx);//게시물 총 개수
	        System.out.println("myReviewCount:"+myReviewCount);
	       
	        int pageGroupCount = myReviewCount / (pageSize * pageGroupSize) 
	        		+ (myReviewCount % (pageSize * pageGroupSize) == 0 ? 0 : 1);//총 그룹개수
	        int nowPageGroup = (int) Math.ceil((double) page / pageGroupSize); //현재 그룹페이지 번호
	        
	        request.setAttribute("pageSize", pageSize);
	        request.setAttribute("pageGroupSize", pageGroupSize);
	        request.setAttribute("myReviewCount", myReviewCount);
	        request.setAttribute("pageGroupCount", pageGroupCount);
	        request.setAttribute("nowPageGroup", nowPageGroup);
	        	
			request.setAttribute("myReview_list", myReview_list);	
				
			jspPage = "/mypage/myafter.jsp";
		}
		//이용자 페이지 - 이용 후기 검색
		else if(command.equals("adReviewSearch.do")) { 
			int page = Integer.parseInt(request.getParameter("page"));
			String keyword = request.getParameter("keyword");
			String ar_title = request.getParameter("ar_title");
			System.out.println("page:"+page);
			int pageSize = 5;// 한페이지에 나오는 게시물 개수
			int pageGroupSize = 3; // 페이지 번호가 몇개 나오느냐 개수
	        
			ArrayList<ReviewDto> review_list = ReviewDao.adReviewSearch(request);  
	        
	        int reviewCount = ReviewDao.memSearch_count(request);//게시물 총 개수
	        System.out.println("reviewCount:"+reviewCount);
	       
	        int pageGroupCount = reviewCount / (pageSize * pageGroupSize) 
	        		+ (reviewCount % (pageSize * pageGroupSize) == 0 ? 0 : 1);//총 그룹개수
	        int nowPageGroup = (int) Math.ceil((double) page / pageGroupSize); //현재 그룹페이지 번호
	        
	        int size = review_list.size();
			System.out.println("size"+size);
			int searchResult = 1;
			
			request.setAttribute("searchResult", searchResult);
			request.setAttribute("keyword", keyword);
			request.setAttribute("ar_title", ar_title);
			request.setAttribute("size", size);
	        request.setAttribute("review_list", review_list);
	        request.setAttribute("pageSize", pageSize);
	        request.setAttribute("pageGroupSize", pageGroupSize);
	        request.setAttribute("reviewCount", reviewCount);
	        request.setAttribute("pageGroupCount", pageGroupCount);
	        request.setAttribute("nowPageGroup", nowPageGroup);
	        
	        jspPage = "/admin_community/adminReview.jsp";
		}		
		
		
		
		
//		아래의 코드는 맨 밑에 두도록 한다
		if (!jspPage.equals("")) { // jsp페이지가 비어있지 않다면,
			RequestDispatcher dispatcher = request.getRequestDispatcher(jspPage);
			dispatcher.forward(request, response);
		}

	}

}
