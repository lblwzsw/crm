package com.lwz.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lwz.biz.DepartmentBiz;

@Controller
public class DepartmentController {

	private ObjectMapper oMapper = new ObjectMapper();
	
	@Resource
	private DepartmentBiz departmentBiz;
	
	@RequestMapping(value="empForDepart",produces="application/json;charset=utf-8")
	public @ResponseBody String empForDepart(Integer departmentId){
		List<Map<String, Object>> list = departmentBiz.empForDepart(departmentId);
		String json = "";
		try {
			json = oMapper.writeValueAsString(list);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return json;
	}
	@RequestMapping(value="countInfoForDepart",produces="application/json;charset=utf-8")
	public @ResponseBody String countInfoForDepart(Integer departmentId){
		List<Map<String, Object>> list = departmentBiz.countInfoForDepart(departmentId);
		String json = "";
		try {
			json = oMapper.writeValueAsString(list);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return json;
	}
	@RequestMapping(value="countConsultForDepart",produces="application/json;charset=utf-8")
	public @ResponseBody String countConsultForDepart(){
		List<Map<String, Object>> list = departmentBiz.countConsultForDepart();
		String json = "";
		try {
			json = oMapper.writeValueAsString(list);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return json;
	}
	
}
