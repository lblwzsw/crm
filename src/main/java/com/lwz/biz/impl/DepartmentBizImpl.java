package com.lwz.biz.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lwz.dao.ConsultRecordDao;
import com.lwz.dao.CustomInfoDao;
import com.lwz.dao.EmployeeDao;

@Service
public class DepartmentBizImpl {

	@Resource
	private ConsultRecordDao consultRecordDao;
	@Resource
	private CustomInfoDao customInfoDao;
	@Resource
	private EmployeeDao employeeDao;
	
	public List<Map<String,Object>> empForDepart(Integer departmentId){
		return employeeDao.empForDepart(departmentId);
	}
	
	public List<Map<String,Object>> countInfoForDepart(Integer departmentId){
		return customInfoDao.countInfoForDepart(departmentId);
	}
	
	public List<Map<String,Object>> countConsultForDepart(){
		return consultRecordDao.countConsultForDepart();
	}
}
