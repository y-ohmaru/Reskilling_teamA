<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>ユーザー情報編集画面</title>
<script type = "text/javascript">
var elements = document.getElementsByName("gender");
var gender ='<%=request.getAttribute("gender")%>';
var sucsess_edit = '<%=session.getAttribute("sucsess_edit")%>';
function start(){
	var test = <%=session.getAttribute("sucsess_edit")%>===true;
	if(test===true){
		window.alert("ユーザー情報の編集が完了しました。");
		window.location.href="http://localhost:8080/kenfurni/user/confirm";
	}
	for(var i =0;i<elements.length;i++){
		if(elements.item(i).value==gender){
			elements.item(i).checked==true;
		}
	}
}
function sousin(){//確認ダイアログを表示
	if(window.confirm("登録しますか？")){
		return true;
	}else{
		return false;
	}
}
</script>
<link rel="stylesheet" href="/kenfurni/resources/stylesheet.css">
</head>
<body  onload="start()">
<jsp:include page="header.jsp"></jsp:include>
	<h1 class="title">ユーザー情報編集画面</h1>
	<form:form modelAttribute="UserConfirmModel" action="./editComplete" onsubmit="return sousin()">
		<table>
			<tr>
				<td class="user_form">氏名</td>
				<td><form:input path="user_name" value="${UserConfirmModel.user_name }" class="user_form"/></td>
			</tr>
			<tr>
				<td class="user_form">メールアドレス<span class="font_caution">（必須）</span></td>
				<td>
					<form:input path="user_email" value="${UserConfirmModel.user_email }" class="user_form"/>
					<form:errors path="user_email" class="user_formError" element="span" />
				</td>
			</tr>
			<tr>
				<td class="user_form">パスワード<span class="font_caution">（必須）</span></td>
				<td>
					<form:password path="user_password" value="${UserConfirmModel.user_password }" class="user_form"/>
					<form:errors path="user_password" class="user_formError" element="span" />
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td class="user_form">6文字以上10文字以下の数字・アルファベットの<br>小文字を含むものを入力してください</td>
			</tr>
			<tr>
				<td class="user_form">生年月日</td>
				<td>
					<form:input type="date" value="${UserConfirmModel.user_birth }" path="user_birth" class="user_form"/>
					<form:errors path="user_birth" element="span" class="user_formError"/>
				</td>
			</tr>
			<tr>
				<td class="user_form">性別</td>
				<td class="user_form">
					<form:radiobutton path="user_gender" label="男性" value="男性" name="gender"/>
					<form:radiobutton path="user_gender" label="女性" value="女性" name="gender"/>
				</td>
			</tr>
			<tr>
				<td class="user_form">送り先</td>
				<td><form:input path="user_address" value="${UserConfirmModel.user_address }" class="user_form"/></td>
			</tr>
			<tr>
				<td class="user_form">クレジットカード<br>(ハイフンなし)</td>
				<td>
					<form:input path="user_card" value="${UserConfirmModel.user_card }" class="user_form"/>
					<form:errors path="user_card" element="span" class="user_formError"/>
				</td>
			</tr>
			<tr>
				<td class="user_form">電話番号<br>(ハイフンなし)</td>
				<td>
					<form:input path="user_phone" value="${UserConfirmModel.user_phone }" class="user_form"/>
					<form:errors path="user_phone" element="span" class="user_formError"/>
				</td>
			</tr>
		</table>
		<div class="user_button">
			<input type="submit" value="登録" class="buttonoption"/>
		</div>
		</form:form>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>