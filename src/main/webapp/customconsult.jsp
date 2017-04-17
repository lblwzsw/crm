
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
	<h1 style="text-align: center">客户咨询管理</h1>
	<c:if test="${user.jobInfoId==4 }">
	<div style="margin-left: 20px;margin-bottom: 40px">
		<div style="width: 400px;margin-bottom: 20px">
			<span style="font-size: 18;font-weight: bold;margin-right: 20px">选择部门员工:</span><input id="emps-consult"
				class="easyui-combobox" panelHeight="auto" editable="false" 
				data-options="valueField:'id',textField:'realname',url:'empForJobId.do?jobInfoId=3',onLoadSuccess:function(){
		var data = $('#emps-consult').combobox('getData');
		$('#emps-consult').combobox('select',data[0].id);
	},
	onSelect:function(record){
	if($('#jobid').val()!=3){
		queryRecord(record.id);
		}
	}" style="width: 100px;margin-left: 10px;height: 32px"/>
		</div>
		</c:if>
		
		<div id="navigation" style="margin: 0 auto">
			<span style="font-size: 18;font-weight: bold;">查询类型:</span><select id="byBype"
				style="width:150px;height: 32px;margin-left: 10px" onchange="qType()">
				<option value="all" selected="selected">本月所有</option>
				<option value="customName">按客户姓名查询</option>
				<option value="customPhoneNo">按客户手机号码查询</option>
				<option value="dateScope">按时间段查询</option>
			</select> <span style="display: none" id="inputBox"><input class="easyui-textbox"
				data-options="iconCls:'icon-edit',prompt:'请输入查询条件'" style="width:300px;height: 32px;"
				id="qparam"> </span> <span style="display: none" id="dateBox">咨询日期从：<input
				class="easyui-datebox" data-options="currentText:'今天'" style="width:110px;height: 32px"
				id="sdate">到：<input class="easyui-datebox" data-options="currentText:'今天'"
				style="width:110px;height: 32px" id="edate">
			</span><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="false"
				onclick="queryRecord()" style="height: 32px;margin-left: 10px">&nbsp;搜索 &nbsp;</a>
		</div>
	</div>
	<div id="cr-query" class="easyui-panel" closed="true" noheader="true" closable="true">
		<div id="cr-toolbar">
			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" plain="true"
				onclick="javascript:$('#cr-dg').edatagrid('saveRow')">保存修改</a> <a href="javascript:void(0)"
				class="easyui-linkbutton" iconCls="icon-undo" plain="true"
				onclick="javascript:$('#cr-dg').edatagrid('cancelRow')">退出编辑</a>
		</div>
		<table id="cr-dg" title="客户跟踪" singleSelect="true" toolbar="#cr-toolbar" autoSave="false"
			idField="id" pagination="true" pageSize="2" pageList="[2,4,6,8]">
			<thead>
				<tr>
					<th field="id" width="100" align="center">编号</th>
					<th field="customId" width="100" align="center" hidden="true">客户编号</th>
					<th field="customName" width="100" align="center">客户姓名</th>
					<th field="customPhoneNo" width="100" align="center">客户手机</th>
					<th field="consultStatu" width="100" formatter="consultStatuFormat" align="center"
						editor="{type:'combobox',options:{data:[{'consultStatu':'0','text':'新增'},
				{'consultStatu':'1','text':'紧跟'},
				{'consultStatu':'2','text':'已报名'},
				{'consultStatu':'3','text':'死单'},{'consultStatu':'4','text':'报名后退费'}],valueField:'consultStatu',textField:'text'}}">跟踪状态</th>
					<th field="consultDate" width="100" align="center">咨询时间</th>
					<th field="result" width="100" formatter='resultFormat' align="center">咨询备注</th>
				</tr>
			</thead>
		</table>
	</div>
	<div id="cr-dlg" class="easyui-dialog" style="width:400px;padding-left: 10px" closed="true"
		closable="true" modal="false" title='备注信息'>
		<div id="showResult" style="margin: 20px"></div>
	</div>
	
	<input type="hidden" id="csltId" value="${user.id}"/>
	<input type="hidden" id="jobid" value="${user.jobInfoId}"> 
	
	<script type="text/javascript">
		$(function() {
			$("#cr-dg").edatagrid({
				updateUrl : 'updateRecord.do',
				
			})

		})

		/* 查询类型 */
		function qType() {

			var type = $('#byBype').val();

			if (type == 'dateScope') {
				$("#dateBox").css('display', 'inline');
			} else {
				$("#dateBox").css('display', 'none');
			}

			if (type != 'dateScope' && type != 'all') {
				$("#inputBox").css('display', 'inline');
			} else {

				$("#inputBox").css('display', 'none');
			}

			return type;

		}

		/* 搜索执行方法 */
		function queryRecord(empId) {

			var type = qType();

			

			var consultManId=empId;
			if($("#jobid").val()=="3"){
				 consultManId=$('#csltId').val();
			}else{
				if(consultManId==undefined){
					consultManId=$('#emps-consult').combobox('getValue');
				}
			}
			
			
			
			if (type == 'all') {
				alert("搜索本月全部")

				$("#cr-dg").edatagrid({
					url : 'queryRecord.do?consultManId='+consultManId,
					onLoadSuccess : function(data) {
						if (data.rows.length == 0) {
							$.messager.alert('sorry', '未查询到相关记录！', 'info');
						} else {
							$('#cr-query').panel('open');
						}
					}
					
				})
			} else if (type == 'dateScope') {
				var sdate = $('#sdate').datebox('getValue');
				var edate = $('#edate').datebox('getValue');
				if (sdate != '' && edate != '') {
					if (sdate < edate) {
						$("#cr-dg").edatagrid({
							url : 'queryRecord.do?consultDate=' + sdate + "&endDate=" + edate+"&consultManId="+consultManId,
							onLoadSuccess : function(data) {
								if (data.rows.length == 0) {
									$.messager.alert('sorry', '未查询到相关记录！', 'info');
								} else {
									$('#cr-query').panel('open');
								}
							}
						})
					} else {
						$.messager.alert('error', '查询日期有误!', 'error');
					}

				} else {
					$.messager.alert('error', '查询日期有误!', 'error');
				}
			} else {
				var value = $("#qparam").val();
				if (value !== '') {
					$("#cr-dg").edatagrid({
						url : 'queryRecord.do?' + type + "=" + "%25" + value + "%25"+"&consultManId="+consultManId,
						onLoadSuccess : function(data) {
							if (data.rows.length == 0) {
								$.messager.alert('sorry', '未查询到相关记录！', 'info');
							} else {
								$('#cr-query').panel('open');
							}
						}
					})
				} else {
					$.messager.alert('error', '请输入查询条件！', 'error');
				}
			}
		}

		function resultFormat(value, row) {
			if (row.result == '' | row.result == null) {
				return "<a href='javascript:addResult()'>" + "添加" + "</a>";
			} else {

				return "<a href='javascript:showResult()'>" + "查看" + "</a>&nbsp;&nbsp;<a href='javascript:addResult()'>" + "添加" + "</a>"
			}
		}

		/* 客户状态格式化方法 */
		function consultStatuFormat(value, row) {
			if (row.consultStatu == 0) {
				return '新增';
			} else if (row.consultStatu == 1) {
				return '紧跟';
			} else if (row.consultStatu == 2) {
				return '已报名';
			} else if (row.consultStatu == 3) {
				return '死单';
			} else
				(row.consultStatu == 4)
			{
				return '报名后退费';
			}
		}

		function addResult() {
			var row = $('#cr-dg').datagrid('getSelected');

			

			$.messager.prompt('tips', '请输入备注信息', function(r) {
				if (r) {
					$.post('addResult.do', {
						id : row.id,
						result : r
					}, function(data) {
						if (data == 1) {
							$('#rt-dlg').dialog('close');
							$.messager.alert('OK', '备注添加成功!', 'info');
							$('#cr-dg').edatagrid('reload')

						} else {
							$.messager.alert('Sorry', '备注添加失败!', 'error');
						}
					})
				}
			});

		}

		function showResult() {
			var row = $('#cr-dg').datagrid('getSelected');
			var text = row.result;
			texts = text.split(',');
			var newtext = "";
			for (var i = 0; i < (len = texts.length); i++) {
				newtext += "<li>" + texts[i] + "</li>"
			}

			alert(newtext)
			$("#showResult").html("")
			$("#showResult").append(newtext)

			$('#cr-dlg').dialog('open');
		}
	</script>
</body>
