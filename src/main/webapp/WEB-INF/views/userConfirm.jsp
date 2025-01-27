<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>ユーザー情報確認画面</title>
<%Object loginUser = (Object)session.getAttribute("loginUser"); %>
<%Object logout = (Object)request.getAttribute("logout"); %>
<script type = "text/javascript">
var login = <%=loginUser!=null%>
var logout = <%=logout!=null%>
function start(){//画面表示時
	if(logout==true){
		window.alert("退会しました。");
		window.location.href="http://localhost:8080/kenfurni/item/search";
	}else if(login==false){
		window.alert("ログインしてください。");
		window.location.href="http://localhost:8080/kenfurni/item/search";
	}
}
</script>
<link rel="stylesheet" href="/kenfurni/resources/stylesheet.css">
</head>
<body onload="start()">
<jsp:include page="header.jsp"></jsp:include>
	<h1 class="title">ユーザー情報確認画面</h1>
	<form:form modelAttribute="UserConfirmModel" action="?" >
		<table>
			<tr>
				<td class="user_form">氏名</td>
				<td class="user_form">${UserConfirmModel.user_name }</td>
			</tr>
			<tr>
				<td class="user_form">メールアドレス</td>
				<td class="user_form">${UserConfirmModel.user_email }</td>
			</tr>
			<tr>
				<td class="user_form">パスワード</td>
				<td class="user_form">${UserConfirmModel.user_password }</td>
			</tr>
			<tr>
				<td class="user_form">生年月日</td>
				<td class="user_form">${UserConfirmModel.user_birth }</td>
			</tr>
			<tr>
				<td class="user_form">性別</td>
				<td class="user_form">${UserConfirmModel.user_gender }</td>
			</tr>
			<tr>
				<td class="user_form">送り先</td>
				<td class="user_form">${UserConfirmModel.user_address }</td>
			</tr>
			<tr>
				<td class="user_form">クレジットカード番号</td>
				<td class="user_form">${UserConfirmModel.user_card }</td>
			</tr>
			<tr>
				<td class="user_form">電話番号</td>
				<td class="user_form">${UserConfirmModel.user_phone }</td>
			</tr>
			<tr>
				<td class="user_form">保有ポイント</td>
				<td class="user_form">${UserConfirmModel.user_point }</td>
			</tr>
		</table>
		<div class="user_button">
			<input type="submit" value="編集" class="buttonoption" formaction="edit"/>
			<input type="submit" value="退会" class="buttonoption" onclick="return window.confirm('退会しますか？')" formaction="exit"/>
		</div>
	</form:form>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>