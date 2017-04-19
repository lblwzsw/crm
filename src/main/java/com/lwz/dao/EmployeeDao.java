package com.lwz.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.lwz.entity.Employee;
import com.lwz.entity.Resetpass;

@Repository
public interface EmployeeDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Employee record);

    int insertSelective(Employee record);

    Employee selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Employee record);

    int updateByPrimaryKey(Employee record);
    
    Employee selectByUsername(@Param("username")String username, @Param("pass")String pass);
    
    int checkUsername(String username);
    
    int resetPassByUsername(@Param("username")String username, @Param("pass")String pass);
}