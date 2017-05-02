package com.lwz.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lwz.biz.JobManageBiz;
import com.lwz.entity.Job;

@Controller
public class JobmanageController {

	private ObjectMapper oMapper = new ObjectMapper();
	
	@Resource
	private JobManageBiz jobmanageBiz;
	
	@RequestMapping(value="queryAllJobs", produces="application/json;charset=utf-8")
	public @ResponseBody String queryAllJobs(){
		List<Job> list = jobmanageBiz.queryAllJobs();
		String json = "";
		try {
			json = oMapper.writeValueAsString(list);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return json;
	}
	
	@RequestMapping(value="insertJob")
	public @ResponseBody String insertJob(Job job){
		return jobmanageBiz.insertJob(job);
	}
	
	@RequestMapping(value="updateJob")
	public @ResponseBody String updateJob(Job job){
		jobmanageBiz.updateJob(job);
		return "";
	}
	@RequestMapping(value="deleteJob")
	public @ResponseBody String deleteJob(Integer id){
		jobmanageBiz.deleteJob(id);
		return "";
	}
}
