package com.lwz.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.util.JSONPObject;

@Controller
public class RightManageController {

	@RequestMapping(value="queryAllRights", produces="application/json;charset=utf-8")
	public @ResponseBody String queryAllRights(){
		
		ObjectMapper oMapper = new ObjectMapper();
		try {
			oMapper.writeValueAsString(null);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		return "[{\"rid\":1,\"rightName\":\"aas\",\"rightType\":1,\"url\":\"adsfsafd\",\"pid\":3},{\"rid\":1,\"rightName\":\"aas\",\"rightType\":1,\"url\":\"adsfsafd\",\"pid\":3}]";
	}
}
