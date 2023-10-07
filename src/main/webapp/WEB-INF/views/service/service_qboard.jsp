<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="${path}/js/jquery.js"></script>
<script src="https://kit.fontawesome.com/ce494e5de1.js" crossorigin="anonymous"></script>
<link href="${path}/css/main.css" rel="stylesheet"/>
<link href="${path}/css/service.css" rel="stylesheet"/>
</head>
<body>
<div class="CARBig">
<jsp:include page="../include/header.jsp"/>
</div>
<div class="CARBig">
<%--서브 메인 이미지--%>
<h1 id="board_name" align="center">고객센터</h1>

<%-- 고객센터 메뉴 --%>
<div id="sub_menu">
 <ul>
  <li><h2><a href="${path}/service/service_center">고객센터</a></h2></li>
  <li><h2><a href="${path}/service/service_question">자주 묻는 질문</a></h2></li>
  <li><h2><a href="${path}/service/service_notice">공지사항</a></h2></li>
  <li><h2><a href="${path}/service/service_qboard">1대1문의</a></h2></li>
 </ul>
</div>


<%-- 1대1문의 목록 보기 --%>
<main>

<form method="get" action="service_qboard">
		<div id="center_nlist2">
		<h1>1대1 문의 목록</h1>
		<div id="qna_but">
			<input type="button" value="글쓰기" onclick="location='service_qwrite';" />
		</div>
			<table class="qna-table">
			<tr>
				<th class="nlist-type">번호</th>
				<th class="nlist-title">제목</th>
				<th class="nlist-id">작성자</th>
				<th class="nlist-date">날짜</th>
			</tr>

			<c:if test="${!empty qnalist}">
			<c:forEach var="q" items="${qnalist}">
				<c:if test="${q.qna_replytype == 0}">
			<tr class="qnalist">
				<td>
				<%--원본글일때만 글그룹 번호가 출력되고,답변글일때는 그룹번호가 출력 안됨.--%>
					&lt;${q.qna_replygroup}&gt;
				
				</td>
				<td>					      
				<a href="service_qpwdCheck?cq_no=${q.cq_no}&state=cont&page=${page}">${q.cq_title}</a>
				</td>
				<td align="center">${q.cq_id}</td>
				<td align="center">${fn:substring(q.cq_date,0,10)}</td>
				<%-- 0이상 10미만 사이의 년월일만 반환 --%>
			</tr>
			</c:if>
			</c:forEach>
			</c:if>

			<c:if test="${empty qnalist}">
			<tr>
				<th colspan="4">목록이 없습니다.</th>
			</tr>
			</c:if>
			</table>
			<div id="write-button">
			</div>

		<%--페이징(쪽나누기)--%>
		<div id="page_control">
			<%--검색전 페이징 --%>
			<c:if test="${(empty find_field)&&(empty find_name)}">
				<c:if test="${page <=1}">[이전]&nbsp;</c:if>
				<c:if test="${page >1}">
					<a href="service_qboard?page=${page-1}">[이전]</a>&nbsp;
  				</c:if>

				<%--쪽번호 출력부분 --%>
				<c:forEach var="a" begin="${startpage}" end="${endpage}" step="1">
					<c:if test="${a == page}"><${a}></c:if>
					<c:if test="${a != page}">
						<a href="service_qboard?page=${a}">[${a}]</a>&nbsp;
  					</c:if>
				</c:forEach>
				<c:if test="${page>=maxpage}">[다음]</c:if>
				<c:if test="${page<maxpage}"><a href="service_qboard?page=${page+1}">[다음]</a></c:if>
			</c:if>
			
			<%-- 검색후 페이징(쪽나누기) --%>
			<c:if test="${(!empty find_field) || (!empty find_name)}">
				<c:if test="${page <=1}">[이전]&nbsp;</c:if>
				<c:if test="${page >1}">
					<a href="service_qboard?page=${page-1}&find_field=${find_field}
						&find_name=${find_name}">[이전]</a>&nbsp;
 				</c:if>

			<%--쪽번호 출력부분 --%>
			<c:forEach var="a" begin="${startpage}" end="${endpage}" step="1">
				<c:if test="${a == page}"><${a}></c:if>
				<c:if test="${a != page}">
					<a href="service_qboard?page=${a}&find_field=${find_field}
						&find_name=${find_name}">[${a}]</a>&nbsp;
 				</c:if>
			</c:forEach>

			<c:if test="${page>=maxpage}">[다음]</c:if>
			<c:if test="${page<maxpage}">
				<a href="servicec_qboard?page=${page+1}&find_field=${find_field}
					&find_name=${find_name}">[다음]</a>
			</c:if>
		</c:if>
		</div>

		<div  class="write-menu">
		<c:if test="${(!empty find_field) && (!empty find_name)}">
			<input type="button" value="전체목록" onclick="location='service_qboard?page=${page}';" />
		</c:if>
		</div>
		
	</div>
</form>
</main>
<div id="ffff"><br></div>
<br><br>
</div>
<div class="CARBig">
<jsp:include page="../include/footer.jsp"/>
</div>
</body>
</html>