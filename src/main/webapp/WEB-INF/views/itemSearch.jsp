<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>商品検索画面</title>
<script type="text/javascript">

        function checkLogin() {
            <c:if test="${empty loginUser}">
                alert("カートに商品を追加するにはログインが必要です。");
                window.location.href = "${pageContext.request.contextPath}/login";
                return false;
            </c:if>
            alert("カートに追加しました");
            return true;
        }
    </script>
<link rel="stylesheet" href="/kenfurni/resources/stylesheet.css">
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<h1 class="title">商品検索画面</h1>
	<div class="search_container">
		<div class="wrap">
			<form:form modelAttribute="item">
				<form:input path="item_name" />
				<input type="submit" name="search" value="検索" />
				<div>
					<c:out value="${message}" />
				</div>
			</form:form>

			<p></p>
			<table border="1">
				<c:forEach varStatus="status" var="result" items="${searchResult}">
					<tr>
						<form:form modelAttribute="item" action="./detail">
							<td rowspan="2" class="search_tdoption">
								<input type="image" src="http://localhost:8080/kenfurni/image/${result.item_png }" width="200px" alt="商品画像">
							</td>
							<td colspan="3">
								<form:hidden path="item_id" value="${result.item_id}" />
								<a class="btn-border-bottom"><input type="submit" name="search" value="${result.item_name }" class="button_off"/></a>
							</td>
						</form:form>
					</tr>
					<tr>
						<td width="30%">値段：
							<span id="price${status.index}"></span>
							<script>
								var price = ${result.item_price};
								document.getElementById("price"+${status.index}).textContent = price.toLocaleString();
							</script>
						</td>
						<form:form modelAttribute="item" action="${pageContext.request.contextPath}/item/addSearch" onsubmit="return checkLogin();">
							<form:hidden path="item_id" value="${result.item_id}" />
							<td width="200">数量：
								<c:if test="${result.item_stock == 0}">
	        						在庫0
	    						</c:if>
	    						<c:if test="${result.item_stock > 0}">
									<select name="count">
										<c:forEach varStatus="status" begin="1" end="${result.item_stock}">
											<option value="${status.count}">${status.count}</option>
										</c:forEach>
									</select>
								</c:if>
							</td>
							<td>
								<c:if test="${result.item_stock == 0}">
									<input type="submit" disabled value="カートに入れる" class="add-to-cart">
								</c:if>
								<c:if test="${result.item_stock > 0}">
									<input type="submit" value="カートに入れる"class="add-to-cart">
								</c:if>
							</td>
						</form:form>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	<div class="search_lineup">
		<h2>ラインナップ</h2>
				<table>
			<c:forEach var="lineup" items="${lineupList}">
				<tr>
					<form:form modelAttribute="item" action="./detail">
						<td>
							<input type="image" src="http://localhost:8080/kenfurni/image/${lineup.lineup_image}" width="200px" alt="ラインナップ画像">
							<form:hidden path="item_id" value="${lineup.item_id}" />
						</td>
					</form:form>
				</tr>
				<tr>
					<td><c:out value="${lineup.sales_text }"></c:out></td>
				</tr>
			</c:forEach>
				</table>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
