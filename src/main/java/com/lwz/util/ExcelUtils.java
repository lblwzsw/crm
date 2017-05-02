package com.lwz.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;

import jxl.Cell;
import jxl.Sheet;
import jxl.SheetSettings;
import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.format.VerticalAlignment;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

public class ExcelUtils {

	@SuppressWarnings({ "unchecked" })
	/**
	 * @author RangoLan
	 * @param filePath 解析文件路径
	 * @param className 解析成对象的类
	 * @return List<E> excel对应类对象的集合
	 */
	public static <E> List<E> readExcel(String filePath, String className) {

		// 创建一个list 用来存储读取的内容
		List<E> list = new ArrayList<E>();
		Workbook rwb = null;
		Cell cell = null;
		InputStream stream = null;
		Class<?> cl = null;
		try {
			// 创建输入流,filePath读取文件位置
			stream = new FileInputStream(filePath);
			// 获取Excel文件对象
			rwb = Workbook.getWorkbook(stream);
			// 获取文件的指定工作表 默认的第一个
			Sheet sheet = rwb.getSheet(0);

			// 获取excel表格映射类的class对象
			cl = Class.forName(className);
			// 获取该类的所有声明的属性组
			Field[] fields = cl.getDeclaredFields();
			// 行数(表头的目录不需要，从1开始) 要求excel的表头必须在第一行，数据从第二行开始
			for (int i = 1; i < sheet.getRows(); i++) {

				// 获取excel对应类的一个对象，要求该类必须有默认构造方法
				Object object = cl.newInstance();
				// 列数
				for (int j = 1; j < sheet.getColumns(); j++) {

					// 获取第i行，第j列的值
					cell = sheet.getCell(j, i);
					// 爆破private的属性，使其可访问
					fields[j].setAccessible(true);

					// 获得属性的类型class对象
					Class<?> type = fields[j].getType();

					// 获取单元格内容
					String content = cell.getContents();

					// 判断属性类型并赋值 暂时根据项目需要 类型为Integer java.sql.Date String
					// 可根据项目需要增加条件 为属性赋值
					if (type.getSimpleName().equals("Integer")) {

						if (content != null && content != "") {
							fields[j].set(object, Integer.valueOf(cell.getContents()));
						} else {
							fields[j].set(object, null);
						}
					} else if (type.getName().equals("java.sql.Date")) {
						if (content != null && content != "") {
							// 日期格式化处理
							fields[j].set(object, new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(content).getTime()));
						} else {
							fields[j].set(object, null);
						}
					} else {
						fields[j].set(object, content);
					}

				}
				// 把刚获取的列存入list
				list.add((E) object);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stream != null)
					stream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		return list;
	}

