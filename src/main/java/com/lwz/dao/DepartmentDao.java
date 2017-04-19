package com.lwz.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.lwz.entity.Department;

@Repository
public interface DepartmentDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Department record);

    int insertSelective(Department record);

    Department selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Department record);

    int updateByPrimaryKey(Department record);
    
    List<Department> getDepartments();
}