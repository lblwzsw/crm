<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">


  
  <body>
    <h1 style="text-align: center">报表管理</h1>
    
    
    <c:if test="${user.jobInfoId!=1 }">
    <div style="margin: 20px 20px;width: 400px">
		<span style="font-size: 18;font-weight: bold;">请选择报表类型：</span> <select 
			class="easyui-combobox" id="outType" style="width:120px;height: 32px" editable="false" panelHeight="auto">
			<option value="1" selected="selected">本周客户数据</option>
			<option value="2">本月客户数据</option>
		</select>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-large-smartart" plain="false"
				onclick="downloadCustom()" style="height: 32px;margin-left: 10px" size="large">导出 </a>
	</div>
    </c:if>	
    
    <c:if test="${user.jobInfoId==1 }">
    <div style="margin: 20px 20px;width: 600px">
    <span style="font-size: 18;font-weight: bold;">功能导航:</span>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-man" plain="false"
				onclick="queryAllEmps()" style="height: 32px;margin-left: 10px;margin-right: 10px" size="large">员工信息</a>
		请选择部门：<select  
			class="easyui-combobox" id="deptId" style="width:120px;height: 32px" editable="false" panelHeight="auto">
			<option value="2" selected="selected">销售部</option>
			<option value="3">线上咨询部</option>
			<option value="4">线下咨询部</option>
		</select>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="false"
				onclick="showCuntForDepart()" style="height: 32px;margin-left: 10px" size="large">查看部门本月统计</a>
	</div>
    </c:if>
    
    
    
    
    <div id="all-dlg" class="easyui-dialog" closed="true" modal="false" border="false" shadow="false"
		noheader='true'>
    <table id="all-dg" title="员工信息表" style="width:802px;height:600px;" 
			data-options="singleSelect:true,collapsible:false,method:'post'" closable='true'>
			<thead>
				<tr>
					<th data-options="field:'id',width:100,align:'center'">员工工号</th>
					<th data-options="field:'realname',width:100,align:'center'">姓名</th>
					<th data-options="field:'nickname',width:100,align:'center'">员工昵称</th>
					<th data-options="field:'dname',width:100,align:'center'">所在部门</th>
					<th data-options="field:'job',width:100,align:'center'">职位</th>
					<th data-options="field:'phoneNo',width:150,align:'center'">手机</th>
					<th data-options="field:'officeTel',width:150,align:'center'">办公电话</th>
				</tr>
			</thead>
		</table>
    </div>
    
    
    <div id="sales-dlg" class="easyui-dialog" closed="true" modal="false" border="false" shadow="false"
		noheader='true'>
		<table id="sales-dg" style="width:503px;height: 100px" class="easyui-datagrid" closable='true'>
			<thead>
				<tr>
					<th field="visited" width="100" align="center">已上门客户数</th>
					<th field="disConnect" width="100" align="center">未接通客户数</th>
					<th field="denied" width="100" align="center">死单客户数</th>
					<th field="following" width="100" align="center">紧跟客户数</th>
					<th field="total" width="100" align="center">总分配客户数</th>
				</tr>
			</thead>
		</table>
	</div>
	<div id="consulter-dlg" class="easyui-dialog" closed="true" modal="false" border="false" shadow="false"
		noheader='true'>
		<table id="consulter-dg" style="width:503px;height: 100px" class="easyui-datagrid" closable='true'>
			<thead>
				<tr>
					<th field="following" width="100" align="center">紧跟客户数</th>
					<th field="signed" width="100" align="center">已报名客户数</th>
					<th field="denied" width="100" align="center">死单客户数</th>
					<th field="refundment" width="100" align="center">报名后退费客户数</th>
					<th field="total" width="100" align="center">总分配客户数</th>
				</tr>
			</thead>
		</table>
	</div>
    
    
    
    
    
    
    
    
    
    <input type="hidden"  id="jobId" value="${user.jobInfoId }">
    <input type="hidden" id="uid" value="${user.id }">
   
    
    <script type="text/javascript">
    
    function downloadCustom(){
		
		$.messager.confirm('confirm', '确认导出客户数据到excel?', function(r){
			if (r){
				var jobId=$("#jobId").val();
				var id=$("#uid").val();
				var type=$('#outType').combobox('getValue');
				if(jobId=='7'){
					window.location.href="exportCustom.do?type"+type;
				}else if(jobId=='5'||jobId=='8'){
					window.location.href="exportCustomInfo.do?type"+type+"&followManId="+id;
				}else if(jobId=='3'){
					window.location.href="exportConsultRecord.do?type"+type+"&consultManId="+id;
				}
				
			}
		});
		
	}
    
    
    
    
    function queryAllEmps(){
    	
    	$("#all-dg").datagrid({
			url : "allEmployees.do",
			title : "员工信息",
			onLoadSuccess : function(data) {
				$("#all-dlg").dialog('open').dialog('center');
			}
		})
    	
    	
    	
    	
    }
    
    
    function showCuntForDepart(){
    	
    	
    var departId=$("#deptId").combobox('getValue');
    	
    if (departId == "2" | departId == "3") {
		
    	var dname="销售部";
    	if(departId=="3"){
    		dname="线上咨询部";
    	}
    	
    	$("#sales-dg").datagrid({
			url : "countInfoForDepart.do?departmentId="+departId,
			title : dname+"部门本月统计",
			onLoadSuccess : function(data) {
				$("#sales-dlg").dialog('open')
			}
		})

	} else if (departId == "4") {
		$("#consulter-dg").datagrid({
			url : "countConsultForDepart.do?departmentId="+departId,
			title : "线下咨询部门本月统计",
			onLoadSuccess : function(data) {
				$("#consulter-dlg").dialog('open');
			}
		})
	}
    	
    	
    	
    	
    	
    }
    
    
    
    
    
    
    
    
    
    
    
    </script>
    
    
  </body>
