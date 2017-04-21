package com.lwz.biz.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lwz.dao.CustomInfoDao;
import com.lwz.entity.CustomInfo;

@Service
public class CustomDevBizImpl {

//	private final int SRC_TODAY = 0; start_date=curdate()
//	private final int SRC_HISTORY = 1;start_date<date_add(curdate(),interval -day(curdate())+1 day)
//	private final int SRC_TODAY_PLAN = 2;plan_date=curdate()
//	private final int SRC_MONTH = 3;start_date>=date_add(curdate(),interval -day(curdate())+1 day)
	
	@Resource
	private CustomInfoDao customInfoDao;
	
	public List<Map<String,Object>> customInfo(Integer src, Integer followManId){
		return customInfoDao.customInfo(src, followManId);
	}
	
	public int addMark(CustomInfo customInfo){
		return customInfoDao.updateByPrimaryKeySelective(customInfo);
	}
}
