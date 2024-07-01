<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="ja">
<link rel="stylesheet" href="/kenfurni/resources/stylesheet.css">
<head>
<title>商品登録</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<h1 class="title">ラインナップ登録画面</h1>
	<div class="main_container">
		<form:form  modelAttribute="lineup" action="${pageContext.request.contextPath}/emp/regist">
		<table border="1">
			<tr>
				<td>商品名</td>
				<td><form:select path="item_id" name="state">
						<c:forEach var="result" items="${itemList}">
							<option value="${result.item_id}"><c:out value="${result.item_name}"></c:out></option>
						</c:forEach>
				</form:select></td>
			</tr>
			<tr>
				<td><label for="text">テキスト入力欄</label><br></td>
				<td><form:textarea path="sales_text" id="sb" cols="30" rows="5"
						placeholder="メッセージを入力してください"></form:textarea></td>
			</tr>
		</table>
		<input type="submit" value="登録" class="buttonoption">
		</form:form>
	</div>
<div class="login_footer">
	<p>©2001 KEN Furniture Factory Co., Ltd. All Rights Reserved</p>
	<p>〒399-9999 長野県安曇野市安曇野999-99</p>
	<p>TEL : 0263-99-0000(代表) FAX : 0263-99-0001</p>
</div>
</body>
</html>