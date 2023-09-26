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
				<form method="post" action="admin_car_write_ok" onsubmit="return car_write_check();" enctype="multipart/form-data">
					<div id="Bag">
						<h2>차량 추가</h2>
						<table id="ag_t">
							<tr>
								<th>차량 이름</th>
								<td><input name="c_name" id="c_name" size="14" /></td>
							</tr>
							<tr>
								<th>차량 브랜드</th>
								<td><input name="c_brand" id="c_brand" size="14" /></td>
							</tr>
							<tr>
								<th>차량 년식</th>
								<td><input name="c_year" id="c_year" size="14" /></td>
							</tr>
							<tr>
								<th>차량 색상</th>
								<td><input name="c_color" id="c_color" size="14" /></td>
							</tr>
							<tr>
								<th>차량 상세차종</th>
								<td><input name="c_type" id="c_type" size="14" /></td>
							</tr>
							<tr>
								<th>차량 차종</th>
								<td>
									<div>
										<select id="c_type2" name="c_type2" class="select">
											<option value="">타입선택</option>
											<option value="경형">경형</option>
											<option value="소형">소형</option>
											<option value="중형 세단">중형 세단</option>
											<option value="중형 SUV">중형 SUV</option>
											<option value="전기차">전기차</option>
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<th>차량 기름</th>
								<td><input name="c_oil" id="c_oil" size="14" /></td>
							</tr>
							<tr>
								<th>차량 가격</th>
								<td><input name="c_price" id="c_price" size="14" /></td>
							</tr>
							<tr>
								<th>차량 이미지</th>
								<td><input type="file" id="c_img" name="c_img" /></td>
							</tr>
						</table>
						
						<div id="ag_button">
							<input type="submit" value="추가" />
							<input type="reset" value="취소" onclick="$('#c_name').focus();" />
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