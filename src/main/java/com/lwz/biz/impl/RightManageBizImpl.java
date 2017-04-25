package com.lwz.biz.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lwz.dao.RightDao;
import com.lwz.entity.Right;

@Service
public class RightManageBizImpl {
	
	@Resource
	private RightDao rightDao;
	
	public List<Right> queryAllRights(){
		return rightDao.queryAllRights();
	}
}
