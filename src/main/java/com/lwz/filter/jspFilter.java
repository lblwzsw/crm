package com.lwz.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class jspFilter implements Filter{

	public void init(FilterConfig filterConfig) throws ServletException {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
	        throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		HttpSession session = req.getSession();
		String referer = req.getHeader("referer");
		if(referer==null){
			req.getRequestDispatcher("error.jsp").forward(request, response);
		}else if(session.getAttribute("user")==null){
			resp.sendRedirect("index.do");
		}else{
			chain.doFilter(request, response);
		}
	}

	public void destroy() {
	}
	
}
