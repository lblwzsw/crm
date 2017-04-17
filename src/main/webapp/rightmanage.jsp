<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
		<span style="margin-left: 30px"><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-lock" plain="false" onclick="javascript:queryRirhts()" style="height: 32px">&nbsp;绑定权限&nbsp;</a></span>
	</div>

	<script type="text/javascript">
	
	$(function(){
		$('#rt-dg').edatagrid({
			saveUrl: 'saveRight.do',
		    updateUrl: 'updateRight.do',
		    destroyUrl: 'deleteRight.do'
		});
	});
	
	
	function queryRirhts() {
		$.post("queryAllRights.do",function(data) {
			$("#rt-dg").edatagrid({data:data});
			$("#rt-dg").edatagrid({onLoadSuccess:function(){
				$('#rt-query').panel('open');
			}});
			
		})}
	
	
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
			if(row.rid==1){
				return '一级权限'
			}else{
				return '二级权限'
			}
		}
	</script>

	<div id="rt-dlg" class="easyui-dialog" style="width:400px" closed="true" buttons="#rt-dlg-buttons" closable="false">

		<form id="rt-ff" method="post">

			<div>
				<p>

					<label for="rightName" class="label-top">权限名称:</label> <input class="easyui-validatebox tb"
						data-options="missingMessage:'请输入权限名称.长度为3-30',tipPosition:'bottom',required:true,validateOnCreate:false,validateOnBlur:true,validType:'length[3,30]'" id="rightName" name="rightName"
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
    </div>
	<table id="rt-dg" style="width:600px;height:600px;" 
			title="查询结果"
			singleSelect="true"
			toolbar="#rt-toolbar"
			autoSave="false"
			idField="rid"
			fitColumns="true">
		<thead>
			<tr>
				<th field="rid" width="100" align="center">权限编号</th>
				<th field="rightName" width="150"  align="center" editor="type:'validatebox',options:{required:true}">权限名称</th>
				<th field="rightType" width="100" align="center" 
				formatter="format"   editor="{type:'combobox',options:{data:[{'rightType':'1','text':'一级权限'},{'rightType':'2','text':'二级权限'}],valueField:'rightType',textField:'text'}}">权限等级</th>
				<th field="url" width="100"  align="center" editor="type:'validatebox',options:{required:true}" >url</th>
				<th field="pid" width="100" align="center" editor="{type:'numberbox',options:{precision:0}}">所属权限</th>
			</tr>
		</thead>
	</table>
	</div>
	</div>




</body>

