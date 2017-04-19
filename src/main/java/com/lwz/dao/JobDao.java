package com.lwz.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.lwz.entity.Job;

@Repository
public interface JobDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Job record);

    int insertSelective(Job record);

    Job selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Job record);

    int updateByPrimaryKey(Job record);
    
    List<Job> getJobsByDid(Integer dId);
}