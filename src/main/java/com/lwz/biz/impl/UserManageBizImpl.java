package com.lwz.biz.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lwz.dao.DepartmentDao;
import com.lwz.dao.EmployeeDao;
import com.lwz.dao.JobDao;
import com.lwz.dao.ResetpassDao;
import com.lwz.entity.Department;
import com.lwz.entity.Employee;
import com.lwz.entity.Job;
import com.lwz.entity.Resetpass;

@Service
public class UserManageBizImpl {
	
	@Resource
	private DepartmentDao departmentDao;
	@Resource
	private JobDao jobDao;
	@Resource
	private EmployeeDao employeeDao;
	@Resource
	private ResetpassDao resetpassDao;
	
	//获取表单部门信息
	public List<Department> getDepartments(){
		return departmentDao.getDepartments();
	}
	//获取表单职位信息
	public List<Job> getJobsByDid(Integer dId){
		return jobDao.getJobsByDid(dId);
	}
	
	public int addUser(Employee e){
		return employeeDao.insertSelective(e);
	}
	
	public boolean checkUsername(String username){
		if(employeeDao.checkUsername(username)==0){
			return false;
		}
		return true;
	}
	public List<Resetpass> querRestRequest(){
		return resetpassDao.querRestRequest();
	}
	public int resetPass(Resetpass resetPass, String pass){
		employeeDao.resetPassByUsername(resetPass.getUsername(), pass);
		if(resetpassDao.deleteById(resetPass.getId())==1){
			return 1;
		}
		return 0;
	}
	public String cancleUser(String username){
		if(employeeDao.checkUsername(username)==0){
			return "0";
		}else if(employeeDao.checkWorkStatu(username)==0){
			return "2";
		}else if(employeeDao.updateByUsername(username)==1){
			return "1";
		}else {
			return "-1";
		}
	}
}
