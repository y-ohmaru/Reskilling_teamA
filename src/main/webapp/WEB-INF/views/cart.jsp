<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>ショッピングカート</title>
</head>
<script type="text/javascript">
function selectChange(index){

    var changeId = "change_" + index;
    var selectedValue = document.getElementById("area_" + index).value;
    document.getElementById(changeId).submit();
    alert("数量を変更しました");
	}
function itemDelete(){
	confirm("カートから削除しました")
}
</script>
<link rel="stylesheet" href="/kenfurni/resources/stylesheet.css">
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<h1 class="title">ショッピングカート</h1>
	<main>
		<div>
			<c:if test="${fn:length(sessionScope.cartList) == 0}">
				<c:out value="カートに商品が入っていません" />
			</c:if>
		</div>
		<c:forEach var="cart" items="${sessionScope.cartList}" varStatus="status">
			<div class="cart_option2">
				<table border="1" class="cart_option1">
					<tr>
						<td rowspan="2">
							<c:out value="${status.index+1}" />
						</td>
						<td rowspan="2">
							<form:form modelAttribute="item" action="./detail">
							<input type="image" name="search" value="${cart.item.item_id }"
								src="http://localhost:8080/kenfurni/image/${cart.item.item_png}" alt="商品画像" height=200 width=200 />
									<form:hidden path="item_id" value="${cart.item.item_id}" />
								</form:form>
						</td>
						<td colspan="2" class="cart_option4">
							<form:form modelAttribute="item" action="./detail">
							<a class="btn-border-bottom"><input type="submit" value="${cart.item.item_name}"  class="button_off"/></a>
									<form:hidden path="item_id" value="${cart.item.item_id}" />
								</form:form>
						</td>
						<td>
							<form:form modelAttribute="item" action="${pageContext.request.contextPath}/buy/delete" method="post">
						<input type="submit" value="削除" class="buttonoption" onclick="itemDelete()">
								<form:hidden path="item_id" value="${cart.item.item_id}" />
							</form:form>
						</td>
					</tr>
					<tr>
						<td>
							値段:
						<span id="price${status.index}"></span>
							<script>
								var price = ${cart.item.item_price};
							document.getElementById("price"+${status.index}).textContent = price.toLocaleString();
							</script>
						</td>
						<td>
					 		<p>現在の数量：<span id="current_count_${status.index}">${cart.count}</span></p>
						</td>
						<td>
							<form:form  modelAttribute="item" id="change_${status.index}" action="${pageContext.request.contextPath}/buy/change" method="post">
								<form:hidden path="item_id" value="${cart.item.item_id}" />
								<select name="count" id="area_${status.index}" onchange="selectChange(${status.index})">
									<c:forEach varStatus="inStatus" begin="1" end="${cart.item.item_stock}">
										<option value="${inStatus.count}">${inStatus.count}</option>
									</c:forEach>
								</select>
								<script type="text/javascript">
									document.getElementById("area_"+${status.index}).value = ${cart.count};
								</script>
							</form:form>
						</td>
					</tr>
				</table>
			</div>
		</c:forEach>
		<div>
			<table class="cart_option3">
				<tr>
					<td><a href="http://localhost:8080/kenfurni/item/search"><button class="buttonoption">商品検索画面に戻る</button></a></td>
				</tr>
				<tr>
					<td>
					 <c:if test="${fn:length(sessionScope.cartList) == 0}">
							<form action="../buy/procedure" method="post">
							<input type="submit" disabled value="購入手続きへ進む" class="buttonoption">
							</form>
					</c:if>
					  <c:if test="${fn:length(sessionScope.cartList) > 0}">
							<form action="../buy/procedure" method="post">
								<input type="submit" value="購入手続きへ進む" class="buttonoption">
							</form>
					</c:if>
					</td>
				</tr>
			</table>
		</div>
	</main>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
