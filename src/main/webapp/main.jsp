<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>CRM系统</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<jsp:include page="uiImport.jsp"></jsp:include>
<script type="text/javascript">
	function newTab(title, url) {
		if ($('#tt').tabs('exists', title)) {
			$('#tt').tabs('select', title)
		} else {
			$('#tt').tabs('add', {
				title : title,
				closable : true,
				width : '1000px',
				href : url,
				tools : [ {
					iconCls : 'icon-mini-refresh',
					handler : function() {
						alert('refresh');
					}
				} ]
			});
		}

	}

	function updateUser() {
		$('#user-ff').form('submit', {
			url : 'updateUser.do',
			onSubmit : function(param) {
				param.id = ${user.id};
			},
			success : function(data) {
				if (data == "1") {
					
					$('#user-dlg').dialog('close')
					$.messager.alert('', '个人信息修改成功!', 'info');
				}
			}
		});

	}

	function changePass() {
		
		var oldPwd=$("#oldPass").val();
		var newPwd=$("#newPass").val();
		oldPwd=hex_sha1(oldPwd);
		var newPwd=hex_sha1($("#newPass").val());
		
		$.post("changePass.do",{employeeId:"${user.id}",pass:oldPwd,newPass:newPwd},function(data){
			
			if(data=="1"){
				
				$.messager.confirm('', '密码修改成功,请重新登陆!', function(r){
					
						window.location.href="login.jsp";	   
					
				});


				
			}else if(data=="0"){
				$.messager.alert('', '原密码输入不正确,请重新操作!', 'warnning');
				$('#pwd-ff').form('resetValidation').form('reset');
			}
			
			
		})
		
		

	}
	
	
	function logout(){
		$.messager.confirm('', '您想要退出该系统吗？', function(r){
			if (r){
			  window.location.href="logout.do";
			}
		});


		
	}
	
	
	
	
	
	
	
	
</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north',border:false" style="height:60px;background:#FFFFFF;">
		<div style="margin-top: 6px;float: left;margin-left: 600px">
			<img src="images/oracle.png">
		</div>
		<div align="right" style="float: left;margin-left: 400px;margin-top: 40px">
			<span>当前用户:<a href="javascript:$('#user-dlg').dialog('open')">${user.nickname }</a></span>&nbsp;&nbsp;<a
				href="javascript:logout()">注销</a>
		</div>
	</div>
	<div id="user-dlg" class="easyui-dialog" style="width:400px" closed="true" title="个人基本信息"
		buttons="#user-dlg-buttons" closable="true">
		<form id="user-ff" method="post">
			<div>
				<p>
					<label for="nickname" class="label-top">昵称:&nbsp;&nbsp;&nbsp;</label> <input
						class="easyui-validatebox"
						data-options="missingMessage:'请输入新昵称',tipPosition:'bottom',required:true,validateOnCreate:false,validateOnBlur:true,validType:['email','length[4,20]']"
						invalidMessage="新昵称无效!请重新输入!" validType="length[2,10]" id="nickname" value="${user.nickname }"
						name="nickname" style="width: 270px" />
				</p>
			</div>
			<div>
				<p>
					<label for="phoneNo" class="label-top">我的手机:&nbsp;</label> <input class="easyui-validatebox"
						data-options="missingMessage:'请输入您的手机号',tipPosition:'bottom',required:true,validateOnCreate:false,validateOnBlur:true,validType:'mobile'"
						id="phoneNo" name="phoneNo" style="width: 270px" value="${user.phoneNo }" />
				</p>
			</div>
			<div>
				<p>
					<label for="officeTel" class="label-top">办公电话:&nbsp;</label> <input class="easyui-validatebox"
						data-options="missingMessage:'请输入您的办公电话',tipPosition:'bottom',required:true,validateOnCreate:false,validateOnBlur:true,validType:'tel'"
						id="officeTel" name="officeTel" style="width: 270px" value="${user.officeTel }" />
				</p>
			</div>
		</form>
		<div id="user-dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" onclick="updateUser()"
				style="width:90px">保存</a> <a href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-reload" onclick="javascript:$('#pwd-dlg').dialog('open');$('#user-dlg').dialog('close')" style="width:90px">修改密码</a>
		</div>
	</div>
	<div id="pwd-dlg" class="easyui-dialog" style="width:400px" closed="true" title="修改密码"
		buttons="#pwd-dlg-buttons" closable="true">
		<div style="padding-left: 50px">
		<form id="pwd-ff" method="post">
			<div>
				<p>
					<label for="oldPass" class="label-top">原密码:&nbsp;</label> <input
						class="easyui-textbox" type="password"
						data-options="missingMessage:'请输入原密码',tipPosition:'bottom',required:true,validateOnCreate:false,validateOnBlur:true,validType:'length[6,16]'"
						 validType="length[6,18]" id="oldPass" 
						name="oldPass" style="width: 200px" />
				</p>
			</div>
			<div>
				<p>
					<label for="newPass" class="label-top">新密码:&nbsp;</label> <input class="easyui-textbox" type="password"
						data-options="missingMessage:'请输入您的新密码!',tipPosition:'bottom',required:true,validateOnCreate:false,validateOnBlur:true,validType:'length[6,16]'"
						id="newPass" name="newPass" style="width: 200px"  />
				</p>
			</div>
		
		
		
		</form>
		</div>
		<div id="pwd-dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" onclick="changePass()"
				style="width:90px">确认修改</a> <a href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-cancel" onclick="javascript:$('#pwd-ff').form('resetValidation').form('reset');$('#pwd-dlg').dialog('close');" style="width:90px">取消</a>
		</div>
	</div>
	<div data-options="region:'west',split:false,border:true,title:'功能区'"
		style="width:210px;padding:10px;">
		<div id="aa" class="easyui-accordion" style="width:190px;">
			<div title="我的CRM" style="padding:10px;" selected="false" border="false">
				<c:forEach items="${rights}" var="r">
					<input type="hidden" id="${r.url}" value="${r.rName}">
					<div style="margin:10px;text-align: center">
						<a id="${r.id}" href="javascript:void(0)" class="easyui-linkbutton" plain="false"
							onclick="newTab('${r.rName}', '${r.url}')" style="width: 100px;height: 20px">${r.rName}</a>
					</div>
				</c:forEach>
			</div>
		</div>
		<div id="cc" class="easyui-calendar" style="width:190px;height:180px;margin-top: 30px"></div>
	</div>
	<div data-options="region:'south',border:false" style="height:50px;background:#F0F8FF;">
		<div align="center" style="margin-top: 20px">
			&copy;<a href="http://www.oracleoaec.net/">2016 上海海文信息技术有限公司</a>
		</div>
	</div>
	<div data-options="region:'center',border:true">
		<div id="tt" class="easyui-tabs" style="width:500px;height:250px;" fit="true"></div>
	</div>
</body>
</html>
