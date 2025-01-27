<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>ログイン画面</title>
<script type = "text/javascript">
function login_check(){//確認ダイアログを表示
	if(<%=request.getAttribute("already_login")%>===true){
		window.alert("既にログイン済です。");
		window.location.href="http://localhost:8080/kenfurni/item/search";
	}
}
</script>
<link rel="stylesheet" href="/kenfurni/resources/stylesheet.css">
</head>
<body onload="login_check()">
<jsp:include page="header.jsp"></jsp:include>
	<h1 class="title">ログイン画面</h1>
	<form:form modelAttribute="loginModel">

			<div class="error title"><c:out value="${message}" /></div>

			<table class="center">
			<tr>
				<td>メールアドレス</td>
				<td><form:input path="user_email" />　<form:errors path="user_email" elements="label" cssClass="error"/></td>
			</tr>

			<tr>
				<td>パスワード</td>
				<td><form:password path="user_password" />　<form:errors path="user_password" elements="label" cssClass="error"/></td>

			</tr>
			</table>
			<table class="center">
			<tr>
				<td colspan="2" ><a href="http://localhost:8080/kenfurni/user/regist">新規会員登録の方はこちら</a></td>
				<td colspan="2" ><input type="submit" value="ログイン" class="buttonoption"/></td>
			</tr>
		</table>
	</form:form>
<div class="login_footer">
	<p>©2001 KEN Furniture Factory Co., Ltd. All Rights Reserved</p>
	<p>〒399-9999 長野県安曇野市安曇野999-99</p>
	<p>TEL : 0263-99-0000(代表) FAX : 0263-99-0001</p>
</div>
</body>
</html>