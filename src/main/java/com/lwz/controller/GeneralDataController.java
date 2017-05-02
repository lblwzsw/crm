package com.lwz.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lwz.biz.GeneralDataBiz;

@Controller
public class GeneralDataController {

	@Resource
	private GeneralDataBiz generalDataBiz;
	
	@RequestMapping(value="empForJobId", produces="application/json;charset=utf-8")	
	public @ResponseBody String empForJobId(String jobinfoId){
		List<Map<String, Object>> map = generalDataBiz.empForJobId(jobinfoId);
		ObjectMapper oMapper = new ObjectMapper();
		String json = "";
		try {
			json = oMapper.writeValueAsString(map);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return json;
	}
}
