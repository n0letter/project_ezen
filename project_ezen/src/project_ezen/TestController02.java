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
//public class TestController02 implements Filter{
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
//  }
//
//  @Override
//  public void destroy () {
//
//  }
//}