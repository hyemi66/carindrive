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
			<h1>차 량 관 리</h1>
			<div class="clear"></div>
				<form method="post" action="admin_car_edit_ok" onsubmit="return car_write_check();" enctype="multipart/form-data">
     			<input type="hidden" name="c_num" value="${c.c_num}" />
     			<input type="hidden" name="page" value="${page}" />
					<div id="Bag">
						<h2>차량 추가</h2>
						<table id="ag_t" border="1">
							<tr>
								<th>이&nbsp;&nbsp;&nbsp;름</th>
								<td><input name="c_name" id="c_name"size="97" style="height: 32px;" value="${c.c_name}"/></td>
							</tr>
							<tr>
								<th>브랜드</th>
								<td><input name="c_brand" id="c_brand" size="97" style="height: 32px;" value="${c.c_brand}" /></td>
							</tr>
							<tr>
								<th>년&nbsp;&nbsp;&nbsp;식</th>
								<td><input name="c_year" id="c_year" size="97" style="height: 32px;" value="${c.c_year}"></td>
							</tr>
							<tr>
								<th>색&nbsp;&nbsp;&nbsp;상</th>
								<td><input name="c_color" id="c_color" size="97" style="height: 32px;" value="${c.c_color}"/></td>
							</tr>
							<tr>
								<th>차&nbsp;&nbsp;&nbsp;종</th>
								<td>
									<div>
										<select id="c_type2" name="c_type2" class="select">
											<option value="">타입선택</option>
											<option value="경형">경형</option>
											<option value="소형">소형</option>
											<option value="중형 세단">중형 세단</option>
											<option value="중형 SUV">중형 SUV</option>
											<option value="전기차">전기차</option>
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<th>상&nbsp;&nbsp;&nbsp;세</th>
								<td><input name="c_type" id="c_type" size="97" style="height: 32px;" value="${c.c_type}" /></td>
							</tr>
							<tr>
								<th>기&nbsp;&nbsp;&nbsp;름</th>
								<td><input name="c_oil" id="c_oil" size="97" style="height: 32px;" value="${c.c_oil}"/></td>
							</tr>
							<tr>
								<th>가&nbsp;&nbsp;&nbsp;격</th>
								<td><input name="c_price" id="c_price" size="97" style="height: 32px;" value="${c.c_price}"/></td>
							</tr>
							<tr>
								<th>이미지</th>
								<td>
									<div class="filebox">
										<input class="upload-name" value="${c.c_img}" disabled="disabled">
										<label for="ex_filename">업로드</label> 
										<input type="file" id="ex_filename" class="upload-hidden"> 
									</div>
									<script>
										$(document).ready(function(){
											var fileTarget = $('.filebox .upload-hidden');
											
											fileTarget.on('change', function(){ // 값이 변경되면
												if(window.FileReader){ // modern browser
													var filename = $(this)[0].files[0].name;
												} 
												else { // old IE
													var filename = $(this).val().split('/').pop().split('\\').pop();  // 파일명만 추출
												}
												
												// 추출한 파일명 삽입
												$(this).siblings('.upload-name').val(filename);
											});
										}); 
									</script>
								</td>
							</tr>
						</table>
						
						<div id="ag_button2">
							<input type="submit" value="수정" />
    						<input type="reset" value="취소" onclick="$('#c_name').focus();" />
    						<input type="button" value="목록" onclick="location='admin_car_list?page=${page}';" />
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