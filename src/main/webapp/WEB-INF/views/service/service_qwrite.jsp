<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="${path}/js/jquery.js"></script>
<script src="${path}/js/service.js"></script>
<link href="${path}/css/main.css" rel="stylesheet"/>
<link href="${path}/css/service.css" rel="stylesheet"/>
</head>
<body>
<div class="CARBig">
<jsp:include page="../include/header.jsp"/>
</div>
<div class="CARBig">
<h1 id="board_name" align="center">고객센터</h1>

<div id="sub_menu">
 <ul>
  <li><h2><a href="${path}/service/service_center">고객센터</a></h2></li>
  <li><h2><a href="${path}/service/service_question">자주 묻는 질문</a></h2></li>
  <li><h2><a href="${path}/service/service_notice">공지사항</a></h2></li>
  <li><h2><a href="${path}/service/service_qboard">1대1문의</a></h2></li>
 </ul>
</div>


<main>
    <form method="post" action="qna_write_ok" 
    	 enctype="multipart/form-data" onsubmit="return qna_check();">
		<table class="write-table">
	    <caption class="main title">1:1문의 등록</caption>
	        <tbody>
	            <tr>
	                <th>제목</th>
	                <td class="serivce" colspan="3">
	                <input type="text" name="cq_title" id="cq_title" /></td>
	            </tr>
	            <tr>
	                <th>첨부파일</th>
	                <td class="serivce" colspan="3">
	                <input type="file" name="cq_file" id="cq_file"/> </td>
	            </tr>
	             <tr>
	                <th>게시물 비밀번호</th>
	                <td class="serivce" colspan="3">
	                <input type="password" id="cq_pwd" name="cq_pwd" placeholder="비밀번호를 입력하세요" /> </td>
	            </tr>
	            <tr class="content">
	                <td colspan="4">
	                <textarea class="cq_cont" id="cq_cont" name="cq_cont"></textarea></td>
	            </tr>
	        </tbody>
        </table>
        <div class="write-menu">
			<input type="submit" value="저장"/> 
			<input type="button" value="취소" onclick="location='service_center';"/>
		</div>
    </form>
</main>
  
</div>
<div class="CARBig">
<jsp:include page="../include/footer.jsp"/>
</div>
</body>
</html>