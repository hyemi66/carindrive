<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" type="text/css" href="${path}/css/main.css" />
<link rel="stylesheet" type="text/css" href="${path}/css/admin.css" />
</head>
<body>
<jsp:include page="../include/header.jsp"/>
<div class="Badmin">
	<div class="Admin">
		<div class="Admin_menu">
			<h2>관리자페이지</h2>
			<img id="admin_img" alt="관리자" src="${path}/images/admin.jpg">
			<ul>
				<li><a href="${path}/admin/admin_main">공지사항</a></li>
				<li><a href="${path}/admin/admin_car_list">차량관리</a></li>
			</ul>
		</div>
		<article id="admin_show">
			<h1>차 량 관 리</h1>
			<div class="clear"></div>
					<div id="Bag">
						<h2>차량 추가</h2>
						<table id="ag_t">
							<tr>
								<th>차량 코드</th>
								<td>${c.c_num}</td>
							</tr>
							<tr>
								<th>차량 이름</th>
								<td>${c.c_name}</td>
							</tr>
							<tr>
								<th>차량 브랜드</th>
								<td>${c.c_brand}</td>
							</tr>
							<tr>
								<th>차량 년식</th>
								<td>${c.c_year}</td>
							</tr>
							<tr>
								<th>차량 색상</th>
								<td>${c.c_color}</td>
							</tr>
							<tr>
								<th>차량 상세차종</th>
								<td>${c.c_type}</td>
							</tr>
							<tr>
								<th>차량 차종</th>
								<td>${c.c_type2}</td>
							</tr>
							<tr>
								<th>차량 기름</th>
								<td>${c.c_oil}</td>
							</tr>
							<tr>
								<th>차량 가격</th>
								<td>${c.c_price}</td>
							</tr>
							<tr>
								<th>차량 가능 여부</th>
								<td>${c.c_ok}</td>
							</tr>
							<tr>
								<th>차량 이미지</th>
								<td><img src="${path}/images/car/${c.c_img}" width="280" height="180" /></td>
							</tr>
						</table>
						
						<div id="ag_button">
							 <input type="button" value="목록" onclick="location='admin_car_list?page=${page}';" />
						</div>
					</div>
				</form>
		</article>
	</div>
</div>
<div class="clear"></div>
<jsp:include page="../include/footer.jsp"/>
</body>
</html>