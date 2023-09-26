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
<script src="${path}/js/jquery.js"></script>
<script type="text/javascript" src="${path}/js/admin.js"></script>
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
			<h1>공 지 사 항</h1>
			<div class="clear"></div>
				<form method="post" action="admin_gongji_write_ok" onsubmit="return gongji_write_check();">
					<div id="Bag">
						<h2>공지사항 내용</h2>
						<table id="ag_t">
							<tr>
								<th>등록날짜</th>
								<td>${fn:substring(s.cs_date,0,10)}</td>
							</tr>
							<tr>
								<th>조회수</th>
								<td>${s.cs_hit}</td>
							</tr>
							<tr>
								<th>공지제목</th>
								<td>${s.cs_title}</td>
							</tr>
							<tr>
								<th>공지타입</th>
								<td>${s.cs_type}</td>
							</tr>
							<tr>
								<th>공지내용</th>
								<td>${cs_cont}</td>
							</tr>
						</table>
						
						<div id="ag_button3">
							<input type="button" value="목록" onclick="location='admin_main?page=${page}';" />
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