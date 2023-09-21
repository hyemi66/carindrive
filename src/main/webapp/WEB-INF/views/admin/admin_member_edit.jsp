<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/admin_header.jsp" %>

<div id="aMain_cont">
 
  <div id="aMd_wrap">
   <h2 class="aMd_title">관리자 회원정보 수정</h2>
   <form method="post" name="m" 
   action="admin_member_edit" onsubmit="return edit_check();">
    <table id="aMd_t">
     <tr>
      <th class="left_box">회원아이디</th>
      <td><input name="m_id" size="14" value="${m.m_id}"
      readonly /></td>
     </tr>
     <tr>
      <th class="left_box">비밀번호</th>
      <td><input type="password" name="m_pwd" id="m_pwd"
      size="14" /></td>
     </tr>
     <tr>
      <th class="left_box">비밀번호 확인</th>
      <td><input type="password" name="m_pwd2" id="m_pwd2"
      size="14" /></td>     
     </tr>
     <tr>
      <th class="left_box">회원이름</th>
      <td><input name="m_name" id="m_name" size="14"
      value="${m.m_name}" /></td>
     </tr>
     <tr>
      <tr>
      <th class="left_box">회원 생년월일</th>
      <td><input name="m_birth" readonly size="14"
      value="${m.m_birth}" /></td>
     </tr>
     <tr>
      <th class="left_box">폰번호</th>
     <td><input name="m_phone" id="m_phone" size="14"
      value="${m.m_phone}" /></td>
     </tr>
     <tr>
      <th class="left_box">이메일</th>
      <td><input name="m_email" id="m_email" size="14"
      value="${m.m_email}" /></td>
     </tr>
     <tr>
      <th class="left_box">가입/탈퇴</th>
      <td><input name="m_state" readonly size="2" 
      value="${m.m_state}" /></td>
     </tr>
     <tr>
      <th colspan="2">
      <input type="submit" value="수정" />
      <input type="reset" value="취소" 
      onclick="$('#m_pwd').focus();" />
      <input type="button" value="회원목록"
onclick="location='admin_member_list?page=${page}';" />      
      </th>
     </tr>
    </table>
   </form>
  </div>
</div>

<%@ include file="../include/admin_footer.jsp" %>












