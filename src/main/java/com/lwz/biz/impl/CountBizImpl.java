package com.lwz.biz.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lwz.biz.CountBiz;
import com.lwz.dao.ConsultRecordDao;
import com.lwz.dao.CustomInfoDao;



@Service
public class CountBizImpl implements CountBiz {

	@Resource
	private CustomInfoDao customInfoDao;
	@Resource
	private ConsultRecordDao consultRecordDao;
	
	/* (non-Javadoc)
	 * @see com.lwz.biz.impl.CountBiz#countInfo(java.lang.Integer)
	 */
	public List<Map<String,Object>> countInfo(Integer followManId){
		 
		return customInfoDao.selectForCountOnCurrentMonthByFId(followManId);
	}
	
	/* (non-Javadoc)
	 * @see com.lwz.biz.impl.CountBiz#countConsult(java.lang.Integer)
	 */
	public List<Map<String,Object>> countConsult(Integer consultManId){
		
		return consultRecordDao.selectForCountOnCurrentMonthByCId(consultManId);
	}
}
