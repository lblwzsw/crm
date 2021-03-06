package com.lwz.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.lwz.entity.CustomInfo;

@Repository
public interface CustomInfoDao {
    int deleteByPrimaryKey(Integer id);

    int insert(CustomInfo record);

    int insertSelective(CustomInfo record);

    CustomInfo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CustomInfo record);

    int updateByPrimaryKey(CustomInfo record);
    
    List<Map<String,Object>> customInfo(@Param("src")Integer src, @Param("followManId")Integer followManId);
    
    List<Map<String,Object>> selectForCountOnCurrentMonthByFId(Integer followManId);
    
    List<Map<String,Object>> queryAllCountCurrentMonth(Integer departmentId);
    
    List<Map<String,Object>> countInfoForDepart(Integer departmentId);
}