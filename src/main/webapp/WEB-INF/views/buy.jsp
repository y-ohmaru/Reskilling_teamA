<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/kenfurni/resources/stylesheet.css">
<title>購入手続き画面</title>
<script type="text/javascript">
	let fiveDaysLater; //5日後の日付(着日指定)

	//ページ読み込み時の初期処理
	window.onload = function() {
		//5日後の日付を取得
		fiveDaysLater = new Date();
		fiveDaysLater.setDate(fiveDaysLater.getDate() + 5);
		fiveDaysLater.setHours(8);
		fiveDaysLater.setMinutes(0);
		fiveDaysLater.setSeconds(0);

		//着日指定の入力フォームの規定値と初期値設定
		var y = fiveDaysLater.getFullYear();
		var m = fiveDaysLater.getMonth() +1;
		var d = fiveDaysLater.getDate();
		var today = y + "-" + m.toString().padStart(2,'0') + "-" + d.toString().padStart(2,'0');
		document.getElementById("sendTypeInput").min = today;
		document.getElementById("sendTypeInput").value = today;
    }

	//ラジオボタン操作時にテキストボックスの活性を制御
	function toggleTextBox(name, able){
		var elem = document.getElementById(name+"Input");
		if(able){
			elem.disabled = false;
		}else{
			elem.disabled = true;
		}
	}
/* ------------------------------ 入力値チェック ------------------------------ */

	//送り先
	function checkAddress() {
		//値の取得
		var address = document.getElementById("address");
		var addressError = document.getElementById("addressError");

		if(address.value == ""){
			//空文字の場合
			addressError.textContent ="必須入力です";
			return false;
		}else{
			//OKの場合
			addressError.textContent ="";
			return true;
		}
	}

	//着日指定
	function checkSendType() {
		//値の取得
		var ArrDate = document.getElementById("ArrDate"); //着日指定ラジオボタン
		var sendTypeInput = document.getElementById("sendTypeInput"); //着日の値
		var sendDateError = document.getElementById("sendDateError");//着日エラー

		var date = new Date(sendTypeInput.value); //入力値をdate型で取得

		if(!ArrDate.checked){
			//着日指定が選択されていない場合
			sendDateError.textContent ="";
			return true;
		}

		if(isNaN(date.getDate())){
			//日付形式でない場合
			sendDateError.textContent ="日付を正しく選択してください。";
			return false;
		}else if(fiveDaysLater >= date){
			//5日以降でない場合
			sendDateError.textContent ="5日以降を選択してください。";
			return false;
		}else{
			//OKの場合
			sendDateError.textContent ="";
			return true;
		}
	}

	//ポイント
	function checkPoint() {
		//要素の取得
		var inputPoint = document.getElementById("inputPoint");
		var pointError = document.getElementById("pointError");

		var result;

		//チェック後の値
		var fixedPoint;
		if(isNaN(inputPoint.value)|| inputPoint.value == ""){
			//数値でない場合
			fixedPoint = 0;
			pointError.textContent  = "数値を入力してください。";
			result = false;
		}else if(inputPoint.value > ${loginUser.user_point}){
			//所持ポイント越えの場合
			fixedPoint = ${loginUser.user_point};
			pointError.textContent  = "現在のポイント以上は使用できません";
			result = false;
		}else{
			//OKの場合
			fixedPoint = parseInt(inputPoint.value);
			pointError.textContent  = "";
			result = true;
		}

		//フォーム、カート内総計の値更新
		inputPoint.value = fixedPoint;
		document.getElementById("outputPoint").textContent = '-\xA5' + fixedPoint.toLocaleString();
		document.getElementById("outputPrice").textContent = '\xA5' + (${price} - fixedPoint+13500).toLocaleString();
		return result;
	}

	//クレジット
	function checkPay() {
		//値の取得
		var credit = document.getElementById("credit");//クレジット選択
		var payInput = document.getElementById("payInput"); //クレジットの値
		var payError = document.getElementById("payError"); //クレジットエラー

		// チェック条件パターン
		var pattern = /^[0-9]{14,16}$/;

		if(!credit.checked){
			//クレジットが選択されていない場合
			payError.textContent ="";
			return true;
		}

		if(!pattern.test(payInput.value)){
			//14-16桁の数値でない場合
			payError.textContent ="14-16桁の数値を入力してください。";
			return false;
		}else{
			//OKの場合
			payError.textContent ="";
			return true;
		}
	}

	function inputCheck(){
		var errorCount = 0;//エラーの数
		if(!checkAddress())
			errorCount++;

		if(!checkSendType())
			errorCount++;

		if(!checkPoint())
			errorCount++;

		if(!checkPay())
			errorCount++;

		//入力エラー数判定
		if(errorCount == 0){
			return window.confirm("購入を確定しますか？")
		}else{
			window.alert("正しく入力されていない項目が"+errorCount+"件あります");
			return false;
		}
	}
