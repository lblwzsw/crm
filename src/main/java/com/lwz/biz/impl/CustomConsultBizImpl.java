package com.lwz.biz.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lwz.dao.ConsultRecordDao;
import com.lwz.dao.CustomDao;
import com.lwz.entity.ConsultRecord;
import com.lwz.entity.Custom;

@Service
public class CustomConsultBizImpl {

	@Resource
	private ConsultRecordDao consultRecordDao;
	@Resource
	private CustomDao customDao;
	
	public Map<String,Object> queryRecord(Integer page, Integer rows,Map<String,Object> map){
		Map<String,Object> rmap = new HashMap<String,Object>();
		Integer total = consultRecordDao.queryCount(map);
		Integer start = rows * (page-1);
		map.put("start", start);
		map.put("rows",page);
		List<Map<String, Object>> list = consultRecordDao.selectByConsultManIdSelective(map);
		rmap.put("rows", list);
		rmap.put("total", total);
		return rmap;
	}
	
	@Transactional
	public int updateRecord(Integer id, Integer customId, String consultStatu){
		Custom custom = new Custom();
		custom.setId(customId);
		if("2".equals(consultStatu)){
			custom.setCustomStatu("5");
		}else if("3".equals(consultStatu)){
			custom.setCustomStatu("4");
		}else if("4".equals(consultStatu)){
			custom.setCustomStatu("3");
		}
		customDao.updateByPrimaryKeySelective(custom);
		
		return consultRecordDao.updateStatu(id, consultStatu);
	}
	
	public int addResult(ConsultRecord consultRecord){
		return consultRecordDao.updateByPrimaryKeySelective(consultRecord);
	}
}
