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
		<article id="admin_show">
			<h1>공 지 사 항</h1>
			<div class="clear"></div>
				<form method="get" action="admin_qna">
					<div id="Bag">
						
						<h2>
							1대1 문의 목록 ( 총 개수 : 
							<c:if test="${listcount == null}">
								0개
							</c:if>
							<c:if test="${listcount != null}">
								${listcount}개
							</c:if>
							,
							<c:set var="count" value="0" />
							<c:forEach var="i" items="${qlist}" varStatus="status">
								<c:if test="${i.qna_replytype != 0}">
									<c:set var="count" value="${count + 1}" />
								</c:if>
							</c:forEach>
							답변 : ${count}개 )
						</h2>
						
						<table id="ag_t" border="1">
							<tr>
								<th>번호</th>
								<th>작성자</th>
								<th>제목</th>
								<th>작성일</th>
							</tr>
							<c:if test="${!empty qlist}">
								<c:forEach var="q" items="${qlist}" varStatus="status">
									<c:if test="${q.qna_replytype == 0}">
										<tr>
										<td align="center">${status.count}</td>
										<td align="center">${q.cq_id}</td>
										<td align="center">
											<a href="admin_qna_cont?no=${q.cq_no}&page=${page}">
												<c:if test="${fn:length(q.cq_title)>16}">
													${fn:substring(q.cq_title,0,16)}...
												</c:if>
												<c:if test="${fn:length(q.cq_title)<16}">
													${q.cq_title}
												</c:if>
											</a>
										</td>
										<td align="center">${fn:substring(q.cq_date,0,10)}</td>
									</tr>
									</c:if>
									
								</c:forEach>
							</c:if>
							<c:if test="${empty qlist}">
								<tr>
									<th colspan="6">목록이 없습니다!</th>
								</tr>
							</c:if>
						</table>
						
						<!-- 페이징 -->
						<div id="ag_paging">
							<c:if test="${page<=1}">
								◁&nbsp;
							</c:if>
							<c:if test="${page>1}">
								<a href="admin_qna?page=${page-1}">◀</a>&nbsp;
							</c:if>
						
							<%--현재 쪽번호 출력--%>
							<c:forEach var="a" begin="${startpage}" end="${endpage}" step="1">
								<c:if test="${a == page}">
									<%--현재 페이지가 선택되었다면--%>
									<font style="font-weight:bold;">[${a}]</font>
								</c:if>
								<c:if test="${a != page}">
									<%--현재 페이지가 선택되지 않았다면 --%>
									<a href="admin__qna?page=${a}">[${a}]</a>&nbsp;
								</c:if>
							</c:forEach>
						
							<c:if test="${page >= maxpage}">
								▷
							</c:if>
							<c:if test="${page<maxpage}">
								<a href="admin__qna?page=${page+1}">▶</a>
							</c:if>
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