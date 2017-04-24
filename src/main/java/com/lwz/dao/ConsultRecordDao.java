package com.lwz.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
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
    
    List<Map<String,Object>> selectByConsultManId(Map<String,Object> map);
    
    int updateRecord(@Param("id")Integer id, @Param("consultStatu")String consultStatu);
    
    int queryCount(Map<String,Object> map);
    
    List<Map<String,Object>> queryCountCurrentMonth(Integer consultManId);
}