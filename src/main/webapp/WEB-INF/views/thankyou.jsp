<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>感謝画面</title>
<link rel="stylesheet" href="/kenfurni/resources/Stylesheet2.css">
</head>
<script type="text/javascript">
</script>
<link rel="stylesheet" href="/kenfurni/resources/stylesheet.css">
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div class="thankyou-container">
	<h1>ご利用ありがとうございました。</h1>
	</div>
	<main>
		<div class="thankyou_button">
			<form action="../item/search">
				<input type="submit" value="お買い物を続ける" class="buttonoption">
			</form>
		</div>
	</main>
	<div class="login_footer">
	<p>©2001 KEN Furniture Factory Co., Ltd. All Rights Reserved</p>
	<p>〒399-9999 長野県安曇野市安曇野999-99</p>
	<p>TEL : 0263-99-0000(代表) FAX : 0263-99-0001</p>
</div>
</body>
</html>
