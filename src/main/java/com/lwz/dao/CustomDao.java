package com.lwz.dao;

import java.util.List;

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
    
    List<Custom> queryAllCustom();
}