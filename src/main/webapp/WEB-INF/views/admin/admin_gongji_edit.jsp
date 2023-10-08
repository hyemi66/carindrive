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
		<article id="admin_show">
			<h1>공 지 사 항</h1>
			<div class="clear"></div>
				<form method="post" action="admin_gongji_edit_ok" onsubmit="return gongji_write_check();">
				<input type="hidden" name="cs_no" value="${s.cs_no}" />
				<input type="hidden" name="page" value="${page}" />
					<div id="Bag">
						<h2>공지사항 수정</h2>
						<table id="ag_t" border="1">
							<tr>
								<th>제&nbsp;&nbsp;목</th>
								<td><input name="cs_title" id="cs_title" size="97" style="height: 32px;" value="${s.cs_title}" /></td>
							</tr>
							<tr>
								<th>타&nbsp;&nbsp;입</th>
								<td>
									<div>
									<select id="cs_type" name="cs_type" class="select">
										<option value="">타입선택</option>
										<option value="가입탈퇴">가입탈퇴</option>
										<option value="예약취소">예약취소</option>
										<option value="요금결제">요금결제</option>
										<option value="사용반납">사용반납</option>
										<option value="보험사고">보험사고</option>
										<option value="전기차">전기차</option>
										<option value="기타">기타</option>
									</select>
								</div>
								</td>
							</tr>
							<tr>
								<th>내&nbsp;&nbsp;용</th>
								<td><textarea name="cs_cont" id="cs_cont" rows="25" cols="92">${s.cs_cont}</textarea>
								</td>
							</tr>
						</table>
						
						<div id="ag_button2">
							<input type="submit" value="수정" />
							<input type="reset" value="취소" onclick="$('#cs_title').focus();" />
							<input type="button" value="목록" onclick="location='admin_main?page=${page}';" />
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