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
    
    List<Map<String,Object>> selectByConsultManIdSelective(Map<String,Object> map);
    
    int updateStatu(@Param("id")Integer id, @Param("consultStatu")String consultStatu);
    
    int queryCount(Map<String,Object> map);
    
    List<Map<String,Object>> selectForCountOnCurrentMonthByCId(Integer consultManId);
    
    List<Map<String,Object>> queryAllCountCurrentMonth();
    
    List<Map<String,Object>> countConsultForDepart();
    
    List<Map<String,Object>> selectByConsultManIdNoPage(@Param("type")Integer type, @Param("consultManId") Integer consultManId);
}