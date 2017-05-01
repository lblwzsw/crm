package com.lwz.biz.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lwz.dao.ConsultRecordDao;
import com.lwz.dao.CustomInfoDao;



@Service
public class CountBizImpl {

	@Resource
	private CustomInfoDao customInfoDao;
	@Resource
	private ConsultRecordDao consultRecordDao;
	
	public List<Map<String,Object>> countInfo(Integer followManId){
		 
		return customInfoDao.selectForCountOnCurrentMonthByFId(followManId);
	}
	
	public List<Map<String,Object>> countConsult(Integer consultManId){
		
		return consultRecordDao.selectForCountOnCurrentMonthByCId(consultManId);
	}
}
