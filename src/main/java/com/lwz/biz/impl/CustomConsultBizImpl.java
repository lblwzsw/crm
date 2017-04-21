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
	
	public Map<String,Object> queryRecord(Integer page, Integer rows,Map<String,Object> map){
		Map<String,Object> rmap = new HashMap<String,Object>();
		Integer total = consultRecordDao.queryCount(map);
		Integer start = rows * (page-1);
		map.put("start", start);
		map.put("rows",page);
		List<Map<String, Object>> list = consultRecordDao.selectByConsultManId(map);
		rmap.put("rows", list);
		rmap.put("total", total);
		return rmap;
	}
	
	public int updateRecord(Integer id, String consultStatu){
		return consultRecordDao.updateRecord(id, consultStatu);
	}
	
	public int addResult(ConsultRecord consultRecord){
		return consultRecordDao.updateByPrimaryKeySelective(consultRecord);
	}
}
