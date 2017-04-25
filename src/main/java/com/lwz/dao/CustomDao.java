package com.lwz.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.lwz.entity.Custom;

@Repository
public interface CustomDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Custom record);

    int insertSelective(Custom record);

    Custom selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Custom record);

    int updateByPrimaryKey(Custom record);
    
    List<Custom> queryAllCustom(@Param("start") Integer start,@Param("rows") Integer rows,@Param("custom") Custom custom);
    
    int queryCount();
    
    List<Integer> queryAllCustomForEMT();
    
    int UpdateCustomState(String statu);
    
    int insertByList(List<Custom> list);
    
    List<Custom> queryAllCustomNoPage();
}