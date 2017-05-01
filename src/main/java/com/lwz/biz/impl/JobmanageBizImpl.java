package com.lwz.biz.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lwz.dao.JobDao;
import com.lwz.entity.Job;

@Service
public class JobmanageBizImpl {

	@Resource
	private JobDao jobdao;
	
	public List<Job> queryAllJobs(){
		return jobdao.queryAllJobs();
	}
	
	public String insertJob(Job job){
		if(jobdao.insertSelective(job)==1)
			return "1";
		else 
			return "0";
	}
	
	public void updateJob(Job job){
		jobdao.updateByPrimaryKeySelective(job);
	}
	
	public void deleteJob(Integer id){
		jobdao.deleteByPrimaryKey(id);
	}
}
