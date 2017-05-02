package com.lwz.biz.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lwz.biz.LoginBiz;
import com.lwz.dao.EmployeeDao;
import com.lwz.dao.JobRightDao;
import com.lwz.dao.RightDao;
import com.lwz.entity.Employee;
import com.lwz.entity.Right;

@Service
public class LoginBizImpl implements LoginBiz {

	@Resource
	private EmployeeDao employeeDao;
	@Resource
	private JobRightDao jobRightDao;
	@Resource
	private RightDao rightDao;
	
	
	/* (non-Javadoc)
	 * @see com.lwz.biz.impl.LoginBiz#checkLogin(java.lang.String, java.lang.String)
	 */
	public Employee checkLogin(String username, String pass){
		Employee e = employeeDao.selectByUsername(username, pass);
		if(e!=null&&0!=e.getId()){
			return e;
		}else{
			return null;
		}
	}
	
	/* (non-Javadoc)
	 * @see com.lwz.biz.impl.LoginBiz#getRights(com.lwz.entity.Employee)
	 */
	public List<Right> getRights(Employee user){
		List<Integer> rIds = jobRightDao.selectRIdByJId(user.getJobinfoId());
		List<Right> rights = rightDao.selectByRIds(rIds);
		
		return rights;
	}

	public String changePass(Integer id, String pass, String newPass) {
		Employee user = new Employee();
		user.setId(id);
		user.setPass(newPass);
		if(employeeDao.checkPass(id, pass)==0){
			return "0";
		}else if(employeeDao.updateByPrimaryKeySelective(user)==1){
			return "1";
		}else{
			return "-1";
		}
	}
}
