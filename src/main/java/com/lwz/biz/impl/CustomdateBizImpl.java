package com.lwz.biz.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lwz.dao.ConsultRecordDao;
import com.lwz.dao.CustomDao;
import com.lwz.dao.CustomInfoDao;
import com.lwz.dao.EmployeeDao;
import com.lwz.entity.ConsultRecord;
import com.lwz.entity.Custom;
import com.lwz.entity.CustomInfo;

@Service
public class CustomdateBizImpl {
	
	@Resource
	private EmployeeDao employeeDao; 
	@Resource
	private CustomDao customDao;
	@Resource
	private ConsultRecordDao consultRecordDao;
	@Resource
	private CustomInfoDao customInfoDao;
	
	public int insertCustom(Custom custom){
		return customDao.insertSelective(custom);
	}
	
	public Map<String,Object> queryCustom(Integer page, Integer rows, Custom custom){
		Map<String,Object> map = new HashMap<String,Object>();
		Integer total = customDao.queryCount();
		Integer start = rows * (page-1);
		List<Custom> list = customDao.queryAllCustom(start, rows, custom);
		map.put("rows", list);
		map.put("total", total);
		return map;
	}
	
	public List<Map<String,Object>> queryAllConsulters(){
		List<Map<String,Object>> list = employeeDao.queryAllConsulters();
		return list;
	}
	
	public int allotToConsult(ConsultRecord consultRecord){
		return consultRecordDao.insertSelective(consultRecord);
	}
	
	public int changeCustomStatu(Custom custom){
		return customDao.updateByPrimaryKeySelective(custom);
	}
	
	public int updateCustom(Custom custom){
		return customDao.updateByPrimaryKeySelective(custom);
	}
	
	@Transactional
	public int allotCustom(){
		List<Integer> cList = customDao.queryAllCustomForEMT();
		List<Integer> eList = employeeDao.queryAllEMT();
		customDao.UpdateCustomState();
		List<CustomInfo> ciList = new LinkedList<CustomInfo>();
		int ir = cList.size()/eList.size();
		int jr = eList.size();
		for (int i = 0; i < ir; i++) {
			for (int j = 0; j < jr; j++) {
				CustomInfo ci = new CustomInfo();
				ci.setStartDate(new Date());
				ci.setFollowManId(eList.get(j));
				ci.setcId(cList.get(0));
				cList.remove(0);
				ciList.add(ci);
			}
		}
		Random random = new Random();
		for (Integer cId : cList) {
			CustomInfo ci = new CustomInfo();
			ci.setStartDate(new Date());
			ci.setcId(cId);
			int index = random.nextInt(eList.size());
			ci.setFollowManId(eList.get(index));
			eList.remove(index);
			ciList.add(ci);
		}
		int flag = 0;
		for (CustomInfo customInfo : ciList) {
			flag = customInfoDao.insertSelective(customInfo);
		}
		
		return flag;
	}
}
