package com.lwz.biz.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lwz.dao.JobRightDao;
import com.lwz.dao.RightDao;
import com.lwz.entity.JobRight;
import com.lwz.entity.Right;

@Service
public class RightManageBizImpl {
	
	@Resource
	private RightDao rightDao;
	@Resource
	private JobRightDao jobRightDao;
	
	public List<Right> queryAllRights(){
		return rightDao.queryAllRights();
	}
	
	public List<JobRight> queryAllBind(){
		return jobRightDao.queryAllBind();
	}
	
	public void updateBind(JobRight jobRight){
		jobRightDao.updateByPrimaryKeySelective(jobRight);
	}
	
	public void deleteBind(JobRight jobRight){
		jobRightDao.deleteByPrimaryKey(jobRight.getId());
	}
	
	public void insertBind(JobRight jobRight){
		jobRightDao.insertSelective(jobRight);
	}
	public String insertRight(Right right){
		if(rightDao.insertSelective(right)==1){
			return "1";
		}
		return "0";
	}
}
