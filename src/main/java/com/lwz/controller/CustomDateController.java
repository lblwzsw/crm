package com.lwz.controller;

import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lwz.biz.impl.CustomDateBizImpl;
import com.lwz.entity.ConsultRecord;
import com.lwz.entity.Custom;
import com.lwz.entity.Department;

@Controller
public class CustomDateController {
	
	@Resource
	private CustomDateBizImpl customdateBiz;
	
	@RequestMapping(value="insertCustom")
	public @ResponseBody String insertCustom(Custom custom){
		custom.setCreateDate(new Date());
		if(customdateBiz.insertCustom(custom) == 1){
			return "1";
		}
		return "0";
	}
	@RequestMapping(value="queryCustom", produces="application/json;charset=utf-8")
	public @ResponseBody String queryCustom(Integer page, Integer rows, Custom custom){
		Map<String, Object> map = customdateBiz.queryCustom(page, rows, custom);
		ObjectMapper oMapper = new ObjectMapper();
		String json = "";
		try {
			json = oMapper.writeValueAsString(map);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return json;
	}
	@RequestMapping(value="queryConsulters", produces="application/json;charset=utf-8")
	public @ResponseBody String queryConsulters(){
		List<Map<String, Object>> list = customdateBiz.queryAllConsulters();
		ObjectMapper oMapper = new ObjectMapper();
		String json = "";
		try {
			json = oMapper.writeValueAsString(list);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return json;
	}
	@Transactional
	@RequestMapping(value="allotToConsult")
	public @ResponseBody String allotToConsult(ConsultRecord consultRecord){
		consultRecord.setConsultDate(new Date());
		Custom custom = new Custom();
		custom.setId(consultRecord.getcId());
		custom.setCustomStatu("3");
		customdateBiz.changeCustomStatu(custom);
		if(customdateBiz.allotToConsult(consultRecord)==1){
			return "1";
		}
		return "0";
	}
	@RequestMapping(value="updateCustom")
	public @ResponseBody String updateCustom(Custom custom){
		custom.setCreateDate(null);
		if(customdateBiz.updateCustom(custom)==1){
			return "1";
		}
		return "0";
	}
	@RequestMapping(value="allotCustom")
	public @ResponseBody String allotCustom(){
		if(customdateBiz.allotCustom()==1){
			return "1";
		}
		return "0";
	}
}
