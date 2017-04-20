package com.lwz.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lwz.biz.impl.CustomConsultBizImpl;
import com.lwz.entity.ConsultRecord;

@Controller
public class CustomConsultController {

	@Resource
	private CustomConsultBizImpl customConsultBiz;
	
	@RequestMapping(value="queryRecord", produces="application/json;charset=utf-8")
	public @ResponseBody String queryRecord(Integer consultManId){
		
		ObjectMapper oMapper = new ObjectMapper();
		String json = "";
		try {
			json = oMapper.writeValueAsString(null);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return json;
	}
}
