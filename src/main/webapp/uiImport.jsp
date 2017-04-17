<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<script type="text/javascript" src="ui/jquery.min.js"></script>
<script type="text/javascript" src="ui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="ui/jquery.edatagrid.js"></script>
<script type="text/javascript" src="ui/datagrid-cellediting.js"></script>
<script type="text/javascript" src="js/sha1.js"></script>
<script type="text/javascript" src="js/easyui-validatebox.js"></script>
<!-- 本地化语言包 -->
<script type="text/javascript" src="ui/locale/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet" type="text/css"
	href="ui/themes/bootstrap/easyui.css">
<link rel="stylesheet" type="text/css" href="ui/themes/icon.css">
  

