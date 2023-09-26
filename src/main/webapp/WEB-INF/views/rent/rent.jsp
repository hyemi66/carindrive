<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>날짜 선택</title>
<script src="${path}/js/jquery.js"></script>
<script src="${path}/js/payment.js"></script> <!-- 결제 코드 js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<link href="${path}/css/main.css" rel="stylesheet"/>
<link href="${path}/css/rent.css" rel="stylesheet"/>
<link href="${path}/css/rent_Wait.css" rel="stylesheet" />

</head>
<body>
  <jsp:include page="../include/header.jsp"/>
  
  <div class="clear"></div>
<%-- 예약 선택 메뉴 --%>
<form action="/rent/rent" method="post">
<input type="hidden" name="cr_mid" id="cr_mid" value="${memberInfo.m_id}" required><br>

<input type="hidden" name="cr_cname" id="cr_cname" value="${car.c_name}">

<div class="mainmenu">

<div id="menu01">

	<p>
		빌 리 는 날 짜&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="datetime-local" name="cr_sdate" id="cr_sdate" onchange="setMinValue()" required>
		<script type="text/javascript">
			let dateElement = document.getElementById("cr_sdate");
			let date = new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000).toISOString().slice(0, -8);
	
			let storedStartDate = "${cr_sdate}"; // JSP에서 Controller로부터 받은 값을 저장
			if(storedStartDate && storedStartDate.length > 0) {
			    dateElement.value = storedStartDate; // 저장된 값을 입력란에 설정
			} else {
			    dateElement.value = date;
			}
		
		dateElement.setAttribute("min", date);
			
			function setMinValue() {
			    if(dateElement.value < date) {
			        alert("현재 시간보다 이전의 날짜는 설정할 수 없습니다");
			        dateElement.value = date;
			    } else {
			        document.forms[0].submit();
			    }
			}
		</script>
	</p>
</div>
<div id="menu02">
	<p>
		반 납 하 는 날 짜&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="datetime-local" name="cr_edate" id="cr_edate" onchange="setMinValue2()" required>
		<script type="text/javascript">
			let dateElement2 = document.getElementById("cr_edate");
			let date2 = new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000).toISOString().slice(0, -8);
	
			let storedEndDate = "${cr_edate}"; // JSP에서 Controller로부터 받은 값을 저장
			if(storedEndDate && storedEndDate.length > 0) {
			    dateElement2.value = storedEndDate; // 저장된 값을 입력란에 설정
			} else {
			    dateElement2.value = date2;
			}
			
			function setMinValue2() {
			    if(dateElement2.value < dateElement.value) {
			        alert("빌리는 날짜보다 이전의 날짜는 설정할 수 없습니다");
			        dateElement2.value = date2;
			    } else {
			        document.forms[0].submit();
			    }
			}
		</script>
	</p>
</div>
</div>
</form>
<div class="clear"></div>

<!-- 로그인 아이디 값을 히든으로 넘김 -->

<!-- 차 이름값을 히든으로 넘김 -->
<%-- 예약 선택 메뉴 --%>
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
	
	
	<script>
	function showCar(carname) {
	    var cr_cname = carname.value;
	    var cr_sdate = document.getElementById("cr_sdate").value;
	    var cr_edate = document.getElementById("cr_edate").value;
	    
	    if (cr_cname) {
	        window.location.href = "/rent/rentInfo?cr_cname=" + cr_cname + "&cr_sdate=" + cr_sdate + "&cr_edate=" + cr_edate;
	    }
	}


	</script>
	
	<input type="hidden" name="cr_cname" id="cr_cname" value="${cr_cname}">
	
	<div class="conbox con1"> <!-- 전체 -->
	<form>
		<table>
			<c:if test="${!empty clist}">
				<tr>
					<c:forEach var="c" items="${clist}" varStatus="status">
						<input type="hidden" name=currentCar${status.index} value="${c.c_name}" >
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
								<div id="box02">
								    <input type="button" value="예 약 하 기" onclick="showCar(currentCar${status.index})" />
								</div>
							</div>
						</td>
					</c:forEach>
				</tr>
			</c:if>
		</table>
	</form>
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
									<div id="box02">
										
									</div>
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
									<div id="box02">
									</div>
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
									<div id="box02">
									</div>
								</div>
							</td>
						</c:if>
						<c:if test="${c.c_name == '3 시리즈'}">
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
									<div id="box02">
									</div>
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
									<div id="box02">
									</div>
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