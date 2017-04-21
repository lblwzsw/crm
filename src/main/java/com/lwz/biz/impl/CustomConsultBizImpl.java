package com.lwz.biz.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.lwz.dao.ConsultRecordDao;
import com.lwz.entity.ConsultRecord;

@Service
public class CustomConsultBizImpl {

	@Resource
	private ConsultRecordDao consultRecordDao;
	
	public List<Map<String,Object>> queryRecord(Map<String,Object> map){
		return consultRecordDao.selectByConsultManId(map);
	}
	
	public int updateRecord(Integer id, String consultStatu){
		return consultRecordDao.updateRecord(id, consultStatu);
	}
	
	public int addResult(ConsultRecord consultRecord){
		return consultRecordDao.updateByPrimaryKeySelective(consultRecord);
	}
}
