package com.lwz.biz.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lwz.dao.CustomDao;
import com.lwz.entity.Custom;

@Service
public class CustomdateBizImpl {
	
	@Resource
	private CustomDao customDao;
	
	public int insertCustom(Custom custom){
		return customDao.insertSelective(custom);
	}
	
	public List<Custom> queryCustom(){
		return customDao.queryAllCustom();
	}
}
