package com.lwz.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lwz.biz.CustomDevBiz;
import com.lwz.entity.CustomInfo;

@Controller
public class CustomDevController {

//	private final int SRC_TODAY = 0;
//	private final int SRC_HISTORY = 1;
//	private final int SRC_TODAY_PLAN = 2;
//	private final int SRC_MONTH = 3;
	
	@Resource
	private CustomDevBiz cunstomDevBiz;
	
	@RequestMapping(value="customInfo", produces="application/json;charset=utf-8")
	public @ResponseBody String customInfo(Integer src, Integer followManId){
		List<Map<String, Object>> list = cunstomDevBiz.customInfo(src, followManId);
		ObjectMapper oMapper = new ObjectMapper();
		String json = "";
		try {
			json = oMapper.writeValueAsString(list);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return json;
	}
	@RequestMapping(value="addMark")
	public @ResponseBody String addMark(CustomInfo customInfo){
		if(cunstomDevBiz.addMark(customInfo)==1){
			return "1";
		}
		return "0";
	}
	@RequestMapping(value="updateCustomInfo")
	public void updateCustomInfo(CustomInfo customInfo){
		cunstomDevBiz.updateCustomInfo(customInfo);
	}
}
