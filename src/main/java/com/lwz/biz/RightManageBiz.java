package com.lwz.biz;

import java.util.List;

import com.lwz.entity.JobRight;
import com.lwz.entity.Right;

public interface RightManageBiz {

	List<Right> queryAllRights();

	List<JobRight> queryAllBind();

	void updateBind(JobRight jobRight);

	void deleteBind(JobRight jobRight);

	void insertBind(JobRight jobRight);

	String insertRight(Right right);

}