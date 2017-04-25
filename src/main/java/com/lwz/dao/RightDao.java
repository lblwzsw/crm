package com.lwz.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.lwz.entity.Right;

@Repository
public interface RightDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Right record);

    int insertSelective(Right record);

    Right selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Right record);

    int updateByPrimaryKey(Right record);
    
    List<Right> selectByRIds(@Param("rIds")List<Integer> rIds);
    
    List<Right> queryAllRights();
}