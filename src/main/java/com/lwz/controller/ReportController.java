package com.lwz.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lwz.biz.impl.ReportBizImpl;

@Controller
public class ReportController {

	private ObjectMapper oMapper = new ObjectMapper();
	
	@Resource
	private ReportBizImpl reportBiz;
	
	@RequestMapping(value="allEmployees", produces="aplication/json;charset=utf-8")
	public @ResponseBody String allEmployees(){
		List<Map<String, Object>> list = reportBiz.allEmployees();
		String json = "";
		try {
			json = oMapper.writeValueAsString(list);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return json;
	}
	@RequestMapping(value="countInfoForDepart", produces="aplication/json;charset=utf-8")
	public @ResponseBody String countInfoForDepart(Integer departmentId){
		List<Map<String, Object>> list = reportBiz.countInfoForDepart(departmentId);
		String json = "";
		try {
			json = oMapper.writeValueAsString(list);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return json;
	}
	@RequestMapping(value="countConsultForDepart", produces="aplication/json;charset=utf-8")
	public @ResponseBody String countConsultForDepart(Integer departmentId){
		List<Map<String, Object>> list = reportBiz.countInfoForDepart(departmentId);
		String json = "";
		try {
			json = oMapper.writeValueAsString(list);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return json;
	}
	@RequestMapping(value="exportCustom")
	public ResponseEntity<byte[]> exportCustom(Integer type,HttpServletResponse resp) throws IOException{
		resp.setContentType("application/vnd.ms-excel");  
		resp.setCharacterEncoding("UTF-8");  
		return reportBiz.exportCustom(type);
	}
	/*@RequestMapping(value="exportCustomInfo")
	public ResponseEntity<byte[]> exportCustomInfo(){
		
	}
	@RequestMapping(value="exportConsultRecord")
	public ResponseEntity<byte[]> exportConsultRecord(){
		
	}*/
}
