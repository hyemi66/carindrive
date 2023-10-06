<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="${path}/js/jquery.js"></script>
<script src="https://kit.fontawesome.com/8eb5905426.js" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/ce494e5de1.js" crossorigin="anonymous"></script>
<link href="${path}/css/main.css" rel="stylesheet"/>
<link href="${path}/css/service.css" rel="stylesheet"/>
</head>
<body>
<div class="CARBig">
<jsp:include page="../include/header.jsp"/>
</div>
<div class="CARBig">
<div id="sub_img_center"></div>
<div class="clear"></div>

<%--서브 메인 이미지--%>
<div id="sub_img_member"></div>
<div class="clear"></div>

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

<%-- 질문 검색바 --%>
<form method="get" action="service_notice">
<div class="search">
      <input type="search" name="find_name" id="find_name" 
      class="input_box" placeholder="찾을 내용을 입력하세요." value="${find_name}" >
      <i class="fas fa-search"></i>
      <input type="submit" class="box" value="검색">                                                                                                                                                                                     
      <input type="reset" class="box" value="초기화">
      <ul class="search_word"> 
      	<li class="word3"><a href="${path}/service/service_question00">전체</a></li>
      	<li class="word3"><a href="${path}/service/service_question01">가입/탈퇴</a></li>
      	<li class="word3"><a href="${path}/service/service_question02">예약취소</a></li>
      	<li class="word4"><a href="${path}/service/service_question03">요금/결제</a></li>
      	<li class="word5"><a href="${path}/service/service_question04">사용/반납</a></li>
      	<li class="word6"><a href="${path}/service/service_question05">보험/사고</a></li>
      	<li class="word7"><a href="${path}/service/service_question06">전기차</a></li>
      	<li class="word9"><a href="${path}/service/service_question07">기타</a></li>
      </ul>
</div>
</form>

<%-- 고객센터 주요 기능 바로가기  --%>
<div class="shortcut">
	<div class="shortcut1">
		<i class="fa-solid fa-phone fa-2xl"></i><br>
		<b>1111-1111</b><p>365일 24시간 운영</p>
	</div>
	<div class="shortcut2">
		<i class="fa-regular fa-circle-question fa-2xl"></i><br>
		<a href="${path}/service/service_question"><b>자주 묻는 질문</b></a>
	</div>
	<div class="shortcut3">
		<i class="fa-solid fa-comments fa-2xl"></i><br>
		<a href="${path}/service/service_qwrite"><b>1:1 문의 하기</b></a>
	</div>
</div>

<%-- 최신 공지사항 목록 보기  --%>
<main>
<div class="center_nlist">
	<table class="center_nlist-table">
	<caption  class="main_title">최신 공지사항</caption>
		<tbody>
		<tr>
			<th class="nlist-title">제목</th>
			<th class="nlist-date">날짜</th>
		</tr>
		<c:forEach var="g" items="${glist}">
		<c:if test="${!empty glist}">
				<tr>
					<th>
						<a href="service_ncont?cs_no=${g.cs_no}"> 
						<c:if test="${fn:length(g.cs_title)>40}">
       						${fn:substring(g.cs_title,0,40)}...
      					</c:if> 
      					<c:if test="${fn:length(g.cs_title)<40}">
     						${g.cs_title}
      					</c:if>
						</a>
					</th>
					<th>${fn:substring(g.cs_date,0,10)}</th>
				</tr>
		</c:if>
		<c:if test="${empty glist}">
			<tr>
				<th colspan="2">공지 목록이 없습니다!</th>
			</tr>
		</c:if>
		</c:forEach>
		</tbody>
	</table>
</div>
</main>

<%-- 공지사항 전체 보기 버튼 --%>
<div class="notice-all-btn">
	<a href="${path}/service/service_notice" class="notice-all">공지사항 전체 보기</a>
</div>
<br><br>

</div>
<div class="CARBig">
<jsp:include page="../include/footer.jsp"/>
</div>
</body>
</html>