<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>



  
  <body>
    <h1 style="text-align: center">统计数据</h1>
    
    <div style="margin: 10px">
			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-sum" plain="false"
				onclick="showMyCount()">我的统计数据</a>
		</div>
    <div id="count-ci-dlg"  class="easyui-dialog" closed="true" modal="false" border="false" shadow="false"
		noheader='true'>

		<table id="count-ci-dg" title="客户邀请本月统计"  style="width:703px;height: 100px" closable='true'>
			
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
	
	
	 <div id="count-cr-dlg" class="easyui-dialog" closed="true" modal="false" border="false" shadow="false"
		noheader='true'>

		<table id="count-cr-dg" title="客户咨询本月统计"  style="width:603px;height: 100px"  closable='true'>
			
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
	
	
	
	
	<input type="hidden" id="myid" value="${user.id}"/>
	<input type="hidden" id="myjob" value="${user.jobInfoId}"> 
	
	
	
	
	
	<script type="text/javascript">
	
		function showMyCount(){
			var jid=${user.jobInfoId};
			
			var id=${user.id};
			
			
			if(jid=="8"|jid=="5"){
				$('#count-ci-dg').datagrid({
					url:'countInfo.do?followManId='+id,
					onLoadSuccess : function(data) {
						$('#count-ci-dlg').panel('open');
						
					}
				})
			}else{
				$('#count-cr-dg').datagrid({
					url:'countConsult.do?consultManId='+id,
					onLoadSuccess : function(data) {
						$('#count-cr-dlg').panel('open');
						
					}
				})
			}
			
		
		}
	
	
	
	
	
	
	</script>
	
	
	
	
	
  </body>

