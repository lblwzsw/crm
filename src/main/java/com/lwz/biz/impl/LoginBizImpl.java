package com.lwz.biz.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lwz.dao.EmployeeDao;
import com.lwz.dao.JobRightDao;
import com.lwz.dao.RightDao;
import com.lwz.entity.Employee;
import com.lwz.entity.Right;

@Service
public class LoginBizImpl {

	@Resource
	private EmployeeDao employeeDao;
	@Resource
	private JobRightDao jobRightDao;
	@Resource
	private RightDao rightDao;
	
	
	public Employee checkLogin(String username, String pass){
		Employee e = employeeDao.selectByUsername(username, pass);
		if(e!=null&&0!=e.getId()){
			return e;
		}else{
			return null;
		}
	}
	
	public List<Right> getRights(Employee user){
		List<Integer> rIds = jobRightDao.selectRIdByJId(user.getJobinfoId());
		List<Right> rights = rightDao.selectByRIds(rIds);
		
		return rights;
	}
}
