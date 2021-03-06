package com.lwz.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.junit.Test;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lwz.biz.CustomDateBiz;
import com.lwz.entity.ConsultRecord;
import com.lwz.entity.Custom;
import com.lwz.entity.Department;

@Controller
public class CustomDateController {
	
	private ObjectMapper oMapper = new ObjectMapper();
	
	@Resource
	private CustomDateBiz customdateBiz;
	
	@RequestMapping(value="insertCustom")
	public @ResponseBody String insertCustom(Custom custom){
		custom.setCreateDate(new Date());
		if(customdateBiz.insertCustom(custom) == 1){
			return "1";
		}
		return "0";
	}
	@RequestMapping(value="queryCustom", produces="application/json;charset=utf-8")
	public @ResponseBody String queryCustom(Integer page, Integer rows, Custom custom){
		Map<String, Object> map = customdateBiz.queryCustom(page, rows, custom);
		String json = "";
		try {
			json = oMapper.writeValueAsString(map);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return json;
	}
	@RequestMapping(value="queryConsulters", produces="application/json;charset=utf-8")
	public @ResponseBody String queryConsulters(){
		List<Map<String, Object>> list = customdateBiz.queryAllConsulters();
		String json = "";
		try {
			json = oMapper.writeValueAsString(list);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return json;
	}
	@Transactional
	@RequestMapping(value="allotToConsult")
	public @ResponseBody String allotToConsult(ConsultRecord consultRecord){
		consultRecord.setConsultDate(new Date());
		Custom custom = new Custom();
		custom.setId(consultRecord.getcId());
		custom.setCustomStatu("3");
		customdateBiz.changeCustomStatu(custom);
		if(customdateBiz.allotToConsult(consultRecord)==1){
			return "1";
		}
		return "0";
	}
	@RequestMapping(value="updateCustom")
	public @ResponseBody String updateCustom(Custom custom){
		custom.setCreateDate(null);
		if(customdateBiz.updateCustom(custom)==1){
			return "1";
		}
		return "0";
	}
	@RequestMapping(value="allotCustom")
	public @ResponseBody String allotCustom(){
		if(customdateBiz.allotCustom()==1){
			return "1";
		}
		return "0";
	}
	@Test
	@RequestMapping(value="batchImportCustom")
	public @ResponseBody String batchImportCustom(MultipartFile file) throws IOException, ParseException{
		//MultipartFile file
		POIFSFileSystem fs = new POIFSFileSystem(file.getInputStream());
		HSSFWorkbook wb = new HSSFWorkbook(fs);  
		HSSFSheet sheet = wb.getSheet("Sheet1"); 
		List<Custom> list = new LinkedList<Custom>();
		int nameCol=-1,educationCol=-1,phoneNoCol=-1,qqCol=-1,emailCol=-1,customStatuCol=-1,createDateCol=-1,inviteNameCol=-1;
		int firstRow=-1;
		Iterator<Row> rowiterator = sheet.iterator();
		row:while(rowiterator.hasNext()){
			Row row = rowiterator.next();
			Iterator<Cell> cellIterator = row.iterator();
			while(cellIterator.hasNext()){
				Cell cell = cellIterator.next();
				if(Cell.CELL_TYPE_STRING == cell.getCellType()){
					String value = cell.getStringCellValue().trim();
					if("name".equals(value)){
						nameCol = cell.getColumnIndex();
					}else if("education".equals(value)){
						educationCol = cell.getColumnIndex();
					}else if("phoneNo".equals(value)){
						phoneNoCol = cell.getColumnIndex();
					}else if("qq".equals(value)){
						qqCol = cell.getColumnIndex();
					}else if("email".equals(value)){
						emailCol = cell.getColumnIndex();
					}else if("customStatu".equals(value)){
						customStatuCol = cell.getColumnIndex();
					}else if("createDate".equals(value)){
						createDateCol = cell.getColumnIndex();
					}else if("inviteName".equals(value)){
						inviteNameCol = cell.getColumnIndex();
					}else if("id".equals(value)){
					}else{
						continue row;
					}
				}
			}
			firstRow = row.getRowNum()+1;break;
		}
		int rowNums = sheet.getLastRowNum();
		
		for(int i=firstRow; i<=rowNums; i++){
			HSSFRow row = sheet.getRow(i);
			Custom custom = new Custom();
			custom.setName(row.getCell(nameCol).getStringCellValue());
			
			String education = row.getCell(educationCol).getStringCellValue().trim();
			if("本科".equals(education)){
				custom.setEducation("1");
			}else if("专科".equals(education)){
				custom.setEducation("2");
			}else if("高中".equals(education)){
				custom.setEducation("3");
			}else if("硕士".equals(education)){
				custom.setEducation("4");
			}
			
			double phoneNo = row.getCell(phoneNoCol).getNumericCellValue();   
			custom.setPhoneNo(new DecimalFormat("#").format(phoneNo));
			
			double qq = row.getCell(qqCol).getNumericCellValue(); 
			String qqStr = new DecimalFormat("#").format(qq);
			if(qqStr.matches("^[1-9][0-9]+$")){
				custom.setQq(Integer.valueOf(qqStr));
			}
			
			custom.setEmail(row.getCell(emailCol).getStringCellValue());
			
			double customStatu = row.getCell(customStatuCol).getNumericCellValue();   
			custom.setCustomStatu(new DecimalFormat("#").format(customStatu));
			
			custom.setCreateDate(new SimpleDateFormat("yyyy-MM-dd").parse(row.getCell(createDateCol).getStringCellValue()));
			custom.setInviteName(row.getCell(inviteNameCol).getStringCellValue());
			list.add(custom);
		}
		return customdateBiz.batchImportCustom(list);
		
	}
}
