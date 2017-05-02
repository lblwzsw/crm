package com.lwz.biz;

import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import com.lwz.entity.ConsultRecord;

public interface CustomConsultBiz {

	Map<String, Object> queryRecord(Integer page, Integer rows, Map<String, Object> map);

	int updateRecord(Integer id, Integer customId, String consultStatu);

	int addResult(ConsultRecord consultRecord);

}