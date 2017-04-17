<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>oracleoaec客户关系管理系统</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<jsp:include page="uiImport.jsp"></jsp:include>
</head>
<body class="easyui-layout">
	<div data-options="region:'north',border:false" style="height:80px;background:#FFFFFF;padding:10px">
		<div align="center"  style="padding-top: 10px">
			<img src="images/oracle.png">
		</div>
	</div>
	<div data-options="region:'south',border:false"
		style="height:50px;background:#FFFFFF;padding:10px;">
		<div align="center" style="margin-top: 10px">
			&copy;<a href="http://www.oracleoaec.net/">2016 上海海文信息技术有限公司</a>
		</div>
	</div>
	<div data-options="region:'center'" style="background-image:url('images/backgroud.png');padding-top: 10%">
		<div align="center">
			<div class="easyui-panel" style="width:100%;max-width:600px;">
				<div style="float: left;margin-left: 40px;margin-top:30px;margin-bottom: 30px">
					<img src="images/logo.png">
				</div>
				<div style="float: left;margin: 40px 10px;padding-left: 40px;">
					<h2 align="center">用户登陆</h2>
					<form id="ff" method="post">
						<div style="margin-bottom:20px">
							<label for="username" class="label-top">用户名:</label> <input id="username" style="width: 180px"
								class="easyui-textbox"
								data-options="required:true,iconCls:'icon-man',iconWidth:38,prompt:'用户名...',validType:'email',validateOnCreate:false,validateOnBlur:true,invalidMessage:'请输入有效用户名',invalidMessage:'用户名无效!'">
						</div>
						<div style="margin-bottom:20px">
							<label for="pass" class="label-top">密&nbsp;码:</label> <input id="pass" name="pass" style="width: 180px"
								class="easyui-textbox" type="password"
								data-options="required:true,iconCls:'icon-lock',iconWidth:38,validType:'length[6,16]',validateOnCreate:false,validateOnBlur:true">
							<a href="javascript:$('#forgot-dlg').dialog('open')">忘记密码?</a>
						</div>
					</form>
					<div style="text-align:center;padding:5px 35px">
						<a href="javascript:void(0)" class="easyui-linkbutton" onclick="login()"
							style="width:80px">登陆</a> <a href="javascript:void(0)" class="easyui-linkbutton"
							onclick="javascript:$('#ff').form('resetValidation').form('reset')" style="width:80px">重置</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="forgot-dlg" class="easyui-dialog" style="width:400px" closed="true" title="忘记密码"
		buttons="#forgot-dlg-buttons" closable="false">
		<form id="forgot-ff" method="post" style="margin-left: 20px">
			<div>
				<p>
					<label for="username" class="label-top">用户名:</label> <input class="easyui-validatebox"
						data-options="missingMessage:'请输入用户名!',tipPosition:'bottom',required:true,validateOnCreate:false,validateOnBlur:true,validType:['email','length[4,20]']"
						invalidMessage="用户名无效!请重新输入!"  id="username"
						name="username" style="width: 200px" />
				</p>
			</div>
			<div>
				<p>
					<label for="phoneNo" class="label-top">手机号:</label> <input class="easyui-validatebox"
						data-options="missingMessage:'请输入手机号!',tipPosition:'bottom',required:true,validateOnCreate:false,validateOnBlur:true,validType:'mobile'"
						id="phoneNo" name="phoneNo" style="width: 200px" />
				</p>
			</div>
		</form>
	</div>
	<div id="forgot-dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="reqResetPass()"
			style="width:90px">确认</a> <a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel"
			onclick="javascript:$('#forgot-ff').form('resetValidation').form('reset');$('#forgot-dlg').dialog('close');"
			style="width:90px">取消</a>
	</div>
</body>

<script type="text/javascript">
	
	
	function login(){
		
		var pwd=$("#pass").val();
			pwd=hex_sha1(pwd);
			
			
		$.post('login.do',{username:$('#username').val(),pass:pwd},function(data){
			
			if(data=="1"){
				window.location.href="main.jsp";
			}else{
				$.messager.alert('error','用户名和密码不匹配请确认!','error');

			}
		})
		
	}
	
	
	
	
	
	
	function reqResetPass(){
		
		$('#forgot-ff').form('submit', {
			url : "reqResetPass.do",
			success : function(data) {
				if (data == 1) {
					//重置验证
					$('#forgot-ff').form('resetValidation');
					//表单重置
					$('#forgot-ff').form('reset');
					//关闭对话框
					$('#forgot-dlg').dialog('close')
					$.messager.alert('OK', '重置密码请求已发出,请等待管理员处理!', 'info');

				}
			}
		});
		
	}
	
	
	
	
	
	
	
</script>
</html>
