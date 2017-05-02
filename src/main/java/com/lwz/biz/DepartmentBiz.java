package com.lwz.biz;

import java.util.List;
import java.util.Map;

public interface DepartmentBiz {

	List<Map<String, Object>> empForDepart(Integer departmentId);

	List<Map<String, Object>> countInfoForDepart(Integer departmentId);

	List<Map<String, Object>> countConsultForDepart();

}