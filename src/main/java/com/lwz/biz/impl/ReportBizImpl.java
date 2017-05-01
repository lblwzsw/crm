package com.lwz.biz.impl;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.output.ByteArrayOutputStream;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFEvaluationWorkbook;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lwz.dao.ConsultRecordDao;
import com.lwz.dao.CustomDao;
import com.lwz.dao.CustomInfoDao;
import com.lwz.dao.EmployeeDao;
import com.lwz.entity.Custom;
import com.lwz.util.ExcelUtils;

@Service
public class ReportBizImpl {

	@Resource
	private EmployeeDao employeeDao;
	@Resource
	private ConsultRecordDao consultRecordDao;
	@Resource
	private CustomInfoDao customInfoDao;
	@Resource
	private CustomDao customDao;
	
	public List<Map<String,Object>> allEmployees(){
		return employeeDao.selectAllEmp();
	}
	
	public List<Map<String,Object>> countInfoForDepart(Integer departmentId){
		if(departmentId==4){//线下咨询部
			return consultRecordDao.queryAllCountCurrentMonth();
		}else{
			return customInfoDao.queryAllCountCurrentMonth(departmentId);
		}
	}
	public ResponseEntity<byte[]> exportCustom(Integer type) throws IOException{
		List<Custom> list = customDao.queryAllCustomNoPage(type);
		HSSFWorkbook workbook = new HSSFWorkbook();
	    //获取参数个数作为excel列数
	    int columeCount = 9;

	    HSSFSheet sheet = workbook.createSheet("客户报表");
	    //创建第一栏
	    HSSFRow headRow = sheet.createRow(0);
	    String[] titleArr = {"id","name","education","phone_no","qq","email","custom_statu","create_date","invite_name"};
	    for(int m=0;m<=columeCount-1;m++)
	    {
	        HSSFCell cell = headRow.createCell(m);
	        cell.setCellType(HSSFCell.CELL_TYPE_STRING);
	        sheet.setColumnWidth(m, 6000);
	        HSSFCellStyle style = workbook.createCellStyle();
	        HSSFFont font = workbook.createFont();
	        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	        style.setFont(font);
	        //填写数据
	        cell.setCellStyle(style);
	        cell.setCellValue(titleArr[m]);
	    }
	    int index = 0;
	    //写入数据
	    for(Custom entity : list)
	    {
	        //logger.info("写入一行");
	        HSSFRow row = sheet.createRow(index+1);
	        for(int n=0;n<=columeCount-1;n++)
	            row.createCell(n);
	        
	        String education = entity.getEducation();
	        if("1".equals(education)){
	        	education = "本科";
	        }else if("2".equals(education)){
	        	education = "高中";
	        }else if("3".equals(education)){
	        	education = "专科";
	        }else{
	        	education = "硕士";
	        }
	        String customStatu = entity.getCustomStatu();
	        if("0".equals(customStatu)){
	        	customStatu = "新增未上门";
	        }else if("1".equals(customStatu)){
	        	customStatu = "新增已上门";
	        }else if("2".equals(customStatu)){
	        	customStatu = "销售跟进中";
	        }else if("3".equals(customStatu)){
	        	customStatu = "咨询跟进中";
	        }else if("4".equals(customStatu)){
	        	customStatu = "死单";
	        }else {
	        	customStatu = "已报名";
	        }
	        row.getCell(0).setCellValue(entity.getId());
	        row.getCell(1).setCellValue(entity.getName());
	        row.getCell(2).setCellValue(education);
	        row.getCell(3).setCellValue(entity.getPhoneNo());
	        row.getCell(4).setCellValue(entity.getQq()==null?"0":String.valueOf(entity.getQq()));
	        row.getCell(5).setCellValue(entity.getEmail());
	        row.getCell(6).setCellValue(customStatu);
	        row.getCell(7).setCellValue(new SimpleDateFormat("yyyy-MM-dd").format(entity.getCreateDate()));
	        row.getCell(8).setCellValue(entity.getInviteName());
	        index++;
	    }
	    HttpHeaders headers = new HttpHeaders();
	    headers.add("Content-Disposition", "attchement;filename=custom_info_"+new SimpleDateFormat("yyyy.MM.dd HH:mm:ss").format(new Date())+".xls");
	    ByteArrayOutputStream os = new ByteArrayOutputStream();
	    workbook.write(os);
	    return new ResponseEntity<byte[]>(os.toByteArray(), headers, HttpStatus.OK);
	    
	}
	public void exportCustomInfo(Integer type, Integer followManId , HttpServletResponse response){
		List<Map<String, Object>> customInfo = customInfoDao.customInfo(type, followManId);
		ExcelUtils.export(response,"table","test",customInfo);
	}
}
