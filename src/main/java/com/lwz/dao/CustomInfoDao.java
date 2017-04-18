package com.lwz.dao;

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
}