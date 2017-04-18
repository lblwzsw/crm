package com.lwz.dao;

import org.springframework.stereotype.Repository;

import com.lwz.entity.ConsultRecord;

@Repository
public interface ConsultRecordDao {
    int deleteByPrimaryKey(Integer id);

    int insert(ConsultRecord record);

    int insertSelective(ConsultRecord record);

    ConsultRecord selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ConsultRecord record);

    int updateByPrimaryKey(ConsultRecord record);
}