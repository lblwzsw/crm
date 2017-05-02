package com.lwz.biz;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;

public interface ReportBiz {

	List<Map<String, Object>> allEmployees();

	List<Map<String, Object>> countInfoForDepart(Integer departmentId);

	ResponseEntity<byte[]> exportCustom(Integer type) throws IOException;

	void exportCustomInfo(Integer type, Integer followManId, HttpServletResponse response);

	void exportConsultRecord(Integer type, Integer consultManId, HttpServletResponse response);
}