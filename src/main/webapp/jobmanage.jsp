<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>





<body>
	<h1>职位管理</h1>
	<div id="jobToolbar" style="margin: 0 auto">
		<span style="font-size: 18;font-weight: bold;margin-left: 20px">功能导航：</span><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="false" onclick="javascript:$('#job-dlg').dialog('open').dialog('center').dialog('setTitle','新增职位');" style="height: 32px">&nbsp;新增职位&nbsp;</a> 
		<span style="margin-left: 30px"><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="false" onclick="queryJobs()" style="height: 32px">&nbsp;查询职位&nbsp;</a></span>
	</div>

	<div id="job-dlg" class="easyui-dialog" style="width:400px" closed="true" buttons="#job-dlg-buttons" closable="false" closable="true" modal="false">

		<form id="job-ff" method="post">

			<div>
				<p>

					<label for="job" class="label-top">职位名称:</label> <input class="easyui-validatebox tb"
						data-options="missingMessage:'请输入权限名称.长度为3-30',tipPosition:'bottom',required:true,validateOnCreate:false,validateOnBlur:true,validType:'length[3,30]'" id="job" name="job"
						style="width: 270px" />
				</p>
			</div>

			<div>
				<p>
					<label for="departmentId" class="label-top">所属权限：</label><select id="departmentId" class="easyui-combobox" name="departmentId" style="width:100px;" data-options="editable:false">
						<option value="1" selected="selected">技术部</option>
						<option value="2">销售部</option>
						<option value="3">线上咨询部</option>
						<option value="4">线下咨询部</option>
						<option value="5">销售支持部</option>
					</select>
				</p>
			</div>
		</form>
	</div>
	<div id="job-dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveJob()" style="width:90px">提交</a> <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
			onclick="closeDlg()" style="width:90px">取消</a>
	</div>
	
	
	<div style="margin: 50px auto;width: 310px">
	<div id="job-query" class="easyui-panel" closed="true" closable="true" noheader="true" >
		
		<div id="job-toolbar">
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="javascript:$('#job-dg').edatagrid('saveRow')">保存修改</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="javascript:$('#job-dg').edatagrid('cancelRow')">退出编辑</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="javascript:$('#job-dg').edatagrid('destroyRow')">删除</a>
         <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" plain="true" onclick="javascript:$('#job-query').panel('close')">退出</a>
    </div>
	
	
	
	
	<table id="job-dg" " 
			title="查询结果"
			singleSelect="true"
			toolbar="#job-toolbar"
			autoSave="false"
			idField="id">
		<thead>
			<tr>
				<th field="id" width="100" align="center">职位编号</th>
				<th field="job" width="100"  align="center" editor="type:'validatebox',options:{required:true}">职位名称</th>
				<th field="departmentId" width="100" align="center" 
				formatter="format"   editor="{type:'combobox',options:{data:[{'departmentId':'1','text':'技术部'},
				{'departmentId':'2','text':'销售部'},
				{'departmentId':'3','text':'线上咨询部'},
				{'departmentId':'4','text':'线下咨询部'},{'departmentId':'5','text':'销售支持部'}],valueField:'departmentId',textField:'text'}}">所属部门</th>
				
			</tr>
		</thead>
	</table>
	
	</div>
	</div>
	
	
	
	
	
	
	
	
	

<script type="text/javascript">
$(function(){
	$('#job-dg').edatagrid({
		saveUrl: 'insertJob.do',
	    updateUrl: 'updateJob.do',
	    destroyUrl: 'deleteJob.do'
	});
});





function saveJob(){
	$('#job-ff').form(
			'submit',
			{
				url : 'insertJob.do',
				success : function(data) {
					if (data == 1) {
						$.messager.alert('OK', "权限添加成功!", 'info');
						$('#job-ff').form("clear");
						$('#job-dlg').dialog('close');
						$('#job-dg').datagrid('reload');
					} else {
						$.messager.alert('Sorry',
								'Failed to save data!', 'error');
					}
				}
			});
}


function closeDlg() {
	//清空表单
	$('#job-ff').form("clear");
	//重置验证
	$('#job').validatebox('resetValidation');
	//关闭对话框
	$('#job-dlg').dialog('close');
}



function format(value,row){
	if (row.id==1){
		return '技术部';
	}else if(row.id==2){
		return '销售部';
	}else if(row.id==3){
		return '线上咨询部';
	}else if(row.id==4){
		return '线下咨询部';
	}else{
		return '销售支持部';
	}
	
	
}

function queryJobs() {
	
	$.post("queryAllJobs.do",function(data) {
		$("#job-dg").edatagrid({data:data})
		
		$("#job-dg").edatagrid({onLoadSuccess:function(){
			$('#job-query').panel('open');
		}});
		
	})}



</script>

</body>


