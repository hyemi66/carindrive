<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../include/admin_header.jsp" %>
 
 <%--관리자 메인 본문 --%>
  <div id="aMain_cont">
    <div id="aBw_wrap">
     <h2 class="aBw_title">공지사항 수정</h2>
     <form method="post" action="admin_gongji_edit_ok"
     onsubmit="return write_check();">
     <input type="hidden" name="cs_no" value="${g.cs_no}" />
     <input type="hidden" name="page" value="${page}" />
     <table id="aBw_t">
    <tr>
     <th>제목</th>
     <td>
     <input name="cs_title" id="cs_title" size="35" 
     value="${g.cs_title}"/>
     </td>
    </tr>
    <tr>
     <th>내용</th>
     <td>
     <textarea name="cs_cont" id="cs_cont" rows="9"
     cols="36">${g.cs_cont}</textarea>
     </td>
    </tr>
   </table>
   <div id="aBw_menu">
    <input type="submit" value="수정" />
    <input type="reset" value="취소" 
    onclick="$('#cs_title').focus();" />
    <input type="button" value="목록"
    onclick="location='admin_gongji_list?page=${page}';" />
   </div>
     </form>
    </div>
  </div>
  
<jsp:include page="../include/admin_footer.jsp" /> 
