<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>



<body>
	<h1>权限管理</h1>

	<div id="rightToolbar" style="margin: 0 auto">
		<span style="font-size: 18;font-weight: bold;margin-left: 20px">功能导航：</span><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="false" onclick="javascript:$('#rt-dlg').dialog('open').dialog('center').dialog('setTitle','新增权限');" style="height: 32px">&nbsp;新增权限&nbsp; </a> 
		<span style="margin-left: 30px"><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="false" onclick="javascript:queryRirhts()" style="height: 32px">&nbsp;查询权限&nbsp;</a></span>
		<span style="margin-left: 30px"><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-lock" plain="false" onclick="javascript:queryBind()" style="height: 32px">&nbsp;绑定权限&nbsp;</a></span>
	</div>

	<script type="text/javascript">
	
	$(function(){
		$('#rt-dg').edatagrid({
		    updateUrl: 'updateRight.do',
		    destroyUrl: 'deleteRight.do'
		});
		$('#bind-dg').edatagrid({
		    updateUrl: 'updateBind.do',
		    destroyUrl: 'deleteBind.do'
		});
	});
	
	
	function queryRirhts() {
		$.post("queryAllRights.do",function(data) {
			$("#rt-dg").edatagrid({data:data});
			$("#rt-dg").edatagrid({onLoadSuccess:function(){
				$('#rt-query').panel('open');
			}});
		},"json")}
	
	function queryBind(){
		$.post("queryAllBind.do",function(data) {
			$("#bind-dg").edatagrid({data:data});
			$("#bind-dg").edatagrid({onLoadSuccess:function(){
				$('#bind-query').panel('open');
			}});
		},"json")}
	
		function saveRight() {
			$('#rt-ff').form(
					'submit',
					{
						url : 'insertRight.do',
						success : function(data) {
							if (data == 1) {
								$.messager.alert('OK', "权限添加成功!", 'info');
								$('#rt-ff').form("clear");
								$('#rt-dlg').dialog('close');
								$('#rt-dg').datagrid('reload');
							} else {
								$.messager.alert('Sorry',
										'Failed to save data!', 'error');
							}
						}
					});

		}

		function format(value,row){
			if(row.rType==1){
				return '一级权限'
			}else{
				return '二级权限'
			}
		}
		
		function idFormat(value,row){
			if(value>0){
				return value
			}else{
				return '新增项'
			}
		}
		
		function jIdFormat(value,row){
			if(row.jId==1){
				return '超级管理员'
			}else if(row.jId==2){
				return '管理员'
			}else if(row.jId==3){
				return '咨询师'
			}else if(row.jId==4){
				return '咨询主管'
			}else if(row.jId==5){
				return '网络咨询师'
			}else if(row.jId==6){
				return '网络咨询主管'
			}else if(row.jId==7){
				return '销售助理'
			}else if(row.jId==8){
				return '电话销售'
			}else if(row.jId==9){
				return '电话销售主管'
			}else{
				return '请选择职位'
			}
		}
		
		function rIdFormat(value,row){
			if(row.rId==1){
				return '权限管理'
			}else if(row.rId==2){
				return '账号管理'
			}else if(row.rId==3){
				return '报表管理'
			}else if(row.rId==4){
				return '客户资料'
			}else if(row.rId==5){
				return '客户开发'
			}else if(row.rId==6){
				return '客户咨询'
			}else if(row.rId==7){
				return '部门管理'
			}else if(row.rId==8){
				return '职位管理'
			}else if(row.rId==9){
				return '数据统计'
			}else{
				return '请选择权限'
			}
		}
	</script>

	<div id="rt-dlg" class="easyui-dialog" style="width:400px" closed="true" buttons="#rt-dlg-buttons" closable="false">

		<form id="rt-ff" method="post">

			<div>
				<p>

					<label for="rName" class="label-top">权限名称:</label> <input class="easyui-validatebox tb"
						data-options="missingMessage:'请输入权限名称.长度为3-30',tipPosition:'bottom',required:true,validateOnCreate:false,validateOnBlur:true,validType:'length[3,30]'" id="rName" name="rName"
						style="width: 270px" />
				</p>
			</div>

			<div>
				<p>
					<label for="pid" class="label-top">所属权限：</label><select id="pid" class="easyui-combobox" name="pid" style="width:100px;" data-options="editable:false">
						<option value="1" selected="selected">权限管理</option>
						<option value="2">账号管理</option>
						<option value="3">报表管理</option>
						<option value="4">客户资料</option>
						<option value="5">客户开发</option>
						<option value="6">客户咨询</option>
						<option value="7">部门管理</option>
						<option value="8">职位管理</option>
						<option value="9">统计数据</option>
					</select>
				</p>
			</div>
		</form>
	</div>
	<div id="rt-dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveRight()" style="width:90px">提交</a> <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
			onclick="javascript:$('#rt-ff').form('resetValidation').form('reset');$('#rt-dlg').dialog('close');" style="width:90px">取消</a>
	</div>


	<div style="margin: 50px auto;width: 605px;">
	<div id="rt-query"  class="easyui-panel" closed="true">
		<div id="rt-toolbar">
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="javascript:$('#rt-dg').edatagrid('saveRow')">保存修改</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="javascript:$('#rt-dg').edatagrid('cancelRow')">退出编辑</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="javascript:$('#rt-dg').edatagrid('destroyRow')">删除</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" plain="true" onclick="javascript:$('#rt-query').panel('close')">退出</a>
    </div>
	<table id="rt-dg" style="width:600px;height:600px;" 
			title="查询结果"
			singleSelect="true"
			toolbar="#rt-toolbar"
			autoSave="false"
			idField="id"
			fitColumns="true">
		<thead>
			<tr>
				<th field="id" width="100" align="center">权限编号</th>
				<th field="rName" width="150"  align="center" editor="type:'validatebox',options:{required:true}">权限名称</th>
				<th field="rType" width="100" align="center" 
				formatter="format" editor="{type:'combobox',options:{data:[{'rType':'1','text':'一级权限'},{'rType':'2','text':'二级权限'}],valueField:'rType',textField:'text'}}">权限等级</th>
				<th field="url" width="100"  align="center" editor="type:'validatebox',options:{required:true}" >url</th>
				<th field="pid" width="100" align="center" editor="{type:'numberbox',options:{precision:0}}">所属权限</th>
			</tr>
		</thead>
	</table>
	</div>
	
	</div>
	<div style="margin: 50px auto;width: 605px;">
	<div id="bind-query"  class="easyui-panel" closed="true">
		<div id="bind-toolbar">
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="javascript:$('#bind-dg').edatagrid('saveRow')">保存修改</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="javascript:$('#bind-dg').edatagrid('cancelRow')">退出编辑</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="javascript:$('#bind-dg').edatagrid('appendRow',{id:'',jId:'',rId:''})">添加</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="javascript:$('#bind-dg').edatagrid('destroyRow')">删除</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" plain="true" onclick="javascript:$('#bind-query').panel('close')">退出</a>
    </div>
	<table id="bind-dg" style="width:600px;height:600px;" 
			title="查询结果"
			singleSelect="true"
			toolbar="#bind-toolbar"
			autoSave="false"
			idField="id"
			fitColumns="true">
		<thead>
			<tr>
				<th field="id" width="100" align="center"
				formatter="idFormat"
				>绑定编号</th>
				<th field="jId" width="150"  align="center" 
				formatter="jIdFormat" editor="{type:'combobox',options:{data:[{'jId':'1','text':'超级管理员'},{'jId':'2','text':'管理员'},
				{'jId':'3','text':'咨询师'},{'jId':'4','text':'咨询主管'},{'jId':'5','text':'网络咨询师'},{'jId':'6','text':'网络咨询主管'},
				{'jId':'7','text':'销售助理'},{'jId':'8','text':'电话销售'},{'jId':'9','text':'电话销售主管'}],valueField:'jId',textField:'text'}}">职位名称</th>
				<th field="rId" width="100" align="center" 
				formatter="rIdFormat" editor="{type:'combobox',options:{data:[{'rId':'1','text':'权限管理'},{'rId':'2','text':'账号管理'},
				{'rId':'3','text':'报表管理'},{'rId':'4','text':'客户资料'},{'rId':'5','text':'客户开发'},{'rId':'6','text':'客户咨询'},
				{'rId':'7','text':'部门管理'},{'rId':'8','text':'职位管理'},{'rId':'9','text':'数据统计'}],valueField:'rId',textField:'text'}}">权限名称</th>
			</tr>
		</thead>
	</table>
	</div>
	</div>



</body>

