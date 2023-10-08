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
			<h1>차 량 관 리</h1>
			<div class="clear"></div>
				<form method="get" action="admin_car_list">
					<div id="Bag">
						<h2>
							등록차량 목록 ( 총 개수 : 
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
								<option value="c_type2"
									<c:if test="${find_field=='c_type2'}">
									${'selected'}</c:if>>차종
								</option>
								<option value="c_brand"
									<c:if test="${find_field=='c_brand'}">
									${'selected'}</c:if>>브랜드
								</option>
							</select>
							<input type="search" name="find_name" id="find_name" size="14" value="${find_name}" />
							<input type="submit" value="검색" />
							<c:if test="${(!empty find_field) && (!empty find_name)}">
								<input type="button" value="전체목록" onclick="location='admin_car_list?page=${page}';" />
							</c:if>
							<input type="button" id="plus2" value="차량추가" onclick="location='admin_car_write?page=${page}';" />
						</div>
						
						<table id="ag_t2" border="1">
							<tr>
								<th width="45">번호</th>
								<th width="155">이름</th>
								<th width="80">브랜드</th>
								<th width="73">년식</th>
								<th width="73">색상</th>
								<th width="105">차종</th>
								<th width="155">연료</th>										
								<th width="110">수정/삭제</th>
							</tr>
							<c:if test="${!empty clist}">
								<c:forEach var="c" items="${clist}" varStatus="status">
									<tr>
										<td align="center">${c.c_num}</td>
										<td align="center">
											<a href="admin_car_cont?no=${c.c_num}&page=${page}&state=cont">
												${c.c_name}
											</a>
										</td>
										<td align="center">${c.c_brand}</td>
										<td align="center">${c.c_year}</td>
										<td align="center">${c.c_color}</td>
										<td align="center">${c.c_type}</td>
										<td align="center">${c.c_oil}</td>
										<td align="center">
											<input type="button" value="수정" onclick="location= 'admin_car_cont?no=${c.c_num}&page=${page}&state=edit';" />
											/
											<input type="button" value="삭제"
												onclick="if(confirm('정말로 삭제할까요?') == true){ location='admin_car_del?no=${c.c_num}&page=${page}';   
											}else{ return ;}" />
										</td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty clist}">
								<tr>
									<th colspan="9">목록이 없습니다!</th>
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
									<a href="admin_car_list?page=${page-1}">◀</a>&nbsp;
								</c:if>
							
								<%--현재 쪽번호 출력--%>
								<c:forEach var="a" begin="${startpage}" end="${endpage}" step="1">
									<c:if test="${a == page}">
										<%--현재 페이지가 선택되었다면--%>
										<font style="font-weight:bold;">[${a}]</font>
									</c:if>
									<c:if test="${a != page}">
										<%--현재 페이지가 선택되지 않았다면 --%>
										<a href="admin_car_list?page=${a}">[${a}]</a>&nbsp;
									</c:if>
								</c:forEach>
							
								<c:if test="${page >= maxpage}">
									▷
								</c:if>
								<c:if test="${page<maxpage}">
									<a href="admin_car_list?page=${page+1}">▶</a>
								</c:if>
							</c:if>
							
							<%-- 검색후 페이징 --%>
							<c:if test="${(!empty find_field) || (!empty find_name)}">
								<c:if test="${page<=1}">
									[이전]&nbsp;
								</c:if>
								<c:if test="${page>1}">
									<a href="admin_car_list?page=${page-1}&find_field=${find_field}&find_name=${find_name}">[이전]</a>&nbsp;
								</c:if>
							
								<%--현재 쪽번호 출력--%>
								<c:forEach var="a" begin="${startpage}" end="${endpage}" step="1">
									<c:if test="${a == page}">
										<%--현재 페이지가 선택되었다면--%>
										<${a}>
									</c:if>
									<c:if test="${a != page}">
										<%--현재 페이지가 선택되지 않았다면 --%>
										<a href="admin_car_list?page=${a}&find_field=${find_field}&find_name=${find_name}">[${a}]</a>&nbsp;
									</c:if>
								</c:forEach>
							
								<c:if test="${page >= maxpage}">
									[다음]
								</c:if>
								<c:if test="${page<maxpage}">
									<a href="admin_car_list?page=${page+1}&find_field=${find_field}&find_name=${find_name}">[다음]</a>
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