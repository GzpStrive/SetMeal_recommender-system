package main.java.servlet;
/**
 * 留言过滤器
 */
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MessageFilter implements Filter{
	private List<String> listLllegals = new ArrayList<String>();
	
	public void destroy() {
		
	}

	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) arg0;
		HttpServletResponse response = (HttpServletResponse) arg1;
		request.setCharacterEncoding("utf-8");
		String comment = request.getParameter("comment");
		for(int i=0;i<comment.length();i++) {
			String c = comment.substring(i,i+1);
			System.out.println(c);
			if(this.listLllegals.contains(c)) {   
				response.sendRedirect("message.jsp");//重定向
				return;
			}
		}
		arg2.doFilter(request, response);
		
	}

	public void init(FilterConfig arg0) throws ServletException {
		String illegal = arg0.getInitParameter("illegal");
		String[] illegals = illegal.split(",");
		for (String string : illegals) {
			this.listLllegals.add(string);
		}
		System.out.println(this.listLllegals);
	}
	

}
