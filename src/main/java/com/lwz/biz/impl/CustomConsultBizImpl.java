package com.lwz.biz.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lwz.dao.ConsultRecordDao;
import com.lwz.entity.ConsultRecord;

@Service
public class CustomConsultBizImpl {

	@Resource
	private ConsultRecordDao consultRecordDao;
	
	public List<ConsultRecord> queryRecord(Integer consultManId){
		return consultRecordDao.selectByConsultManId(consultManId);
	}
}
