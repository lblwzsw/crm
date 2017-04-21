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
import com.lwz.biz.impl.CustomConsultBizImpl;
import com.lwz.entity.ConsultRecord;

@Controller
public class CustomConsultController {

	@Resource
	private CustomConsultBizImpl customConsultBiz;
	
	@RequestMapping(value="queryRecord", produces="application/json;charset=utf-8")
	public @ResponseBody String queryRecord(Integer page, Integer rows,Integer consultManId, String customName, String customPhoneNo, Date consultDate, Date endDate){
		
		//customName,customPhoneNo,consultDate/endDate,consultManId
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("consultManId",consultManId);
		map.put("customName",customName);
		map.put("customPhoneNo",customPhoneNo);
		map.put("consultDate",consultDate);
		map.put("endDate",endDate);
		Map<String,Object> rmap = customConsultBiz.queryRecord(page, rows, map);
		
		ObjectMapper oMapper = new ObjectMapper();
		String json = "";
		try {
			json = oMapper.writeValueAsString(rmap);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return json;
	}
	
}
