package com.lwz.biz;

import java.util.List;

import com.lwz.entity.Employee;
import com.lwz.entity.Right;

public interface LoginBiz {

	Employee checkLogin(String username, String pass);

	List<Right> getRights(Employee user);

	String changePass(Integer id, String pass, String newPass);
	
	String reqResetPass(String username, String phoneNo);
}