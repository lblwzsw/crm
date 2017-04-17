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
	<div>
		<h3>账号管理</h3>
	</div>
	<div style="margin: 20px 20px;width: 1000px">
		<c:if test="${user.jobInfoId==1 }">
		<span style="font-size: 18;font-weight: bold;">功能导航：</span><a href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-add"
			onclick="javascript:$('#admin-dlg').dialog('open').dialog('center').dialog('setTitle','新增管理员');"
			style="height: 32px">&nbsp;新增管理员&nbsp;</a> <span style="margin-left: 30px"><a
			href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'"
			onclick="cancleUser()" style="height: 32px">&nbsp;注销员工账号&nbsp;</a>
			
			
			</span>
			</c:if>
			
			<c:if test="${user.jobInfoId==2 }">
			 <span
			style="margin-left: 30px"><a href="javascript:void(0)" class="easyui-linkbutton"
			data-options="iconCls:'icon-add'" style="height: 32px"
			onclick="javascript:$('#normal-dlg').dialog('open').dialog('center').dialog('setTitle','新增用户');">&nbsp;新增普通用户&nbsp;</a></span>
		<span style="margin-left: 30px"><a href="javascript:void(0)" class="easyui-linkbutton"
			data-options="iconCls:'icon-reload'" style="height: 32px" onclick="showResetPass()">&nbsp;重置账号密码&nbsp;</a></span>
			</c:if>
			
	</div>
	<div id="admin-dlg" class="easyui-dialog" style="width:400px" closed="true"
		buttons="#admin-dlg-buttons" closable="false">
		<form id="admin-ff" method="post">
			<div>
				<p>
					<label for="username" class="label-top">管理员账号:</label> <input class="easyui-validatebox"
						data-options="missingMessage:'请输入管理员账号',tipPosition:'bottom',required:true,validateOnCreate:false,validateOnBlur:true,validType:['email','length[4,20]']"
						invalidMessage="用户名无效!请重新输入!" validType="remote['checkUsername.do','username']" id="username"
						name="username" style="width: 270px" />
				</p>
			</div>
			<div>
				<p>
					<label for="realname" class="label-top">员工姓名:&nbsp;</label> <input class="easyui-validatebox"
						data-options="missingMessage:'请输入员工姓名',tipPosition:'bottom',required:true,validateOnCreate:false,validateOnBlur:true,validType:['CHS','length[2,10]']"
						id="realname" name="realname" style="width: 270px" />
				</p>
			</div>
			<div>
				<p>
					<label for="phoneNo" class="label-top">员工手机:&nbsp;</label> <input class="easyui-validatebox"
						data-options="missingMessage:'请输入员工手机',tipPosition:'bottom',required:true,validateOnCreate:false,validateOnBlur:true,validType:'mobile'"
						id="phoneNo" name="phoneNo" style="width: 270px" />
				</p>
			</div>
			<div>
				<p>
					<label for="officeTel" class="label-top">办公电话:&nbsp;</label> <input class="easyui-validatebox"
						data-options="missingMessage:'请输入员工办公电话',tipPosition:'bottom',required:true,validateOnCreate:false,validateOnBlur:true,validType:'tel'"
						id="officeTel" name="officeTel" style="width: 270px" />
				</p>
			</div>
		</form>
	</div>
	<div id="admin-dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser(1)"
			style="width:90px">提交</a> <a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel"
			onclick="javascript:$('#admin-ff').form('resetValidation').form('reset');$('#admin-dlg').dialog('close');"
			style="width:90px">取消</a>
	</div>
	<div id="normal-dlg" class="easyui-dialog" style="width:400px" closed="true"
		buttons="#normal-dlg-buttons" closable="false">
		<form id="normal-ff" method="post">
			<div>
				<p>
					<label for="rightName" class="label-top">员工账号:</label> <input class="easyui-validatebox"
						data-options="missingMessage:'请输入用户账号',tipPosition:'bottom',required:true,validateOnCreate:false,validateOnBlur:true,validType:'email'"
						invalidMessage="用户名无效!请重新输入!" validType="remote['checkUsername.do','username']" id="username"
						name="username" style="width: 270px" />
				</p>
			</div>
			<div>
				<p>
					<label for="pid" class="label-top" style="margin-right: 5px">所属部门:</label><input id="cc1"
						class="easyui-combobox" style="width: 150px" name="departmentId"
						data-options=" valueField: 'id', textField: 'dname',url: 'getDepartment.do',
										editable:false,
           								 panelHeight:'auto',    
        								onSelect: function(rec){    
           								 var url = 'getJobByDid.do?departmentId='+rec.id;   
           								  $('#cc2').combobox('clear'); 
           								 $('#cc2').combobox('reload', url);}" />
				</p>
			</div>
			<div>
				<p>
					<label for="job" class="label-top">所任职位:</label> <input id="cc2" class="easyui-combobox"
						data-options="valueField:'id',textField:'job'" style="width: 150px" panelHeight='auto'
						editable='false' name="jobInfoId" />
				</p>
			</div>
			<div>
				<p>
					<label for="realname" class="label-top">员工姓名:</label> <input class="easyui-validatebox"
						data-options="missingMessage:'请输入员工姓名',tipPosition:'bottom',required:true,validateOnCreate:false,validateOnBlur:true,validType:['length[2,10]','CHS']"
						id="realname" name="realname" style="width: 270px" />
				</p>
			</div>
			<div>
				<p>
					<label for="phoneNo" class="label-top">员工手机:</label> <input class="easyui-validatebox"
						data-options="missingMessage:'请输入员工手机',tipPosition:'bottom',required:true,validateOnCreate:false,validateOnBlur:true,validType:'mobile'"
						id="phoneNo" name="phoneNo" style="width: 270px" />
				</p>
			</div>
			<div>
				<p>
					<label for="officeTel" class="label-top">办公电话:</label> <input class="easyui-validatebox"
						data-options="missingMessage:'请输入员工办公电话',tipPosition:'bottom',required:true,validateOnCreate:false,validateOnBlur:true,validType:'tel'"
						id="officeTel" name="officeTel" style="width: 270px" />
				</p>
			</div>
		</form>
	</div>
	<div id="normal-dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser(2)"
			style="width:90px">提交</a> <a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel"
			onclick="javascript:$('#normal-ff').form('resetValidation').form('reset');$('#normal-dlg').dialog('close');"
			style="width:90px">取消</a>
	</div>
	<div id="reset-dlg" class="easyui-dialog" style="width:565px;"
		data-options="resizable:false,modal:false" closed='true' noheader='true' border='false'
		shadow='false'>
		<table id="reset-dg" title="重置密码请求表" style="width:545px;margin: 10px"
			data-options="singleSelect:true,collapsible:false,method:'post'" closable='true'>
			<thead>
				<tr>
					<th data-options="field:'id',width:80,align:'center'">请求编号</th>
					<th data-options="field:'username',width:200,align:'center'">员工账号</th>
					<th data-options="field:'phoneNo',width:200,align:'center'">员工手机</th>
					<th data-options="field:'action',width:50,align:'center'" formatter="actionFormat">操作</th>
				</tr>
			</thead>
		</table>
	</div>
	<script type="text/javascript">
		function saveUser(type) {

			if (type == 1) {

				$('#admin-ff').form('submit', {
					url : "addUser.do",
					success : function(data) {
						if (data == 1) {

							//重置验证
							$('#admin-ff').form('resetValidation');
							//表单重置
							$('#admin-ff').form('reset');
							//关闭对话框
							$('#admin-dlg').dialog('close')
							$.messager.alert('OK', '管理员账号添加成功！', 'info');

						}
					}
				});
			} else {
				if ($("#cc1").combobox('getValue') != '' && $("#cc2").combobox('getValue')!= '')

					$('#normal-ff').form('submit', {
						url : "addUser.do",
						success : function(data) {
							if (data == 1) {

								$('#normal-ff').form('resetValidation').form('reset');
								$('#normal-dlg').dialog('close')

								$.messager.alert('OK', '员工账号添加成功！', 'info');
							}
						}
					});

			}

		}

		function cancleUser() {
			$.messager.prompt('注销员工账号', '请输入将要注销的员工账号', function(r) {
				if (r) {
					var res = /^[\w\.-]+?@([\w\-]+\.){1,2}[a-zA-Z]{2,3}$/

					if (res.test(r)) {
						$.post('cancleUser.do', {
							username : r
						}, function(data) {
							if (data == 1) {
								$.messager.alert('OK', '账号注销成功!', 'info');
							}
							if (data == 0) {
								$.messager.alert('警告', '用户名不存在!请检查后重新输入!', 'warnning');
							}
							if (data == 2)
								$.messager.alert('警告', '该账号已注销,请确认!', 'warnning');
						})

					} else {
						$.messager.alert('警告', '用户名无效!请重新输入!', 'warnning');

					}
				}
			});

		}

		function showResetPass() {
			$('#reset-dg').datagrid({
				url : 'querRestRequest.do',
				onLoadSuccess : function(data) {

					if (data.rows.length == 0) {
						$.messager.alert('OK', '暂时无重置密码请求！', 'info');
					} else {
						$('#reset-dlg').dialog('open').dialog('center');
					}
				}
			})

		}

		function restPass() {

			$.messager.confirm('确认', '确认重置该账号密码', function(r) {
				if (r) {
					var row = $('#reset-dg').datagrid('getSelected');

					$.post('resetPass.do', {
						id : row.id,
						username : row.username,
						phoneNo : row.phoneNo
					}, function(data) {

						if (data == 1) {
							$.messager.alert('OK', '密码重置成功!', 'info');

							$("#reset-dg").datagrid('reload');

						}

					})

				}
			});

		}

		function actionFormat(value, row) {
			if (row.id != '')
				return "<a href='javascript:restPass()'>重置</a>"
		}
	</script>
</body>
