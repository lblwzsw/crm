package com.lwz.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lwz.biz.impl.CustomdateBizImpl;
import com.lwz.entity.Custom;
import com.lwz.entity.Department;

@Controller
public class CustomdateController {

	@Resource
	private CustomdateBizImpl customdateBiz;
	
	@RequestMapping(value="insertCustom")
	public @ResponseBody String insertCustom(Custom custom){
		custom.setCreateDate(new Date());
		if(customdateBiz.insertCustom(custom) == 1){
			return "1";
		}
		return "0";
	}
	@RequestMapping(value="queryCustom")
	public @ResponseBody String queryCustom(){
		List<Custom> customs = customdateBiz.queryCustom();
		Map<String,Object> map = new HashMap<String,Object>();
		ObjectMapper oMapper = new ObjectMapper();
		String json = "";
		map.put("rows", customs);
		map.put("total", customs.size());
		try {
			json = oMapper.writeValueAsString(map);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return json;
	}
}
