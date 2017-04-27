package com.lwz.interceptor;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws IOException{
		HttpSession session = req.getSession();
		if(session.getAttribute("user")==null){
			resp.sendRedirect("index.do");
			return false;
		}
		return true;
	}
}
