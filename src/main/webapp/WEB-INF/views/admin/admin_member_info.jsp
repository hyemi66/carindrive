<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/admin_header.jsp" %>

<div id="aMain_cont">
 <div id="aMem_wrap">
  <h2 class="aMem_title">관리자 회원정보</h2>
  <table id="aMem_t">
   <tr>
    <th>회원아이디</th> <td>${m.m_id}</td>
   </tr>
   <tr>
    <th>회원이름</th> <td>${m.m_name}</td>
   </tr>
   <tr>
    <th>생일</th> <td>${m.m_birth}</td>
   </tr>
   <tr>
   <th>휴대폰</th>
   <td>${m.m_phone}</td>
   </tr>
   <tr>
    <th>이메일</th>
    <td>${m.m_email}</td>
   </tr>   
   <tr>
    <th>가입회원/탈퇴회원</th>
    <td>
    <c:if test="${m.m_state == 0}">가입회원</c:if>
    <c:if test="${m.m_state == 1}">탈퇴회원</c:if>
    </td>   
   </tr>
   <tr>
    <th>가입날짜</th> <td>${m.regdate}</td>
   </tr>
  </table>
  <div id="aMem_menu">
  <input type="button" value="회원목록"
  onclick="location='admin_member_list?page=${page}';" />
  </div>
 </div>
</div>

<jsp:include page="../include/admin_footer.jsp" />

















