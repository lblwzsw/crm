package com.lwz.biz;

import java.util.List;

import com.lwz.entity.Department;
import com.lwz.entity.Employee;
import com.lwz.entity.Job;
import com.lwz.entity.Resetpass;

public interface UserManageBiz {

	//获取表单部门信息
	List<Department> getDepartments();

	//获取表单职位信息
	List<Job> getJobsByDid(Integer dId);

	int addUser(Employee e);

	boolean checkUsername(String username);

	List<Resetpass> querRestRequest();

	int resetPass(Resetpass resetPass, String pass);

	String cancleUser(String username);

}