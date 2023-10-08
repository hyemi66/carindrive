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
<div class="CARBig">
<jsp:include page="../include/header.jsp"/>
</div>
<div class="CARBig">
<div class="Badmin">
	<div class="Admin">
		<div class="Admin_menu">
			<h2>관리자페이지</h2>
			<img id="admin_img" alt="관리자" src="${path}/images/admin.jpg">
			<ul>
				<li><a href="${path}/admin/admin_main">공지사항</a></li>
				<li><a href="${path}/admin/admin_qna">1 대 1 문 의</a></li>
				<li><a href="${path}/admin/admin_member">회원관리</a></li>
				<li><a href="${path}/admin/admin_car_list">차량관리</a></li>
				<li><a href="${path}/admin/admin_pay">차량환불</a></li>
			</ul>
		</div>
		<article id="admin_show2">
			<h1>차 량 관 리</h1>
			<div class="clear"></div>
					<div id="Bag2">
						<h2>차량 상세정보</h2>
						<table id="ag_t" border="1">
							<tr>
								<th>코드번호</th>
								<td><p>${c.c_num}</p></td>
							</tr>
							<tr>
								<th>이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름</th>
								<td><p>${c.c_name}</p></td>
							</tr>
							<tr>
								<th>브&nbsp;랜&nbsp;드</th>
								<td><p>${c.c_brand}</p></td>
							</tr>
							<tr>
								<th>년&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;식</th>
								<td><p>${c.c_year}</p></td>
							</tr>
							<tr>
								<th>색&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;상</th>
								<td><p>${c.c_color}</p></td>
							</tr>
							<tr>
								<th>차&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;종</th>
								<td><p>${c.c_type2}(${c.c_type})</p></td>
							</tr>
							<tr>
								<th>기&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름</th>
								<td><p>${c.c_oil}</p></td>
							</tr>
							<tr>
								<th>가&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;격</th>
								<td><p>${c.c_price}</p></td>
							</tr>
							<tr>
								<th>이&nbsp;미&nbsp;지</th>
								<td><img src="${path}/images/car/${c.c_img}" width="600" height="230" /></td>
							</tr>
						</table>
						
						<div id="ag_button3">
							 <input type="button" value="목록" onclick="location='admin_car_list?page=${page}';" />
						</div>
					</div>
				</form>
		</article>
	</div>
</div>
<div class="clear"></div>
</div>
<div class="CARBig">
<jsp:include page="../include/footer.jsp"/>
</div>
</body>
</html>