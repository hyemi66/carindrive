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
				<li><a href="${path}/admin/admin_qna">1 대 1 문 의</a></li>
				<li><a href="${path}/admin/admin_member">회원관리</a></li>
				<li><a href="${path}/admin/admin_car_list">차량관리</a></li>
				<li><a href="${path}/admin/admin_pay">차량환불</a></li>
			</ul>
		</div>
		<article id="admin_show">
			<h1>차 량 환 불</h1>
			<div class="clear"></div>
				<form method="get" action="admin_member">
					<div id="Bag">
						<h2>
							차량 예약 목록 ( 총 개수 : 
							<c:if test="${listcount == null}">
								0개
							</c:if>
							<c:if test="${listcount != null}">
								${listcount}개
							</c:if>
							)
						</h2>
						
						<table id="ag_t2" border="1">
							<tr>
								<th width="45">번호</th>
								<th width="80">아이디</th>
								<th width="400">차종</th>
								<th width="100">결제일자</th>
								<th width="100">결제상태</th>
								<th width="80">환불처리</th>
							</tr>
							<c:if test="${!empty mlist}">
								<c:forEach var="m" items="${mlist}" varStatus="status">
									<tr>
										<td align="center">${status.count}</td>
										<td align="center">${m.buyer_name}</td>
										<td align="center">${m.product_name}</td>
										<td align="center">${fn:substring(m.buy_date,0,10)}</td>
										<td align="center">${m.refund}</td>
										<%-- 0이상 10미만 사이의 년월일 만 반환 --%>
										<td align="center">
											<c:if test="${m.refund.equals('환불완료')}">
												환불완료
											</c:if>
											<c:if test="${!m.refund.equals('환불완료')}">
												<input type="button" value="환불처리" onclick="if(confirm('${m.buyer_name}의 예약을 환불처리 하겠습니까?') == true){
												location= 'admin_pay_del?merchant_Id=${m.merchant_Id}&page=${page}';   
												}else{return;}" />
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty mlist}">
								<tr>
									<th colspan="6">목록이 없습니다!</th>
								</tr>
							</c:if>
						</table>
						
						<!-- 페이징 -->
						<div id="ag_paging2">
							<c:if test="${page<=1}">
								◁&nbsp;
							</c:if>
							<c:if test="${page>1}">
								<a href="admin_pay?page=${page-1}">◀</a>&nbsp;
							</c:if>
						
							<%--현재 쪽번호 출력--%>
							<c:forEach var="a" begin="${startpage}" end="${endpage}" step="1">
								<c:if test="${a == page}">
									<%--현재 페이지가 선택되었다면--%>
									<font style="font-weight:bold;">[${a}]</font>
								</c:if>
								<c:if test="${a != page}">
									<%--현재 페이지가 선택되지 않았다면 --%>
									<a href="admin_pay?page=${a}">[${a}]</a>&nbsp;
								</c:if>
							</c:forEach>
						
							<c:if test="${page >= maxpage}">
								▷
							</c:if>
							<c:if test="${page<maxpage}">
								<a href="admin_pay?page=${page+1}">▶</a>
							</c:if>
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