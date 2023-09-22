<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CarInDrive 관리자 페이지</title>
<link rel="stylesheet" type="text/css" href="./css/admin.css" />
</head>
<body>
<div id="aMain_wrap">
		<%--관리자 메인 상단 --%>
		<div id="aMain_header">
			<%--관리자 로고 --%>
			<div id="aMain_logo">
				<img src="./images/logo.jpg" />
			</div>
			<%--관리자 상단메뉴 --%>
			<div id="aMain_menu">
				<ul>
					<li><a href="admin_gongji_list">공지사항</a></li>
					<li><a href="admin_car_list">차량관리</a></li>
					<li><a href="admin_member_list">회원관리</a></li>
				</ul>
			</div>
			<%--관리자 메인 우측메뉴 --%>
			<div id="aMain_right">
				<form method="post" action="admin_logout">
					<b class="aRight_title">
						<input type="submit" value="로그아웃" />
					</b>
				</form>
			</div>
		</div>

		<div class="clear"></div>
		
		<div id="aMain_cont">
			<h2 class="aMainCont_title">관리자 메인 화면입니다.</h2>
		</div>
		
		<div class="clear"></div>

		<%--관리자 메인 하단 --%>
		<div id="aMain_footer">
			<p>&copy; 2023 CarInDrive All rights reserved.</p>
		</div>
	</div>
</body>
</html>