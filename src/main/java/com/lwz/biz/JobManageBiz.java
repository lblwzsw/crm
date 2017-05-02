package com.lwz.biz;

import java.util.List;

import com.lwz.entity.Job;

public interface JobManageBiz {

	List<Job> queryAllJobs();

	String insertJob(Job job);

	void updateJob(Job job);

	void deleteJob(Integer id);

}