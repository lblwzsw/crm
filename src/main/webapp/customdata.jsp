<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<body>
	<h1 style="text-align: center">客户管理</h1>
	<c:if test="${user.jobInfoId==5 }">
	<div style="margin: 20px 20px;width: 400px">
		<span style="font-size: 18;font-weight: bold;">添加客户：</span><a href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-add"
			onclick="javascript:$('#cm-dlg').dialog('open').dialog('center').dialog('setTitle','添加权限');"
			style="height: 32px">新增单个客户</a> 
			
	</div>
	</c:if>
	
	<c:if test="${user.jobInfoId==7 }">
	<div style="margin: 20px 20px;width: 400px">
		<span style="font-size: 18;font-weight: bold;">添加客户：</span><a href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-add"
			onclick="javascript:$('#cm-dlg').dialog('open').dialog('center').dialog('setTitle','添加客户');"
			style="height: 32px">新增单个客户</a> <span style="margin-left: 30px">
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-man'"
			style="height: 32px" onclick="javascript:$('#import-dlg').dialog('open')">excel批量导入</a></span>
			
	</div>
	
	<div style="margin-left: 20px;margin-bottom: 40px">
		<div id="navigation" style="margin: 0 auto">
			<span style="font-size: 18;font-weight: bold;">查询类型:</span><select id="qtype" name="qtype"
				style="width:150px;height: 32px;margin-left: 10px" onchange="queryType()">
				<option value="all" selected="selected">查询所有</option>
				<option value="name">按客户姓名查询</option>
				<option value="customStatu">按客户状态查询</option>
				<option value="inviteName">按邀约人姓名</option>
				<option value="phoneNo">按客户手机号码查询</option>
				<option value="createDate">按导入日期查询</option>
			</select> <span style="display: none" id="input"><input class="easyui-textbox"
				data-options="iconCls:'icon-edit',prompt:'请输入查询条件'" style="width:300px;height: 32px;" id="param">
			</span> <span style="display: none" id="date">创建日期：<input class="easyui-datebox"
				data-options="currentText:'今天'" style="width:110px;height: 32px" id="qdate">
			</span> <select id="state" name="state" style="width:150px;height: 32px;display: none">
				<option value="0" selected="selected">新增未上门</option>
				<option value="1">新增已上门</option>
				<option value="2">销售跟进中</option>
				<option value="3">咨询跟进中</option>
				<option value="4">死单</option>
				<option value="5">已报名</option>
			</select> <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="false"
				onclick="queryCustom()" style="height: 32px;margin-left: 10px">&nbsp;搜索 &nbsp;</a>
		</div>
	</div>
	</c:if>
	
	<div id="cm-dlg" class="easyui-dialog" style="width:400px;padding-left: 10px" closed="true"
		buttons="#cm-dlg-buttons" closable="false" closed="true" modal="false">
		<form id="cm-ff" method="post">
			<div>
				<p>
					<label for="name" class="label-top">客户姓名:</label> <input class="easyui-validatebox tb"
						data-options="missingMessage:'请输入客户姓名',tipPosition:'bottom',required:true,validateOnCreate:false,validateOnBlur:true,validType:'length[2,10]'"
						id="name" name="name" style="width: 270px" />
				</p>
			</div>
			<div>
				<p>
					<label for="education" class="label-top">教育水平:</label> <select id="education"
						class="easyui-combobox" panelHeight="auto" name="education" style="width:100px;"
						data-options="editable:false">
						<option value="1" selected="selected">本科</option>
						<option value="2">专科</option>
						<option value="3">高中</option>
						<option value="4">硕士</option>
					</select>
				</p>
			</div>
			<div>
				<p>
					<label for="phoneNo" class="label-top">手机:</label> <input class="easyui-validatebox tb"
						data-options="missingMessage:'请输入客户手机',tipPosition:'bottom',required:true,validateOnCreate:false,validateOnBlur:true,validType:['number']"
						id="phoneNo" name="phoneNo" style="width: 270px;margin-left: 20px" />
				</p>
			</div>
			<div>
				<p>
					<label for="qq" class="label-top">qq:</label><span style="margin-left: 32px"> <input class="easyui-textbox" id="qq" name="qq"
					data-options="missingMessage:'请输入客户qq',tipPosition:'bottom',validateOnCreate:false,validateOnBlur:true,validType:'QQ'"
						style="width: 270px;" /></span>
				</p>
			</div>
			<div>
				<p>
					<label for="email" class="label-top">邮箱:</label> <span style="margin-left: 20px"> <input class="easyui-textbox" id="email"
						name="email" style="width: 270px" /></span>
				</p>
			</div>
			
			<div>
				<p>
					<label for="customStatu" class="label-top">客户状态:</label><select id="customStatu"
						panelHeight="auto" class="easyui-combobox" name="customStatu" style="width:100px;"
						data-options="editable:false">
						<option value="0" selected="selected">新增未上门</option>
						<option value="1">新增已上门</option>
						<option value="2">销售跟进中</option>
						<option value="3">咨询跟进中</option>
						<option value="4">死单</option>
						<option value="5">已报名</option>
					</select>
				</p>
			</div>
		</form>
	</div>
	<div id="cm-dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveCustom()"
			style="width:90px">提交</a> <a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel"
			onclick="javascript:$('#cm-ff').form('resetValidation').form('reset');$('#cm-dlg').dialog('close');"
			style="width:90px">取消</a>
	</div>
	<div>
		<div id="cm-query" class="easyui-panel" closed="true" noheader="true" closable="true">
			<div id="cm-toolbar">
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" plain="true"
					onclick="javascript:$('#cm-dg').edatagrid('saveRow')">保存修改</a> <a href="javascript:void(0)"
					class="easyui-linkbutton" iconCls="icon-undo" plain="true"
					onclick="javascript:$('#cm-dg').edatagrid('cancelRow')">退出编辑</a> <a href="javascript:void(0)"
					class="easyui-linkbutton" iconCls="icon-large-clipart" plain="true" onclick="allotToSales()">新增未上门客户分配</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-large-clipart" plain="true"
					onclick="openAllotDlg()">新增已上门客户分配</a>
			</div>
			<table id="cm-dg" title="查询结果" singleSelect="true" toolbar="#cm-toolbar" autoSave="false"
				idField="id" pagination="true" pageSize="5" pageList="[5,10,15,20]">
				<thead>
					<tr>
						<th field="id" width="100" align="center">客户编号</th>
						<th field="name" width="100" align="center"
							editor="{type:'validatebox',options:{required:true}}">客户姓名</th>
						<th field="education" width="100" align="center" formatter="eduFormat"
							editor="{type:'combobox',options:{data:[{'education':'1','text':'本科'},
				{'education':'2','text':'专科'},
				{'education':'3','text':'高中'},
				{'education':'4','text':'硕士'}],valueField:'education',textField:'text',panelHeight:'auto'}}">教育水平</th>
						<th field=phoneNo width="100" align="center"
							editor="{type:'validatebox',options:{required:true}}">手机</th>
						<th field=qq width="150" align="center" editor="{type:'validatebox'}">qq</th>
						<th field=email width="150" align="center"
							editor="{type:'validatebox',options:{validType:'email'}}">邮箱</th>
						<th field=customStatu width="100" formatter="statuFormat" align="center"
							editor="{type:'combobox',options:{data:[{'customStatu':'0','text':'新增未上门'},
				{'customStatu':'1','text':'新增已上门'},
				{'customStatu':'2','text':'销售跟进中'},
				{'customStatu':'3','text':'咨询跟进中'},{'customStatu':'4','text':'死单'},{'customStatu':'5','text':'已入学'}],valueField:'customStatu',textField:'text',panelHeight:'auto'}}">状态</th>
						<th field=createDate width="200" align="center">创建日期</th>
						
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<div id="consult-dlg" class="easyui-dialog" style="width:400px;padding-left: 10px"
		buttons="#consult-dlg-buttons" closed="true" closable="true" modal="false" title='请选择咨询师'>
		<form id="consult-ff" method="post">
			<div>
				<p>
					<label for="consultManId" class="label-top">请选择咨询师:</label> <input id="cosulterID"
						name="consultManId" style="height: 32px;width: 100px" />
				</p>
			</div>
		</form>
		<div id="consult-dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok"
				onclick="allotToConsult()" style="width:90px">确认分配</a> <a href="javascript:void(0)"
				class="easyui-linkbutton" iconCls="icon-cancel"
				onclick="javascript:$('#consult-dlg').dialog('close')" style="width:90px">取消</a>
		</div>
	</div>
	<div id="import-dlg" class="easyui-dialog" style="width:400px;padding-left: 10px" closed="true"
		closable="true" modal="false" title='批量导入客户信息'>
		<form id="import-ff" method="post" enctype="multipart/form-data" style="margin: 20px">
			<div style="margin-bottom:40px">
				<input class="easyui-filebox" name="file" id="file" labelPosition="top"
					data-options="prompt:'请选择客户excel文件...'" style="width:100%" buttonText="选择文件">
			</div>
			<div>
				<a href="javascript:void(0)" class="easyui-linkbutton" style="width:50%;margin-left: 25%"
					onclick="upload()">确认上传</a>
			</div>
		</form>
	</div>
	
	<div id="dld-dlg" class="easyui-dialog" style="width:400px;padding-left: 10px" closed="true"
		closable="true" modal="false" title='请选择要导出的'>
		<form id="import-ff" method="post" enctype="multipart/form-data" style="margin: 20px">
			<div style="margin-bottom:40px">
				<input class="easyui-filebox" name="file" id="file" labelPosition="top"
					data-options="prompt:'请选择客户excel文件...'" style="width:100%" buttonText="选择文件">
			</div>
			<div>
				<a href="javascript:void(0)" class="easyui-linkbutton" style="width:50%;margin-left: 25%"
					onclick="upload()">确认导出</a>
			</div>
		</form>
	</div>
	<script type="text/javascript">
		$(function() {
			$('#cm-dg').edatagrid({
				updateUrl : 'updateCustom.do'
			});

		});

		function saveCustom() {

			$('#cm-ff').form('submit', {
				url : 'insertCustom.do',
				success : function(data) {
					if (data ==1) {
						$.messager.alert('OK', "客户添加成功!", 'info');
						$('#cm-ff').form("resetValidation").form("reset");
						$('#cm-dlg').dialog('close');
						$('#cm-dg').datagrid('reload');
					} else {
						$.messager.alert('Sorry', '客户已存在!', 'error');
					}
				}
			});
		}

		function eduFormat(value, row) {
			if (row.education == 1) {
				return '本科';
			} else if (row.education == 2) {
				return '专科';
			} else if (row.education == 3) {
				return '高中';
			} else if (row.education == 4) {
				return '硕士';
			}

		}

		/* 客户状态格式化方法 */
		function statuFormat(value, row) {
			if (row.customStatu == 0) {
				return '新增未上门';
			} else if (row.customStatu == 1) {
				return '新增已上门';
			} else if (row.customStatu == 2) {
				return '销售跟进中';
			} else if (row.customStatu == 3) {
				return '咨询跟进中';
			} else if (row.customStatu == 4) {
				return '死单';
			} else {
				return '硕士';
			}
		}

		/* 搜索执行方法 */
		function queryCustom() {

			var value = null;

			var type = queryType();

			if (type == 'createDate') {
				value = $('#qdate').datebox('getValue');
			} else if (type == 'customStatu') {
				value = $("#state").val();
			} else {
				value = "%25" + $("#param").val() + "%25";
			}

			if (type == 'all') {
				$("#cm-dg").edatagrid({
					url : 'queryCustom.do',
					onLoadSuccess : function() {
						$('#cm-query').panel('open');
					}
				})
			} else {

				if (value !== "%25%25" && value !== '') {
					$("#cm-dg").edatagrid({
						url : 'queryCustom.do?' + type + "=" + value,
						onLoadSuccess : function(data) {
							if (data.rows.length == 0) {
								$.messager.alert('sorry', '未查询到相关记录！', 'info');
							} else {
								$('#cm-query').panel('open');
							}
						}
					})
				} else {
					$.messager.alert('error', '请输入查询条件！', 'error');
				}
			}
		}

		/* 获取查询条件类型 */
		function queryType() {
			var type = $('#qtype').val();

			if (type == 'createDate') {
				$("#date").css('display', 'inline');
			} else {
				$("#date").css('display', 'none');
			}

			if (type == 'customStatu') {
				$("#state").css('display', 'inline');
			} else {
				$("#state").css('display', 'none');
			}

			if (type != 'createDate' && type != 'customStatu' && type != 'all') {
				$("#input").css('display', 'inline');
			} else {

				$("#input").css('display', 'none');
			}

			return type;
		}

		/* 分配状态为新增为上门的客户 */
		function allotToSales() {
			$.post('allotCustom.do', function(data) {
				if (data == 1) {
					$.messager.alert('OK', '所有新增客户已分配!', 'info');
					$('#cm-dg').datagrid('reload');
					
				} else {
					$.messager.alert('Sorry', '无新增客户!', 'warning');
				}
			})
		}

		/* 打开分配已上门客户对话框 */
		function openAllotDlg() {
			var row = $('#cm-dg').datagrid('getSelected');

			if (row == null) {
				$.messager.alert('Sorry', '请选择客户!', 'warning');
			} else if (row.customStatu != 1) {
				$.messager.alert('Sorry', '必须是新增已上门客户，请重新选择!', 'warning');
			} else {
				$('#cosulterID').combobox({
					url : 'queryConsulters.do',
					valueField : 'id',
					textField : 'realname',
					panelHeight : 'auto',
					editable : false,

				})

				$('#consult-dlg').dialog('open');
			}
		}

		/* 分配已上门客户 */
		function allotToConsult() {
			var row = $('#cm-dg').datagrid('getSelected');

			if ($("#cosulterID").combobox('getValue') != '') {
				$('#consult-ff').form('submit', {
					url : 'allotToConsult.do',
					onSubmit : function(param) {
						param.customId = row.id;
					},
					success : function(data) {
						if (data == 1) {
							$('#consult-dlg').dialog('close')
							$.messager.alert('OK', "客户分配成功!", 'info');
							$('#cm-dg').datagrid('reload');
						} else {
							$.messager.alert('Sorry', '客户分配失败!', 'error');
						}
					}
				});
			} else {
				$.messager.alert('Sorry', '请选择咨询师!', 'warnning');
			}
		}

		/* 上传excel 批量导入用户 */
		function upload() {

			var file = $("#file").filebox('getValue');

			if (file == '') {
				$.messager.alert('警告', '请选择客户信息excel!', 'warnning');
			} else {
				var type = file.substr(file.lastIndexOf("."));

				if (type == ".xls") {

					$('#import-ff').form('submit', {
						url : 'batchImportCustom.do',
						success : function(data) {
							if (data >= 0) {

								$('#import-ff').form('reset');
								$('#import-dlg').dialog('close');

								$.messager.alert('OK', "成功导入" + data + "个客户!", 'info');
							} else if (data == "false") {

								$('#import-dlg').dialog('close');
								$.messager.alert('Sorry', '文件上传失败!', 'error');
							}
						}
					});
				} else {
					$.messager.alert('警告', '文件类型不匹配,必须是MS2003版本的.xls文件', 'warnning');
				}
			}

		}
		
		
		
		
		
		
		
		
		
		
		
	</script>
</body>
