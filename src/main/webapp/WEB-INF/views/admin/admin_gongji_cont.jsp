<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../include/admin_header.jsp" %>

<div id="aMain_cont">
 <div id="abbsCont_wrap">
  <h2 class="abbsCont_title">공지사항 내용</h2>
  <table id="abbsCont_t">
   <tr>
    <th>등록자</th> <td>${g.cs_name}</td>
   </tr>
   <tr>
    <th>등록날짜</th> <td>${fn:substring(g.cs_date,0,10)}</td>
   </tr>
   <tr>
    <th>조회수</th> <td>${g.cs_hit}</td>
   </tr>
   <tr>
    <th>공지제목</th> <td>${g.cs_title}</td>
   </tr>
   <tr>
    <th>공지내용</th> <td>${cs_cont}</td>
   </tr>
  </table>
  <div id="abbsCont_menu">
   <input type="button" value="목록"
   onclick="location='admin_gongji_list?page=${page}';" />
  </div>
 </div>
</div>

<%@ include file="../include/admin_footer.jsp" %>