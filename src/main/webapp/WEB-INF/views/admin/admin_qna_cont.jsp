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
				<form method="get">
					<div id="Bag">
						<h2>QNA 내용</h2>
						<table id="ag_t" border="1">
							<tr>
								<th>등록날짜</th>
								<td><p>${fn:substring(q.cq_date,0,10)}</p></td>
							</tr>
							<tr>
								<th>제목</th>
								<td><p>${q.cq_title}</p></td>
							</tr>
							<tr>
								<th>작성자</th>
								<td><p>${q.cq_id}</p></td>
							</tr>
							<tr>
								<th>내용</th>
								<td id="ag_cont"><p>${cq_cont}</p></td>
							</tr>
							<c:forEach var="i" items="${qlist}">
								<c:if test="${i.qna_replytype != 0}">
									<tr>
										<th rowspan="2">답변</th>
										<td>
											<p>
												${i.cq_cont}
											</p>
										</td>
									</tr>
									<tr>
										<td>
											&nbsp;
											<input type="button" value="수정" onclick="location='admin_qna_reply_edit?no=${i.cq_no}&page=${page}';" />
											/
											<input type="button" value="삭제" onclick="if(confirm('정말로 삭제할까요?') == true){
											location= 'admin_qna_reply_del?no=${i.cq_no}&page=${page}';   
											}else{return;}" />
										</td>
									</tr>
								</c:if>
							</c:forEach>
						</table>
						<div id="ag_button3">
							<input type="button" value="답변달기" onclick="location='admin_qna_reply?no=${q.cq_no}&page=${page}';" />
							<input type="button" value="목록" onclick="location='admin_qna?page=${page}';" />
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