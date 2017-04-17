<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<body>
	<h1 style="text-align: center">部门员工</h1>
	<div style="text-align: center;padding-left: 400px">
		<div id="epms-toolbar">
			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-sum" plain="true"
				onclick="departCunt()">部门统计</a>
		</div>
		<table id="epms" title="员工信息表" style="width:602px;height:450px;" toolbar="#epms-toolbar"
			data-options="singleSelect:true,collapsible:false,method:'post'">
			<thead>
				<tr>
					<th data-options="field:'id',width:100,align:'center'">员工工号</th>
					<th data-options="field:'realname',width:100,align:'center'" formatter="empFormat">姓名</th>
					<th data-options="field:'nickname',width:100,align:'center'">员工昵称</th>
					<th data-options="field:'phoneNo',width:150,align:'center'">手机</th>
					<th data-options="field:'officeTel',width:150,align:'center'">办公电话</th>
				</tr>
			</thead>
		</table>
	</div>
	<div id="TMK-p" class="easyui-dialog" closed="true" modal="false" border="false" shadow="false"
		noheader='true'>
		<table id="TMK-dg" style="width:703px;height: 100px" class="easyui-datagrid" closable='true'>
			<thead>
				<tr>
					<th field="newAllot" width="100" align="center">新增客户数</th>
					<th field="visited" width="100" align="center">已上门客户数</th>
					<th field="disConnect" width="100" align="center">未接通客户数</th>
					<th field="invalid" width="100" align="center">电话无效客户数</th>
					<th field="denied" width="100" align="center">死单客户数</th>
					<th field="following" width="100" align="center">紧跟客户数</th>
					<th field="total" width="100" align="center">总分配客户数</th>
				</tr>
			</thead>
		</table>
	</div>
	<div id="consult-p" class="easyui-dialog" closed="true" modal="false" border="false" shadow="false"
		noheader='true'>
		<table id="consult-dg" style="width:603px;height: 100px" class="easyui-datagrid" closable='true'>
			<thead>
				<tr>
					<th field="newAllot" width="100" align="center">新增客户数</th>
					<th field="following" width="100" align="center">紧跟客户数</th>
					<th field="signed" width="100" align="center">已报名客户数</th>
					<th field="denied" width="100" align="center">死单客户数</th>
					<th field="refundment" width="100" align="center">报名后退费客户数</th>
					<th field="total" width="100" align="center">总分配客户数</th>
				</tr>
			</thead>
		</table>
		
	</div>
	<input type="hidden" value="${user.departmentId }" id="departId" />
	<input type="hidden" value="${user.id }" id="managerId" />
	<script type="text/javascript">
		$("#epms").datagrid({
			url : 'empForDepart.do?departmentId=' + $('#departId').val() + '&managerId=' + $('#managerId').val()
		});

		function empFormat(value, row) {

			return "<a href='javascript:showMyCount()'>" + row.realname + "</a>"

		}

		function showMyCount() {

			var row = $("#epms").datagrid('getSelected');

			var departId = $("#departId").val();

			if (departId == "2" | departId == "3") {
				$("#TMK-dg").datagrid({
					url : "countInfo.do?followManId=" + row.id,
					title : row.realname + "本月统计",
					onLoadSuccess : function(data) {
						$("#TMK-p").dialog('open')
					}
				})

			} else if (departId == "4") {
				$("#consult-dg").datagrid({
					url : "countConsult.do?consultManId=" + row.id,
					title : row.realname + "本月统计",
					onLoadSuccess : function(data) {
						$("#consult-p").dialog('open');
					}
				})
			}

		}

		function departCunt() {

			var departId = $("#departId").val();

			if (departId == "2" | departId == "3") {
				$("#TMK-dg").datagrid({
					url : "countInfoForDepart.do?departmentId=" + departId,
					title : "部门本月统计",
					onLoadSuccess : function(data) {
						$("#TMK-p").dialog('open')
					}
				})

			} else if (departId == "4") {
				$("#consult-dg").datagrid({
					url : "countConsultForDepart.do?departmentId=" + departId,
					title : "部门本月统计",
					onLoadSuccess : function(data) {
						$("#consult-p").dialog('open');
					}
				})
			}

		}
	</script>
</body>
