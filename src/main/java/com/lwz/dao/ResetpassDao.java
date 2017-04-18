package com.lwz.dao;

import org.springframework.stereotype.Repository;

import com.lwz.entity.Resetpass;

@Repository
public interface ResetpassDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Resetpass record);

    int insertSelective(Resetpass record);

    Resetpass selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Resetpass record);

    int updateByPrimaryKey(Resetpass record);
}