	/**
	 * @author RangoLan
	 * @param objData
	 *            导出内容数据库表对应类对象集合
	 * @param sheetName
	 *            导出工作表的名称
	 * @param columns
	 *            导出Excel的表头数组 必须和类的属性声明顺序一致
	 * @param filename
	 *            生成的excel文件名
	 * @param ignoreIndex
	 *            生成的excel忽略类的属性索引集合
	 * @return
	 */
	public static void exportToExcel(HttpServletResponse response, List<?> objData, 
			List<Integer> ignoreIndex, String sheetName, String[] columns,
			String filename, List<Map<String,Object>> mapData) {

		// 声明工作簿jxl.write.WritableWorkbook
		WritableWorkbook wwb;

		try {
			// 设置响应类型
			response.setContentType("application/vnd.ms-excel");
			// 设置输出的文件名 避免重名 加时间戳
			response.setHeader("Content-Disposition", "attachment;filename=" + new String(filename.getBytes("utf-8"), "ISO8859-1")
					+ new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + ".xls");
			// 根据传进来的file对象创建可写入的Excel工作薄
			OutputStream os = response.getOutputStream();

			wwb = Workbook.createWorkbook(os);

			/*
			 * 创建一个工作表、sheetName为工作表的名称、"0"为第一个工作表
			 * 打开Excel的时候会看到左下角默认有3个sheet、"sheet1、sheet2、sheet3"这样
			 * 代码中的"0"就是sheet1、其它的一一对应。 createSheet(sheetName,
			 * 0)一个是工作表的名称，另一个是工作表在工作薄中的位置
			 */
			WritableSheet ws = wwb.createSheet(sheetName, 0);

			SheetSettings ss = ws.getSettings();
			ss.setVerticalFreeze(1);// 冻结表头
			ss.setDefaultColumnWidth(20);// 设置默认列宽度
			// 设置样式，字体
			WritableFont font1 = new WritableFont(WritableFont.createFont("微软雅黑"), 10, WritableFont.BOLD);
			WritableFont font2 = new WritableFont(WritableFont.createFont("微软雅黑"), 9, WritableFont.NO_BOLD);
			WritableCellFormat wcf = new WritableCellFormat(font1);
			WritableCellFormat wcf2 = new WritableCellFormat(font2);
			WritableCellFormat wcf3 = new WritableCellFormat(font2);

			
			
			// 用于表头样式
			wcf.setBackground(jxl.format.Colour.AQUA); // 背景颜色
			wcf.setAlignment(Alignment.CENTRE); // 水平居中
			wcf.setVerticalAlignment(VerticalAlignment.CENTRE); // 垂直居中
			wcf.setBorder(Border.ALL, BorderLineStyle.MEDIUM);// 设置边框 Border静态字段 设置边框样式BorderLineStyle 静态字段

			// 奇数行样式
			wcf2.setBackground(Colour.GRAY_25);
			wcf2.setAlignment(Alignment.CENTRE);
			wcf2.setVerticalAlignment(VerticalAlignment.CENTRE);
			wcf2.setBorder(Border.ALL, BorderLineStyle.MEDIUM);
			// 偶数行样式
			wcf3.setBackground(Colour.LIGHT_ORANGE);
			wcf3.setAlignment(Alignment.CENTRE);
			wcf3.setVerticalAlignment(VerticalAlignment.CENTRE);
			wcf3.setBorder(Border.ALL, BorderLineStyle.MEDIUM);

			
			

			// 判断一下表头数组是否有数据
			if (columns != null && columns.length > 0) {
				// 循环写入表头
				for (int i = 0; i < columns.length; i++) {

					/*
					 * 添加单元格(Cell)内容addCell() 添加Label对象Label()
					 * 数据的类型有很多种、在这里你需要什么类型就导入什么类型 如：jxl.write.DateTime
					 * 、jxl.write.Number、jxl.write.Label Label(i, 0, columns[i],
					 * wcf) 其中i为列、0为行、columns[i]为数据、wcf为样式
					 * 合起来就是说将columns[i]添加到第一行(行、列下标都是从0开始)第i列、样式为什么"色"内容居中
					 */
					ws.addCell(new Label(i, 0, columns[i], wcf));
				}

				// 判断表中是否有数据
				if (objData != null && objData.size() > 0) {

					// 获得传入List中类的属性数组
					Field[] fields = objData.get(0).getClass().getDeclaredFields();

					if (ignoreIndex != null && ignoreIndex.size() > 0) {
						// 循环写入表中数据
						for (int i = 0; i < objData.size(); i++) {

							// 用于控制表格样式
							WritableCellFormat f = wcf2;

							if (i % 2 == 0) {
								f = wcf3;
							}
							int j = 0;// 标记属性索引
							int count = 0;// 忽略次数标记
							for (Field field : fields) {
								// 判断是否忽略该属性标记
								boolean ignore = false;

								for (Integer index : ignoreIndex) {

									if (j == index) {
										count++;
										ignore = true;
										break;
									}

								}

								// 不忽略时 填充到单元格
								if (!ignore) {
									// 爆破private限制
									field.setAccessible(true);

									// field.get(objData.get(i)获取该类对象的对应的属性值
									// f为单元格样式

									Object obj = field.get(objData.get(i));
									Object s = obj == null ? "" : obj;

									ws.addCell(new Label(j - count, i + 1, String.valueOf(s), f));

								}

								j++;

							}
						}
					} else {

						// 循环写入表中数据
						for (int i = 0; i < objData.size(); i++) {

							// 用于控制表格样式
							WritableCellFormat f = wcf2;

							if (i % 2 == 0) {
								f = wcf3;
							}
							int j = 0;
							for (Field field : fields) {

								// 爆破private限制
								field.setAccessible(true);

								// field.get(objData.get(i)获取该类对象的对应的属性值 f为单元格样式
								Object obj = field.get(objData.get(i));
								Object s = obj == null ? "" : obj;// 判断是否为null
								ws.addCell(new Label(j, i + 1, String.valueOf(s), f));
								j++;

							}
						}

					}
				}

				// 写入Exel工作表
				wwb.write();

				// 关闭Excel工作薄对象
				wwb.close();

				// 关闭流
				os.flush();
				os.close();
				//置空便于GC
				os = null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 

	}
	public static void export(HttpServletResponse response, String sheetName, String filename, List<Map<String,Object>> mapData){
		WritableWorkbook wwb;

		try {
			// 设置响应类型
			response.setContentType("application/vnd.ms-excel");
			// 设置输出的文件名 避免重名 加时间戳
			response.setHeader("Content-Disposition", "attachment;filename=" + new String(filename.getBytes("utf-8"), "ISO8859-1")
					+ new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + ".xls");
			// 根据传进来的file对象创建可写入的Excel工作薄
			OutputStream os = response.getOutputStream();

			wwb = Workbook.createWorkbook(os);

			/*
			 * 创建一个工作表、sheetName为工作表的名称、"0"为第一个工作表	
			 * 打开Excel的时候会看到左下角默认有3个sheet、"sheet1、sheet2、sheet3"这样
			 * 代码中的"0"就是sheet1、其它的一一对应。 createSheet(sheetName,
			 * 0)一个是工作表的名称，另一个是工作表在工作薄中的位置
			 */
			WritableSheet ws = wwb.createSheet(sheetName, 0);

			SheetSettings ss = ws.getSettings();
			ss.setVerticalFreeze(1);// 冻结表头
			ss.setDefaultColumnWidth(20);// 设置默认列宽度
			// 设置样式，字体
			WritableFont font1 = new WritableFont(WritableFont.createFont("微软雅黑"), 10, WritableFont.BOLD);
			WritableFont font2 = new WritableFont(WritableFont.createFont("微软雅黑"), 9, WritableFont.NO_BOLD);
			WritableCellFormat wcf = new WritableCellFormat(font1);
			WritableCellFormat wcf2 = new WritableCellFormat(font2);
			WritableCellFormat wcf3 = new WritableCellFormat(font2);

			
			
			// 用于表头样式
			wcf.setBackground(jxl.format.Colour.AQUA); // 背景颜色
			wcf.setAlignment(Alignment.CENTRE); // 水平居中
			wcf.setVerticalAlignment(VerticalAlignment.CENTRE); // 垂直居中
			wcf.setBorder(Border.ALL, BorderLineStyle.MEDIUM);// 设置边框 Border静态字段 设置边框样式BorderLineStyle 静态字段

			// 奇数行样式
			wcf2.setBackground(Colour.GRAY_25);
			wcf2.setAlignment(Alignment.CENTRE);
			wcf2.setVerticalAlignment(VerticalAlignment.CENTRE);
			wcf2.setBorder(Border.ALL, BorderLineStyle.MEDIUM);
			// 偶数行样式
			wcf3.setBackground(Colour.LIGHT_ORANGE);
			wcf3.setAlignment(Alignment.CENTRE);
			wcf3.setVerticalAlignment(VerticalAlignment.CENTRE);
			wcf3.setBorder(Border.ALL, BorderLineStyle.MEDIUM);

			
			
			
			// 判断一下表头数组是否有数据
			if (mapData != null && mapData.size()>0) {
				// 循环写入表头
				Set<String> keySet = mapData.get(0).keySet();
				int i = 0;
				for (String string : keySet) {
					/*
					 * 添加单元格(Cell)内容addCell() 添加Label对象Label()
					 * 数据的类型有很多种、在这里你需要什么类型就导入什么类型 如：jxl.write.DateTime
					 * 、jxl.write.Number、jxl.write.Label Label(i, 0, columns[i],
					 * wcf) 其中i为列、0为行、columns[i]为数据、wcf为样式
					 * 合起来就是说将columns[i]添加到第一行(行、列下标都是从0开始)第i列、样式为什么"色"内容居中
					 */
					ws.addCell(new Label(i, 0, string, wcf));
					i++;
				}

				// 判断表中是否有数据
				if (mapData.size() > 0) {

						// 循环写入表中数据
						for (i = 0; i < mapData.size(); i++) {

							// 用于控制表格样式
							WritableCellFormat f = wcf2;

							if (i % 2 == 0) {
								f = wcf3;
							}
							int j = 0;
							for (Entry<String, Object> entry : mapData.get(i).entrySet()) {
								Object s = entry.getValue() == null ? "" : entry.getValue();// 判断是否为null
								ws.addCell(new Label(j, i + 1, String.valueOf(s), f));
								j++;
							}
						}
				}

				// 写入Exel工作表
				wwb.write();

				// 关闭Excel工作薄对象
				wwb.close();

				// 关闭流
				os.flush();
				os.close();
				//置空便于GC
				os = null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}

}
