<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<script type="text/javascript">
	//「戻る」「進む」ボタンの無効化
	function logoutConfirm() {
		var result = window.confirm("ログアウトしてよろしいでしょうか？");
		return result;
	}
</script>
<div class="header">
	<div class="headerLogo">
		<a href="http://localhost:8080/kenfurni/item/search"><img
			src="http://localhost:8080/kenfurni/image/logo.png" width="200px"></a>
	</div>
	<div class="menu">

			<c:if test="${sessionScope.loginUser == null}">
				<a href="http://localhost:8080/kenfurni/item/search"><img
					src="http://localhost:8080/kenfurni/image/search.png" width="80px"></a>
				<a href="http://localhost:8080/kenfurni/login"><img
				src="http://localhost:8080/kenfurni/image/login.png" width="80px">
				</a>

			</c:if>
			<c:if test="${sessionScope.loginUser != null}">
				<c:choose>
					<c:when test="${not empty sessionScope.loginUser.user_name}">
						<c:out value="${sessionScope.loginUser.user_name}" />でログイン中
					</c:when>
					<c:otherwise>
						<c:out value="${sessionScope.loginUser.user_email}" />でログイン中
					</c:otherwise>
				</c:choose>
			<a href="http://localhost:8080/kenfurni/item/search"><img
					src="http://localhost:8080/kenfurni/image/search.png" width="80px"></a>
				<c:if test="${sessionScope.cartList.size() > 0}">
					<a href="http://localhost:8080/kenfurni/item/cart">
						<img src="http://localhost:8080/kenfurni/image/cartitem.png" width="80px">
					</a>
				</c:if>
				<c:if test="${sessionScope.cartList.size() < 1 || sessionScope.cartList == null}">
					<a href="http://localhost:8080/kenfurni/item/cart">
						<img src="http://localhost:8080/kenfurni/image/cart.png" width="80px"></a>
				</c:if>
					<a href="http://localhost:8080/kenfurni/user/confirm">
						<img src="http://localhost:8080/kenfurni/image/userpage.png" width="80px">
					</a>
					<a href="http://localhost:8080/kenfurni/logout" onclick="return logoutConfirm()">
						<img src="http://localhost:8080/kenfurni/image/logout.png"width="80px" >
					</a>
			</c:if>
	</div>
</div>
