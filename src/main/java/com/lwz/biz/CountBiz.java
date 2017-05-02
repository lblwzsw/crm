package com.lwz.biz;

import java.util.List;
import java.util.Map;

public interface CountBiz {

	List<Map<String, Object>> countInfo(Integer followManId);

	List<Map<String, Object>> countConsult(Integer consultManId);

}