<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/kenfurni/resources/stylesheet.css">
<title>商品詳細画面</title>
<script type="text/javascript">
function intax(value, tax){
	return Math.ceil(value * tax);
}
function checkLogin() {
    <c:if test="${empty loginUser}">
        alert("カートに商品を追加するにはログインが必要です。");
        window.location.href = "${pageContext.request.contextPath}/login";
        return false;
    </c:if>
    alert('商品がカートに追加されました！！！');
    return true;
}
</script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
	<h1 class="title">商品詳細画面</h1>
	<main>
	<div class="detail_option1">
		<table >
			<tr>
				<td colspan="4" class="detail_fontoption1"><c:out value="${item.item_name }" /></td>
				<td rowspan="3"><img src="http://localhost:8080/kenfurni/image/${item.item_png }" width="80%" alt="商品画像" class="detail_option3"></td>
			</tr>
			<tr>
				<td colspan="3" class="detail_fontoption2"><c:out value="${item.item_detail }" /></td>
			</tr>
			<tr>
				<td>
					<form:form modelAttribute="item" action="${pageContext.request.contextPath}/item/addDetail"
						 onsubmit="return checkLogin();">
                        <form:hidden path="item_id" value="${item.item_id}" />
                        数量：
                        <c:if test="${item.item_stock == 0}">
                        在庫0
                         <input type="submit" disabled value="カートに入れる" class="add-to-cart">
                        </c:if>
                        <c:if test="${item.item_stock > 0}">
                        <select name="count">
                            <c:forEach varStatus="status" begin="1" end="${item.item_stock}">
                                <option value="${status.count}">${status.count}</option>
                            </c:forEach>
                        </select>
                        <input type="submit" value="カートに入れる" class="add-to-cart">
                        </c:if>
                    </form:form>
				</td>
				<td>
					単価：<span id="price"></span>円　(税抜)
							<script>
								var price = ${item.item_price};
								document.getElementById("price").textContent = price.toLocaleString();
							</script>
				</td>
			</tr>
		</table>
	</div>
	<div class="detail_option4">
		<table class="detail_option3">
			<tr>
				<td><a href="./search"><input type="button" value="検索画面へ戻る" class="buttonoption"></a></td>
			</tr>
		</table>
	</div>
	</main>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
