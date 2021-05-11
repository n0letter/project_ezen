//package project_ezen;
//
//import java.io.IOException;
//import java.util.ArrayList;
//
//import javax.servlet.RequestDispatcher;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import memDao.MemberDao;
//
////@WebServlet(urlPatterns = {"/agreement.do"})
//public class MemberController extends HttpServlet {
//	
//
//	@Override
//	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		doProcess(req, resp);
//	}
//
//	@Override
//	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		doProcess(req, resp);
//	}	
//	
//	void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		
//		request.setCharacterEncoding("UTF-8");
//		
////		String command = request.getParameter("command");
//		String requestURI = request.getRequestURI();
//		int cmdIdx = requestURI.lastIndexOf("/")+1;
//		String command = requestURI.substring(cmdIdx);
//		String jspPage = "";
//		
//		System.out.println("로그인command:"+command);
//		
//		// 약관 동의 액션 - hidden인 member_agree에 value값(Y, N) 주는 동작
//		if(command.equals("agreement.do"))
//		{
//			String marketing = request.getParameter("marketing");
//			System.out.println("marketing Y N : " + marketing);
//
//			if (marketing == null) {
//				marketing = "N";
//			}
//			HttpSession session = request.getSession();
//			session.setAttribute("check_agree", marketing);
////			RequestDispatcher dispatcher = request.getRequestDispatcher("/member/joinForm.jsp");
////			dispatcher.forward(request, response);
//			response.sendRedirect("/project_ezen/member/joinForm.jsp");
//		}
//		// 회원가입액션
//		else if (command.equals("JoinAction.do")) {
//
//			request.setCharacterEncoding("UTF-8");
//			MemberDao.insertMember(request);
//
//			response.sendRedirect("main.do");
//		}
//		// 아이디 중복 체크
//		else if (command.equals("idCheckAjax.do")) {
//
//			int result = 0;
//			try {
//				result = MemberDao.idCheck(request);
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//
//			if (result == 1) { // 아이디 중복됨
//				response.getWriter().print("1");
//			} else {
//				response.getWriter().print("0");
//			}
//
//		}		
//		// 로그인 액션
//		else if(command.equals("login.do")) { 
//			request.setCharacterEncoding("UTF-8");
//
//			String login_referer = request.getParameter("login_referer");
//			System.out.println("login_referer :" + login_referer);
//
//			HttpSession session = request.getSession();
//			
//			int loginResult = 0;
//			try {
//				loginResult = MemberDao.login(request);
//				System.out.println("loginResult : " + loginResult);
//				
//			} catch (Exception e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//			
//			if(loginResult == 2) {
//				
//				response.sendRedirect("/project_ezen/admin_member/pageFile.jsp");
//			}
//			else if (loginResult == 1) {
//				
//				if(login_referer.indexOf("find_id_pw") == -1 ) {
//					response.sendRedirect(login_referer); 
//				} else {
//					response.sendRedirect("/project_ezen/main.do");
//				}
//				 
//			} else {
//				request.setAttribute("loginResult", loginResult);
//				System.out.println("loginResult2 : " + loginResult);
//
////				response.sendRedirect("/project_ezen/member/loginForm.jsp");
//				jspPage = "/member/loginForm.jsp";
//			}
//
//		}			
//		//아이디 찾기 액션
//		else if(command.equals("idFind.do"))
//		{
//			String id_find_failed = null;
//			try 
//			{
////				String member_name = request.getParameter("find_name");
////				String member_email = request.getParameter("find_mail01");
////				System.out.println("name : "+member_name);
////				System.out.println("email : "+member_email);
//				
//				id_find_failed = MemberDao.idFind(request);
//				
//			} 
//			catch (Exception e) 
//			{
//				e.printStackTrace();
//			}
//			if(id_find_failed.equals("failed")) {
//				request.setAttribute("id_find_failed", id_find_failed);
//				
//				jspPage = "/member/find_id_pw.jsp";
//			} else {
////				RequestDispatcher dispatcher = request.getRequestDispatcher("/member/find_id_pw.jsp");
////				dispatcher.forward(request, response);
//				//위의 코드로 페이지 이동시키면 뒤로가기 연타 시 세션 문제가 발생하므로 아래처럼 보내줘야 함 
//				response.sendRedirect("/project_ezen/member/find_id_pw.jsp");
//			}
//		}		
//		//찾은 아이디 넘기기
//		else if (command.equals("id_move")) {
//			String finded_id = request.getParameter("finded_id");
//			System.out.println("finded_id : " + finded_id);
//
////			request.setAttribute("finded_id", finded_id);
//
//			HttpSession session = request.getSession();
//			session.setAttribute("finded_id",finded_id);
////			RequestDispatcher dispatcher = request.getRequestDispatcher("/member/loginForm.jsp");
////			dispatcher.forward(request, response);
//			response.sendRedirect("/project_ezen/member/loginForm.jsp");
//		}
//		//비밀번호 찾기 액션
//		else if(command.equals("find_pw.do"))
//		{
//			String pw_find_failed = null;
//			try 
//			{
//				String member_id = request.getParameter("find_id");
//				String member_email = request.getParameter("find_mail02");
//				System.out.println("name : "+member_id);
//				System.out.println("email : "+member_email);
//				
//				pw_find_failed = MemberDao.find_pw(request);
//				
//			} 
//			catch (Exception e) 
//			{
//				e.printStackTrace();
//			}
//			if(pw_find_failed.equals("failed")) {
//				request.setAttribute("pw_find_failed", pw_find_failed);
//				
//				jspPage = "/member/find_id_pw.jsp";
//			} else {
////				RequestDispatcher dispatcher = request.getRequestDispatcher("/member/find_id_pw.jsp");
////				dispatcher.forward(request, response);
//				//위의 코드로 페이지 이동시키면 뒤로가기 연타 시 세션 문제가 발생하므로 아래처럼 보내줘야 함 
//				response.sendRedirect("/project_ezen/member/find_id_pw.jsp");
//			}
//		}		
//
//		
//		
//		
//		
//		
//		
//		
//		
//
//		if( !jspPage.equals("") ) { //jsp페이지가 비어있지 않다면,
//			RequestDispatcher dispatcher = request.getRequestDispatcher( jspPage );
//			dispatcher.forward(request, response);
//		}
//	}
//	
//	
//}