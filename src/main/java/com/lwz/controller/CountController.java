package com.lwz.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lwz.biz.CountBiz;

@Controller
public class CountController {

	private ObjectMapper oMapper = new ObjectMapper();
	
	@Resource
	private CountBiz countBiz;
	
	@RequestMapping(value="countInfo", produces="application/json;charset=utf-8")
	public @ResponseBody String countInfo(Integer followManId){
		List<Map<String, Object>> map = countBiz.countInfo(followManId);
		String json = "";
		try {
			json = oMapper.writeValueAsString(map);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return json;
	}
	
	@RequestMapping(value="countConsult", produces="application/json;charset=utf-8")
	public @ResponseBody String countConsult(Integer consultManId){
		List<Map<String, Object>> map = countBiz.countConsult(consultManId);
		String json = "";
		try {
			json = oMapper.writeValueAsString(map);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return json;
	}
}
