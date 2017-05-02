package com.lwz.biz.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lwz.biz.RightManageBiz;
import com.lwz.dao.JobRightDao;
import com.lwz.dao.RightDao;
import com.lwz.entity.JobRight;
import com.lwz.entity.Right;

@Service
public class RightManageBizImpl implements RightManageBiz {
	
	@Resource
	private RightDao rightDao;
	@Resource
	private JobRightDao jobRightDao;
	
	/* (non-Javadoc)
	 * @see com.lwz.biz.impl.RightManageBiz#queryAllRights()
	 */
	public List<Right> queryAllRights(){
		return rightDao.queryAllRights();
	}
	
	/* (non-Javadoc)
	 * @see com.lwz.biz.impl.RightManageBiz#queryAllBind()
	 */
	public List<JobRight> queryAllBind(){
		return jobRightDao.queryAllBind();
	}
	
	/* (non-Javadoc)
	 * @see com.lwz.biz.impl.RightManageBiz#updateBind(com.lwz.entity.JobRight)
	 */
	public void updateBind(JobRight jobRight){
		jobRightDao.updateByPrimaryKeySelective(jobRight);
	}
	
	/* (non-Javadoc)
	 * @see com.lwz.biz.impl.RightManageBiz#deleteBind(com.lwz.entity.JobRight)
	 */
	public void deleteBind(JobRight jobRight){
		jobRightDao.deleteByPrimaryKey(jobRight.getId());
	}
	
	/* (non-Javadoc)
	 * @see com.lwz.biz.impl.RightManageBiz#insertBind(com.lwz.entity.JobRight)
	 */
	public void insertBind(JobRight jobRight){
		jobRightDao.insertSelective(jobRight);
	}
	/* (non-Javadoc)
	 * @see com.lwz.biz.impl.RightManageBiz#insertRight(com.lwz.entity.Right)
	 */
	public String insertRight(Right right){
		if(rightDao.insertSelective(right)==1){
			return "1";
		}
		return "0";
	}
}
