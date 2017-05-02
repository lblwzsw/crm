package com.lwz.biz.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lwz.biz.GeneralDataBiz;
import com.lwz.dao.EmployeeDao;
import com.lwz.entity.Employee;

@Service
public class GeneralDataBizImpl implements GeneralDataBiz {

	@Resource
	private EmployeeDao employeeDao;
	
	/* (non-Javadoc)
	 * @see com.lwz.biz.impl.GeneralDataBiz#empForJobId(java.lang.String)
	 */
	public List<Map<String,Object>> empForJobId(String jobinfoId){
		return employeeDao.empForJobId(jobinfoId);
	}
}
