package com.lwz.biz;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import com.lwz.entity.ConsultRecord;
import com.lwz.entity.Custom;

public interface CustomDateBiz {

	int insertCustom(Custom custom);

	Map<String, Object> queryCustom(Integer page, Integer rows, Custom custom);

	List<Map<String, Object>> queryAllConsulters();

	int allotToConsult(ConsultRecord consultRecord);

	int changeCustomStatu(Custom custom);

	int updateCustom(Custom custom);

	int allotCustom();

	String batchImportCustom(List<Custom> list);

}