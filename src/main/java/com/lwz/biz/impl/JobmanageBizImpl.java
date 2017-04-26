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
}
