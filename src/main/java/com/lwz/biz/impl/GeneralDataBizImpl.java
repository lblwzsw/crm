package com.lwz.biz.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lwz.dao.EmployeeDao;
import com.lwz.entity.Employee;

@Service
public class GeneralDataBizImpl {

	@Resource
	private EmployeeDao employeeDao;
	
	public List<Map<String,Object>> empForJobId(String jobinfoId){
		return employeeDao.empForJobId(jobinfoId);
	}
}
