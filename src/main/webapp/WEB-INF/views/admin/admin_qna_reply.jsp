<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="./js/bbs.js"></script>
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
				<form method="post" action="admin_qna_reply_ok" onsubmit="return qna_reply_check();">
					<%-- 답변글 히든값 --%>
					<%-- 원본글과 답변글을 묶어주는 글 그룹번호 역할 -> bbs_ref --%>
					<input type="hidden" name="qna_replygroup" value="${q.qna_replygroup}" >
					<%-- 원본글이면 0, 첫번째 답변글이면 1, 두번째 답변글이면 2, ...
					즉 원본글과 답변글을 구분하는 번호이면서 몇번째 답변글인가를 알려줌 --%>
					<input type="hidden" name="qna_replytype" value="${q.qna_replytype}" >
					<%-- 답변글 정렬순서 --%>
					<input type="hidden" name="qna_replyindex" value="${q.qna_replyindex}" >
					<%-- 페이징 즉 쪽나누기에서 내가 본 쪽번호로 바로 이동하기 위한 책갈피 기능때문에 히든으로 쪽번호를 전달 --%>
					<input type="hidden" name="page" value="${page}" >
					<div id="Bag">
						<h2>QNA 답변</h2>
						<table id="ag_t" border="1">
							<tr>
								<th>제목</th>
								<td><input name="cq_title" id="cq_title" size="97" style="height: 32px;" value="Re:${q.cq_title}" readonly ></td>
							</tr>
							<tr>
								<th>답변</th>
								<td>
									<textarea name="cq_cont" id="cq_cont" rows="25" cols="92"></textarea>
								</td>
							</tr>
						</table>
						
						<div id="ag_button3">
							<input type="submit" value="답변">
							<input type="button" value="취소" onclick="location='admin_qna_cont?no=${q.cq_no}&page=${page}';">
							<input type="button" value="목록" onclick="location='admin_qna?page=${page}';">
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