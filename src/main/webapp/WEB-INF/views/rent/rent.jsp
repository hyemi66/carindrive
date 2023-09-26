<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="${path}/js/jquery.js"></script>
<link href="${path}/css/main.css" rel="stylesheet"/>
<link href="${path}/css/rent.css" rel="stylesheet"/>
</head>
<body>
  <jsp:include page="../include/header.jsp"/>
  
  <div class="clear"></div>
<form method="post">
<!-- 로그인 아이디 값을 히든으로 넘김 -->
<input type="hidden" name="cr_mid" id="cr_mid" value="${loggedInUser.m_id}" required><br>
<!-- 차 이름값을 히든으로 넘김 -->
<%-- 예약 선택 메뉴 --%>
<div class="mainmenu">
<div id="menu01">
	<p>
		빌리는 날짜 | 
		<input type="datetime-local" name="cr_sdate" id="cs_edate" required>
	</p>
</div>
<div id="menu02">
	<p>
		반납하는 날짜 | 
		<input type="datetime-local" name="cr_edate" id="cr_edate" required>
	</p>
</div>
<div id="menu03">
	<p>
		대여시간 | 
	</p>
</div>
</div>

<div class="clear"></div>

<br><br>

<%-- 차종 선택별 메뉴 --%>
<div class="tab_content">
	<input type="radio" name="tabmenu" id="tab01" checked>
	<label for="tab01">전체</label>
	<input type="radio" name="tabmenu" id="tab02">
	<label for="tab02">경형</label>
	<input type="radio" name="tabmenu" id="tab03">
	<label for="tab03">소형</label>
	<input type="radio" name="tabmenu" id="tab04">
	<label for="tab04">중형(세단)</label>
	<input type="radio" name="tabmenu" id="tab05">
	<label for="tab05">중형(SUV)</label>
	<input type="radio" name="tabmenu" id="tab06">
	<label for="tab06">전기차</label>
	
	<div class="conbox con1"> <!-- 전체 -->
		<table>
			<c:if test="${!empty clist}">
				<tr>
					<c:forEach var="c" items="${clist}" varStatus="status">
						<c:if test="${status.index % 3 == 0}">
							</tr><tr>
						</c:if>
						<td>
							<div id="box01">
								<br><br><br>
								<img id="imgC" src="../images/car/${c.c_img}">
								<br><br><br>
								<hr>
								<b>${c.c_brand} ${c.c_name}</b><br>
								${c.c_type} | ${c.c_oil} | ${c.c_year} <br><br>
								<p>
									1시간 : \ <fmt:formatNumber value="${c.c_price*60}" pattern="#,###"/>
									<br>
									24시간 : \ <fmt:formatNumber value="${c.c_price*60*24}" pattern="#,###"/>
								</p>
								<div id="box02"><input type="submit" value="예 약 하 기"></div>
							</div>
						</td>
					</c:forEach>
				</tr>
			</c:if>
			<c:if test="${empty clist}">
				<tr>
					<td>
						없음
					</td>
				</tr>
			</c:if>
		</table>
	</div>
	<div class="conbox con2"> <!-- 경형 -->
		<table>
			<c:if test="${!empty clist}">
				<tr>
					<c:forEach var="c" items="${clist}" varStatus="status">
						<c:if test="${status.index % 3 == 0}">
							</tr><tr>
						</c:if>
						<c:if test="${c.c_type2.equals('경형')}">
							<td>
								<div id="box01">
									<br><br><br>
									<img id="imgC" src="../images/car/${c.c_img}">
									<br><br><br>
									<hr>
									<b>${c.c_brand} ${c.c_name}</b><br>
									${c.c_type} | ${c.c_oil} | ${c.c_year} <br><br>
									<p>
										1시간 : \ <fmt:formatNumber value="${c.c_price*60}" pattern="#,###"/>
										<br>
										24시간 : \ <fmt:formatNumber value="${c.c_price*60*24}" pattern="#,###"/>
									</p>
									<div id="box02"><input type="submit" value="예 약 하 기"></div>
								</div>
							</td>
						</c:if>
					</c:forEach>
				</tr>
			</c:if>
		</table>
	</div>
	<div class="conbox con3"> <!-- 소형 -->
		<table>
			<c:if test="${!empty clist}">
				<tr>
					<c:forEach var="c" items="${clist}" varStatus="status">
						<c:if test="${status.index % 3 == 0}">
							</tr><tr>
						</c:if>
						<c:if test="${c.c_type2.equals('소형')}">
							<td>
								<div id="box01">
									<br><br><br>
									<img id="imgC" src="../images/car/${c.c_img}">
									<br><br><br>
									<hr>
									<b>${c.c_brand} ${c.c_name}</b><br>
									${c.c_type} | ${c.c_oil} | ${c.c_year} <br><br>
									<p>
										1시간 : \ <fmt:formatNumber value="${c.c_price*60}" pattern="#,###"/>
										<br>
										24시간 : \ <fmt:formatNumber value="${c.c_price*60*24}" pattern="#,###"/>
									</p>
									<div id="box02"><input type="submit" value="예 약 하 기"></div>
								</div>
							</td>
						</c:if>
					</c:forEach>
				</tr>
			</c:if>
		</table>
	</div>
	<div class="conbox con4"> <!-- 중형(세단) -->
		<table>
			<c:if test="${!empty clist}">
				<tr>
					<c:forEach var="c" items="${clist}">
						<c:if test="${c.c_type2.equals('중형 세단')}">
							<td>
								<div id="box01">
									<br><br><br>
									<img id="imgC" src="../images/car/${c.c_img}">
									<br><br><br>
									<hr>
									<b>${c.c_brand} ${c.c_name}</b><br>
									${c.c_type} | ${c.c_oil} | ${c.c_year} <br><br>
									<p>
										1시간 : \ <fmt:formatNumber value="${c.c_price*60}" pattern="#,###"/>
										<br>
										24시간 : \ <fmt:formatNumber value="${c.c_price*60*24}" pattern="#,###"/>
									</p>
									<div id="box02"><input type="submit" value="예 약 하 기"></div>
								</div>
							</td>
						</c:if>
						<c:if test="${c.c_num == 8}">
							</tr><tr>
						</c:if>
					</c:forEach>
				</tr>
			</c:if>
		</table>
	</div>
	<div class="conbox con5"> <!-- 중형(SUV) -->
		<table>
			<c:if test="${!empty clist}">
				<tr>
					<c:forEach var="c" items="${clist}" varStatus="status">
						<c:if test="${c.c_type2.equals('중형 SUV')}">
							<td>
								<div id="box01">
									<br><br><br>
									<img id="imgC" src="../images/car/${c.c_img}">
									<br><br><br>
									<hr>
									<b>${c.c_brand} ${c.c_name}</b><br>
									${c.c_type} | ${c.c_oil} | ${c.c_year} <br><br>
									<p>
										1시간 : \ <fmt:formatNumber value="${c.c_price*60}" pattern="#,###"/>
										<br>
										24시간 : \ <fmt:formatNumber value="${c.c_price*60*24}" pattern="#,###"/>
									</p>
									<div id="box02"><input type="submit" value="예 약 하 기"></div>
								</div>
							</td>
						</c:if>
						<c:if test="${status.index % 3 == 0}">
							</tr><tr>
						</c:if>
					</c:forEach>
				</tr>
			</c:if>
		</table>
	</div>
	<div class="conbox con6"> <!-- 전기차 -->
		<table>
			<c:if test="${!empty clist}">
				<tr>
					<c:forEach var="c" items="${clist}" varStatus="status">
						<c:if test="${status.index % 3 == 0}">
							</tr><tr>
						</c:if>
						<c:if test="${c.c_type2.equals('전기차')}">
							<td>
								<div id="box01">
									<br><br><br>
									<img id="imgC" src="../images/car/${c.c_img}">
									<br><br><br>
									<hr>
									<b>${c.c_brand} ${c.c_name}</b><br>
									${c.c_type} | ${c.c_oil} | ${c.c_year} <br><br>
									<p>
										1시간 : \ <fmt:formatNumber value="${c.c_price*60}" pattern="#,###"/>
										<br>
										24시간 : \ <fmt:formatNumber value="${c.c_price*60*24}" pattern="#,###"/>
									</p>
									<div id="box02"><input type="submit" value="예 약 하 기"></div>
								</div>
							</td>
						</c:if>
					</c:forEach>
				</tr>
			</c:if>
		</table>
	</div>
</div>
</form>


<br>
<br>
<br>
<br>
<br>

<div class="clear"></div>


<jsp:include page="../include/footer.jsp"/>
</body>
</html>