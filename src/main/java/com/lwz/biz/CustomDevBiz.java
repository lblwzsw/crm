package com.lwz.biz;

import java.util.List;
import java.util.Map;

import com.lwz.entity.CustomInfo;

public interface CustomDevBiz {

	List<Map<String, Object>> customInfo(Integer src, Integer followManId);

	int addMark(CustomInfo customInfo);

	void updateCustomInfo(CustomInfo customInfo);

}