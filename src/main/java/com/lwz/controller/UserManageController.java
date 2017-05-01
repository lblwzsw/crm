package com.lwz.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lwz.biz.impl.UserManageBizImpl;
import com.lwz.entity.Department;
import com.lwz.entity.Employee;
import com.lwz.entity.Job;
import com.lwz.entity.Resetpass;

@Controller
public class UserManageController {

	@Resource
	private UserManageBizImpl userManageBiz;
	
	@RequestMapping(value="addUser")
	public @ResponseBody String addUser(Employee employee){
		String pass = DigestUtils.sha1Hex("123456");
		employee.setPass(pass);
		if(employee.getDepartmentId() == null){
			employee.setDepartmentId(1);
			employee.setJobinfoId(2);
		}
		if(userManageBiz.addUser(employee) == 1){
			return "1";
		}
		return "0";
	}
	@RequestMapping(value="getDepartment", produces="application/json;charset=utf-8")
	public @ResponseBody String getDepartment(){
		List<Department> departments = userManageBiz.getDepartments();
		ObjectMapper oMapper = new ObjectMapper();
		String json = "";
		try {
			json = oMapper.writeValueAsString(departments);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return json;
	}
	
	@RequestMapping(value="getJobByDid", produces="application/json;charset=utf-8")
	public @ResponseBody String getJobByDid(Integer departmentId){
		List<Job> jobs = userManageBiz.getJobsByDid(departmentId);
		ObjectMapper oMapper = new ObjectMapper();
		String json = "";
		try {
			json = oMapper.writeValueAsString(jobs);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return json;
	}
	@RequestMapping(value="checkUsername")
	public @ResponseBody String checkUsername(String username){
		if(userManageBiz.checkUsername(username)){
			return "false";
		}
		return "true";
	}
	@RequestMapping(value="querRestRequest", produces="application/json;charset=utf-8")
	public @ResponseBody String querRestRequest(){
		List<Resetpass> resetpasses = userManageBiz.querRestRequest();
		ObjectMapper oMapper = new ObjectMapper();
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("rows", resetpasses);
		String json = "";
		try {
			json = oMapper.writeValueAsString(map);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return json;
	}
	@RequestMapping(value="resetPass")
	public @ResponseBody String resetPass(Resetpass resetPass){
		String pass = DigestUtils.sha1Hex("123456");
		if(userManageBiz.resetPass(resetPass,pass)==1){
			return "1";
		}
		return "0";
	}
	@RequestMapping(value="cancleUser")
	public @ResponseBody String cancleUser(String username){
		return userManageBiz.cancleUser(username);
	}
}
