package com.lwz.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.util.JSONPObject;
import com.lwz.biz.RightManageBiz;
import com.lwz.entity.JobRight;
import com.lwz.entity.Right;

@Controller
public class RightManageController {

	private ObjectMapper oMapper = new ObjectMapper();
	
	@Resource
	private RightManageBiz rightManageBiz;
	
	@RequestMapping(value="queryAllRights", produces="application/json;charset=utf-8")
	public @ResponseBody String queryAllRights(){
		List<Right> list = rightManageBiz.queryAllRights();
		String json = "";
		try {
			json = oMapper.writeValueAsString(list);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return json;
	}
	@RequestMapping(value="queryAllBind", produces="application/json;charset=utf-8")
	public @ResponseBody String queryAllBind(){
		List<JobRight> list = rightManageBiz.queryAllBind();
		String json = "";
		try {
			json = oMapper.writeValueAsString(list);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return json;
	}
	@RequestMapping(value="updateBind")
	public @ResponseBody String updateBind(JobRight jobRight){
		if(jobRight.getId()!=null){
			rightManageBiz.updateBind(jobRight);
		}else{
			rightManageBiz.insertBind(jobRight);
		}
		return "";
	}
	@RequestMapping(value="deleteBind")
	public @ResponseBody String deleteBind(JobRight jobRight){
		rightManageBiz.deleteBind(jobRight);
		return "";
	}
	@RequestMapping(value="insertRight")
	public @ResponseBody String insertRight(Right right){
		right.setrType("2");
		return rightManageBiz.insertRight(right);
	}
}
