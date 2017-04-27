package com.lwz.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lwz.biz.impl.LoginBizImpl;
import com.lwz.entity.Employee;
import com.lwz.entity.Right;

@Controller
public class IndexController {

	@Resource
	LoginBizImpl loginBiz;
	
	@RequestMapping("login")
	public @ResponseBody String login(String username, String pass, HttpServletRequest req){
		Employee user = new Employee();
		if((user = loginBiz.checkLogin(username, pass))!=null){
			//验证通过
			HttpSession session = req.getSession();
			session.setAttribute("user", user);
			List<Right> rights = loginBiz.getRights(user);
			
			session.setAttribute("rights", rights);
			return "1";
		}else{
			return "0";
		}
	}
	@RequestMapping("index")
	public String index(){
		return "login";
	}
}
