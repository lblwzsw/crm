package com.lwz.biz.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lwz.biz.JobManageBiz;
import com.lwz.dao.JobDao;
import com.lwz.entity.Job;

@Service
public class JobmanageBizImpl implements JobManageBiz {

	@Resource
	private JobDao jobdao;
	
	/* (non-Javadoc)
	 * @see com.lwz.biz.impl.JobManageBiz#queryAllJobs()
	 */
	public List<Job> queryAllJobs(){
		return jobdao.queryAllJobs();
	}
	
	/* (non-Javadoc)
	 * @see com.lwz.biz.impl.JobManageBiz#insertJob(com.lwz.entity.Job)
	 */
	public String insertJob(Job job){
		if(jobdao.insertSelective(job)==1)
			return "1";
		else 
			return "0";
	}
	
	/* (non-Javadoc)
	 * @see com.lwz.biz.impl.JobManageBiz#updateJob(com.lwz.entity.Job)
	 */
	public void updateJob(Job job){
		jobdao.updateByPrimaryKeySelective(job);
	}
	
	/* (non-Javadoc)
	 * @see com.lwz.biz.impl.JobManageBiz#deleteJob(java.lang.Integer)
	 */
	public void deleteJob(Integer id){
		jobdao.deleteByPrimaryKey(id);
	}
}
