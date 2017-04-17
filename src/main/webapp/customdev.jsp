<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<body>
	<h1 style="text-align: center">客户开发</h1>
	<c:if test="${user.jobInfoId==9}">
		<div style="margin: 20px 20px;width: 400px">
			<span style="font-size: 18;font-weight: bold;">选择部门员工：</span><input id="emps-TMK"
				 panelHeight="auto" editable="false"
				data-options="valueField:'id',textField:'realname',
	onLoadSuccess:function(){
		var data = $('#emps-TMK').combobox('getData');
		$('#emps-TMK').combobox('select',data[0].id);
	},
	onSelect:function(record){
	if($('#jbid').val()!=8){
		changeDg(record.id)
		}
	}"
				style="width: 100px" />
		</div>
	</c:if>
	<c:if test="${user.jobInfoId==6}">
		<div style="margin: 20px 20px;width: 400px">
			<span style="font-size: 18;font-weight: bold;">选择部门员工：</span><input id="emps-TMK"
				 panelHeight="auto" editable="false"
				data-options="valueField:'id',textField:'realname',
	onLoadSuccess:function(){
		var data = $('#emps-TMK').combobox('getData');
		$('#emps-TMK').combobox('select',data[0].id);
	},
	onSelect:function(record){
	if($('#jbid').val()!=8){
		changeDg(record.id)
		}
	}"
				style="width: 100px" />
		</div>
	</c:if>
	<div id="cf-toolbar">
		选择表格: <select onchange="changeDg()" style="width:100px" id="source">
			<option value="0">今日数据</option>
			<option value="1">历史遗留</option>
			<option value="2">诺在今日</option>
			<option value="3">本月数据</option>
		</select> <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" plain="true"
			onclick="javascript:$('#cf-dg').edatagrid('saveRow')">保存修改</a> <a href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-undo" plain="true"
			onclick="javascript:$('#cf-dg').edatagrid('cancelRow')">退出编辑</a>
	</div>
	<div style="margin-left: 20px">
		<table id="cf-dg" title="客户跟踪" style="width:903px;height:250px" toolbar='#cf-toolbar'
			singleSelect="true" autoSave="false" idField="id" pagination="true" pageSize="5"
			pageList="[5,10,15,20]" >
			<thead>
				<tr>
					<th field="id" width="100" align="center">编号</th>
					<th field="customId" width="100" align="center" hidden="true">客户编号</th>
					<th field="customName" width="100" align="center">客户姓名</th>
					<th field="customPhoneNo" width="100" align="center">客户手机</th>
					<th field="statu" width="100" formatter="statuFormat" align="center"
						editor="{type:'combobox',options:{data:[{'statu':'0','text':'未联系'},
				{'statu':'1','text':'未接通'},
				{'statu':'2','text':'紧跟'},
				{'statu':'3','text':'已上门'},{'statu':'4','text':'死单'},{'statu':'5','text':'电话无效'}],valueField:'statu',textField:'text',panelHeight:'auto'}}">跟踪状态</th>
					<th field="startDate" width="100" align="center">分配时间</th>
					<th field="planDate" width="100" align="center" editor="{type:'datebox'}">计划联系时间</th>
					<th field="lastFollowDate" width="100" align="center">上一次联系时间</th>
					<th field="mark" width="200" formatter='markFormat' align="center">备注</th>
				</tr>
			</thead>
		</table>
	</div>
	<div id="mark-dlg" class="easyui-dialog" style="width:400px;padding-left: 10px" closed="true"
		closable="true" modal="false" title='备注信息'>
		<div id="showMark" style="margin: 20px"></div>
	</div>
	<input type="hidden" id="flmId" value="${user.id}"/>
	<input type="hidden" id="jbid" value="${user.jobInfoId}"> 
	<input type="hidden" id="dptid" value="${user.departmentId}"> 
	
	
	<script type="text/javascript">
		$(function() {
			
			$('#cf-dg').edatagrid({

				onSave : function(index, row) {


					if (row.planDate == '' | row.planDate == null) {
						$.post('updateCustomInfo.do', {
							id : row.id,
							statu : row.statu,
							customId : row.customId
						}, function(data) {
							$('#cf-dg').edatagrid('reload');
						})
					} else {
						var date = row.planDate;
						var myDate = new Date();
						var month = myDate.getMonth() + 1;
						if (month < 10) {
							month = "0" + month;
						}
						var day = myDate.getDate();

						if (day < 10) {
							day = "0" + day
						}

						var today = myDate.getFullYear() + "-" + month + "-" + day;

						if (date > today) {
							$.post('updateCustomInfo.do', {
								id : row.id,
								statu : row.statu,
								planDate : date,
								customId : row.customId
							}, function(data) {
								$('#cf-dg').edatagrid('reload');
							})
						} else {
							
							
							$('#cf-dg').edatagrid('rejectChanges');//回滚
						}
					}
				}
			});

			
			if($("#dptid").val()==2&&$("#jbid").val()==9){
				$("#emps-TMK").combobox({
					url:'empForJobId.do?jobInfoId=8'
				})
			}else if($("#dptid").val()==3&&$("#jbid").val()==6){
				$("#emps-TMK").combobox({
					url:'empForJobId.do?jobInfoId=5'
				})
			}
			
			
			
			if ($("#jbid").val() == 8) {
				$('#cf-dg').datagrid({
				url : 'customInfo.do?src=0&followManId=' +$("#flmId").val(),
				
			}); 
				
			} 
			
			
			
			
			
			$('#cf-dg').datagrid({
				clickToEdit : false,
				dblclickToEdit : true
				
			})
			$('#cf-dg').datagrid('enableCellEditing');
		});

		function changeDg(followManId) {
			var src = $("#source").val();
			
			if ($("#jbid").val() == 8||$("#jbid").val()==5) {
				followManId = $("#flmId").val();
			}else{
				if(followManId==undefined){
					followManId=$('#emps-TMK').combobox('getValue');
				}
			}
			
			
			
			$('#cf-dg').edatagrid({
				url : 'customInfo.do?src=' + src + "&followManId=" + followManId

			})

		}

		/* 客户状态格式化方法 */
		function statuFormat(value, row) {
			if (row.statu == 0) {
				return '未联系';
			} else if (row.statu == 1) {
				return '未接通';
			} else if (row.statu == 2) {
				return '紧跟';
			} else if (row.statu == 3) {
				return '已上门';
			} else if (row.statu == 4) {
				return '已死单';
			} else {
				return '电话无效';
			}
		}

		function markFormat(value, row) {
			if (row.mark == '' | row.mark == null) {
				return "<a href='javascript:addMark()'>" + "添加" + "</a>";
			} else {

				return "<a href='javascript:showMark()'>" + "查看" + "</a>&nbsp;&nbsp;<a href='javascript:addMark()'>" + "添加" + "</a>"
			}
		}

		function addMark() {
			var row = $('#cf-dg').datagrid('getSelected');


			$.messager.prompt('tips', '请输入备注信息', function(r) {
				if (r) {
					$.post('addMark.do', {
						id : row.id,
						mark : r
					}, function(data) {
						if (data == 1) {
							$('#mark-dlg').dialog('close');
							$.messager.alert('OK', '备注添加成功!', 'info');
							$('#cf-dg').edatagrid('reload')

						} else {
							$.messager.alert('Sorry', '备注添加失败!', 'error');
						}
					})
				}
			});

		}

		function showMark() {
			var row = $('#cf-dg').datagrid('getSelected');
			var text = row.mark;
			texts = text.split(',');
			var newtext = "";
			for (var i = 0; i < (len = texts.length); i++) {
				newtext += "<li>" + texts[i] + "</li>"
			}

			
			$("#showMark").html("")
			$("#showMark").append(newtext)

			$('#mark-dlg').dialog('open');
		}

		function closeMarkDlg() {
			//清空表单
			$('#mark-ff').form("clear");
			//关闭对话框
			$('#mark-dlg').dialog('close');
		}
	</script>
</body>