</script>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<h1 class="title">購入手続き画面</h1>
	<div class="buyForm">
		<form:form action="./complete" method="post" modelAttribute="orderInfoModel">
			<div class="form-wrap">
				<div class="formName">発送先情報</div>
				<div class="formInfo">
					<table>
						<tr>
							<td></td>
							<td><span class="error" id="addressError"></span></td>
						</tr>
						<tr>
							<td>送り先</td>
							<td>
								<form:input id="address" path="address" onchange="checkAddress()" />
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="form-wrap">
				<div class="formName">発送方法選択</div>
				<div class="formInfo">
					<table>
						<tr>
							<td>
								<label>
									<form:radiobutton path="sendType"
										name="sendType" label="通常配送" value="通常配送" checked="checked"
										onclick="toggleTextBox('sendType',false)" />
								</label>
							</td>
							<td></td>
						</tr>
						<tr>
							<td><label><form:radiobutton path="sendType"
										id="ArrDate" name="sendType" label="着日指定" value="着日指定"
										onclick="toggleTextBox('sendType',true)" /></label></td>
							<td>
								<form:input path="sendDate" type="date" id="sendTypeInput" disabled="true" onchange="checkSendType()"/>
								<span class="error" id="sendDateError"></span>
							</td>
						</tr>
						<tr>
							<td></td>
							<td>※本日より5日以降が選択できます。</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="form-wrap">
				<div class="formName">ポイント</div>
				<div class="formInfo">
					<table>
						<tr>
							<td>現在のポイント</td>
							<td><c:out value="${loginUser.user_point}" /></td>
						</tr>
						<tr>
							<td></td>
							<td><span class="error" id="pointError"></span></td>
						</tr>
						<tr>
							<td>使用するポイント</td>
							<td>
								<form:input path="usedPoint" value="0" id="inputPoint" onchange="checkPoint()" />
							</td>
						</tr>
						<tr>
							<td></td>
							<td>※使用しない場合は0を入力してください。</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="form-wrap">
				<div class="formName">支払方法選択</div>
				<div class="formInfo">
					<table>
						<tr>
							<td><label><form:radiobutton path="pay" name="pay"
										label="代金引換" value="代金引換" checked="checked"
										onclick="toggleTextBox('pay',false)" /></label></td>
							<td></td>
						</tr>
						<tr>
							<td><label><form:radiobutton path="pay" name="pay"
										id="credit" label="クレジットカード" value="クレジットカード"
										onclick="toggleTextBox('pay',true)" /></label></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td><span class="error" id="payError" ></span></td>
						</tr>
						<tr>
							<td>カード番号</td>
							<td><form:input id="payInput" path="cardNo" disabled="true" onchange="checkPay()"/></td>
						</tr>
					</table>
				</div>
			</div>
			<input type="submit" value="注文確定" class="buttonoption" onclick="return inputCheck()">
		</form:form>
	</div>
	<div class="buyCart">
		<h2>カート内総計</h2>
		<table>
			<c:forEach varStatus="status" var="cart"
				items="${sessionScope.cartList}">
				<tr>
					<td><c:out value="${cart.item.item_name}" /></td>
					<td><c:out value="${cart.count}" />個</td>
					<td style="text-align: right">
						<span id="subtotal${status.index}"></span>
						<script>
							var price = ${cart.item.item_price * cart.count};
							document.getElementById("subtotal"+${status.index}).textContent = '\xA5' + price.toLocaleString();
						</script>
					</td>
				</tr>

			</c:forEach>
			<tr>
				<td></td>
				<td>送料</td>
				<td style="text-align: right">\13,500</td>
			</tr>
			<tr>
				<td></td>
				<td>ポイント</td>
				<td style="text-align: right">
					<span id="outputPoint">-\0</span>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>支払総額</td>
				<td style="text-align: right">
					<span id="outputPrice"></span>
					<script>
						var price = ${price + 13500};
						document.getElementById("outputPrice").textContent = '\xA5' + price.toLocaleString();
					</script>
				</td>
			</tr>
		</table>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>