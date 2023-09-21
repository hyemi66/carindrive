<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../include/admin_header.jsp" />

<%--관리자 메인 본문 --%>
<div id="aMain_cont">
	<div id="aBw_wrap">
		<h2 class="aBw_title">공지사항 작성</h2>
		<form method="post" action="admin_gongji_write_ok"
			onsubmit="return gongji_write_check();">
			<table id="aBw_t">
				<tr>
					<th>공지제목</th>
					<td><input name="cs_title" id="cs_title" size="35" /></td>
				</tr>
				<tr>
					<th>공지내용</th>
					<td><textarea name="cs_cont" id="cs_cont" rows="9" cols="36"></textarea>
					</td>
				</tr>
			</table>
			<div id="aBw_menu">
				<input type="submit" value="등록" /> <input type="reset" value="취소"
					onclick="$('#cs_title').focus();" /> <input type="button"
					value="목록" onclick="location='admin_gongji_list?page=${page}';" />
			</div>
		</form>
	</div>
</div>

<jsp:include page="../include/admin_footer.jsp" />

