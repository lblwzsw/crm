package com.lwz.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.lwz.entity.JobRight;

@Repository
public interface JobRightDao {
    int deleteByPrimaryKey(Integer id);

    int insert(JobRight record);

    int insertSelective(JobRight record);

    JobRight selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(JobRight record);

    int updateByPrimaryKey(JobRight record);
    
    List<Integer> selectRIdByJId(int jId);
}