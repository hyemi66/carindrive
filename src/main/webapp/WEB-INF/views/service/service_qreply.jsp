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
<script src="https://kit.fontawesome.com/8eb5905426.js" crossorigin="anonymous"></script>
<script 
 src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	 <%--  CDN(Content Delivery Network)
	  : 인터넷이 연결된 상태에서 온라인으로 jQuery라이브러리를 연결해서 사용하는 방식
	  	로컬 pc로 jQuery라이브러리를 다운 받지 않고 사용가능 --%> 
<link href="${path}/css/main.css" rel="stylesheet"/>
<link href="${path}/css/service.css" rel="stylesheet"/>
</head>
<body>
<jsp:include page="../include/header.jsp"/>
<div id="sub_img_center"></div>
<div class="clear"></div>

<%--서브 메인 이미지--%>
<div id="sub_img_member"></div>
<div class="clear"></div>

<h1 id="board_name">고객센터</h1>

<%-- 고객센터 메뉴 --%>
<div id="sub_menu">
 <ul>
  <li><h2><a href="${path}/service/service_center">고객센터</a></h2></li>
  <li><h2><a href="${path}/service/service_question">자주 묻는 질문</a></h2></li>
  <li><h2><a href="${path}/service/service_notice">공지사항</a></h2></li>
  <li><h2><a href="${path}/service/service_qboard">1대1문의</a></h2></li>
 </ul>
</div>

<main>
<div id="bsW_wrap">
   <form method="post" action="qna_reply_ok" onsubmit="return write_check();">
    <input type="hidden" name="qna_replygroup" value="${q.qna_replygroup}" >
    <%--답변글 히든값, 원본글과 답변글을 묶어주는 글 그룹번호 역할 --%>
    <input type="hidden" name="qna_replytype" value="${q.qna_replytype}" >
    <%-- 원본글이면 0, 첫번째 답변글이면 1,두번째 답변글이면 2로 순차적 증가 --%>
    <input type="hidden" name="qna_replyindex" value="${q.qna_replyindex}" >
    <%--답변글 정렬순서 --%>
    
    <input type="hidden" name="page" value="${page}" >
    <%--페이징 ; 내가본 쪽번호로 바로 이동하기 위한 책갈피 기능, 
    	히든으로 쪽번호를 전달 --%>
    
    <table class="write-table">
     <tr>
      <th>글쓴이</th>
      <td class="serivce" colspan="3">${cq_id}</td>
     </tr>
     <tr>
      <th>글제목</th>
      <td class="serivce" colspan="3">
      <input type="text" name="cq_title" id="cq_title" value="Re:${q.cq_title}" >
      </td>
      <tr>
       <th>비밀번호</th>
       <td class="serivce" colspan="3">
       <input type="password" name="cq_pwd" id="cq_pwd" ></td>
     </tr>
     <tr class="cont">
      <th>글내용</th>
      <td colspan="4">
      <textarea class="cq_cont" name="cq_cont" id="cq_cont"></textarea>
     </tr>     
    </table>
    <div class="write-menu">
     <input type="submit" value="답변" > 
     <input type="button" value="취소"
     onclick="location='service_qcont?cq_no=${q.cq_no}&page=${page}&state=cont';" >
     <input type="button" value="목록"
			onclick="location='service_qboard?page=${page}';" />
    </div>
   </form>
 </div>
</main>

<jsp:include page="../include/footer.jsp"/>
</body>
</html>