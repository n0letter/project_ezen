//package project_ezen;
//
//import java.io.IOException;
//
//import javax.servlet.Filter;
//import javax.servlet.FilterChain;
//import javax.servlet.FilterConfig;
//import javax.servlet.ServletException;
//import javax.servlet.ServletRequest;
//import javax.servlet.ServletResponse;
//import javax.servlet.annotation.WebFilter;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//@WebFilter(urlPatterns = "/*")
//public class TestController implements Filter{
//  
//  @Override
//  public void init (FilterConfig filterConfig) throws ServletException {
//
//  }
//
//  @Override
//  public void doFilter (ServletRequest request,
//                        ServletResponse response, FilterChain chain)
//            throws IOException, ServletException {
//      String url = request instanceof HttpServletRequest ?
//                ((HttpServletRequest) request).getRequestURL().toString() : "N/A";
//      System.out.println("from filter, processing url: "+url);
//      chain.doFilter(request, response);
// 
//      int cmdIdx = url.lastIndexOf("/")+1;
//		String command = url.substring(cmdIdx);
//		String jspPage = "";
//		
//		System.out.println("로그인command:"+command);
//		
//
//
//       
//		
//		
//		
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
//			response.sendRedirect("/project_ezen/member/joinForm.jsp");
//		}
//      
//  }
//
//  @Override
//  public void destroy () {
//
//  }
//}