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
				<form method="get" action="admin_main">
					<div id="Bag">
						<h2>
							공지사항 목록 ( 총 개수 : 
							<c:if test="${listcount == null}">
								0개
							</c:if>
							<c:if test="${listcount != null}">
								${listcount}개
							</c:if>
							)
						</h2>
						
						<%--검색 폼추가 --%>
						<div id="ag_button">
							<select name="find_field">
								<option value="cs_title"
									<c:if test="${find_field=='cs_title'}">
									${'selected'}</c:if>>제목
								</option>
								<option value="cs_cont"
									<c:if test="${find_field=='cs_cont'}">
									${'selected'}</c:if>>내용
								</option>
							</select>
							<input type="search" name="find_name" id="find_name" size="14" value="${find_name}" />
							<input type="submit" value="검색" />
							<c:if test="${(!empty find_field) && (!empty find_name)}">
								<input type="button" value="전체목록" onclick="location='admin_main?page=${page}';" />
							</c:if>
							<input type="button" id="plus" value="공지추가" onclick="location='admin_gongji_write?page=${page}';" />
						</div>
						
						<table id="ag_t2" border="1">
							<tr>
								<th width="45">번호</th>
								<th width="100">타입</th>
								<th width="370">제목</th>
								<th width="100">작성일</th>
								<th width="120">수정/삭제</th>
							</tr>
							<c:if test="${!empty glist}">
								<c:forEach var="g" items="${glist}"  varStatus="status">
									<tr>
										<td align="center">${g.cs_no}</td>
										<td align="center">${g.cs_type}</td>
										<td align="center">
											<a href="admin_gongji_cont?no=${g.cs_no}&page=${page}&state=cont">
												<c:if test="${fn:length(g.cs_title)>16}">
													${fn:substring(g.cs_title,0,16)}...
												</c:if>
												<c:if test="${fn:length(g.cs_title)<=16}">
													${g.cs_title}
												</c:if>
											</a>
										</td>
										<td align="center">${fn:substring(g.cs_date,0,10)}</td>
										<%-- 0이상 10미만 사이의 년월일 만 반환 --%>
										<td align="center">
											<input type="button" value="수정" onclick="location='admin_gongji_cont?no=${g.cs_no}&page=${page}&state=edit';" />
											/
											<input type="button" value="삭제" onclick="if(confirm('정말로 삭제할까요?') == true){
											location= 'admin_gongji_del?no=${g.cs_no}&page=${page}';   
											}else{return;}" />
										</td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty glist}">
								<tr>
									<th colspan="6">목록이 없습니다!</th>
								</tr>
							</c:if>
						</table>
						
						<%--페이징 즉 쪽나누기 추가 --%>
						<div id="ag_paging">
							<%-- 검색전 페이징 --%>
							<c:if test="${(empty find_field) && (empty find_name)}">
								<c:if test="${page<=1}">
									◁&nbsp;
								</c:if>
								<c:if test="${page>1}">
									<a href="admin_main?page=${page-1}">◀</a>&nbsp;
								</c:if>
							
								<%--현재 쪽번호 출력--%>
								<c:forEach var="a" begin="${startpage}" end="${endpage}" step="1">
									<c:if test="${a == page}">
										<%--현재 페이지가 선택되었다면--%>
										<font style="font-weight:bold;">[${a}]</font>
									</c:if>
									<c:if test="${a != page}">
										<%--현재 페이지가 선택되지 않았다면 --%>
										<a href="admin_main?page=${a}">[${a}]</a>&nbsp;
									</c:if>
								</c:forEach>
							
								<c:if test="${page >= maxpage}">
									▷
								</c:if>
								<c:if test="${page<maxpage}">
									<a href="admin_main?page=${page+1}">▶</a>
								</c:if>
							</c:if>
							
							<%-- 검색후 페이징 --%>
							<c:if test="${(!empty find_field) || (!empty find_name)}">
								<c:if test="${page<=1}">
									[이전]&nbsp;
								</c:if>
								<c:if test="${page>1}">
									<a href="admin_main?page=${page-1}&find_field=${find_field}&find_name=${find_name}">[이전]</a>&nbsp;
								</c:if>
							
								<%--현재 쪽번호 출력--%>
								<c:forEach var="a" begin="${startpage}" end="${endpage}" step="1">
									<c:if test="${a == page}">
										<%--현재 페이지가 선택되었다면--%>
										<${a}>
									</c:if>
									<c:if test="${a != page}">
										<%--현재 페이지가 선택되지 않았다면 --%>
										<a href="admin_main?page=${a}&find_field=${find_field}&find_name=${find_name}">[${a}]</a>&nbsp;
									</c:if>
								</c:forEach>
							
								<c:if test="${page >= maxpage}">
									[다음]
								</c:if>
								<c:if test="${page<maxpage}">
									<a href="admin_main?page=${page+1}&find_field=${find_field}&find_name=${find_name}">[다음]</a>
								</c:if>
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