<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../include/admin_header.jsp"%>

<%--관리자 메인 본문 --%>
<div id="aMain_cont">
	<form method="get" action="admin_member_list">
		<div id="mList_wrap">
			<h2 class="mList_title">관리자 회원목록</h2>
			<div class="mList_count">회원수: ${listcount} 개</div>
			<table id="mList_t">
				<tr>
					<th width="20%" height="26">아이디</th>
					<th width="16%">회원이름</th>
					<th width="20%">폰번호</th>
					<th width="14%">가입/탈퇴</th>
					<th width="16%">가입날짜</th>
					<th width="26%">수정/삭제</th>
				</tr>
				<c:if test="${!empty blist}">
					<c:forEach var="m" items="${blist}">
						<tr>
							<td align="center">${m.m_id}</td>
							<td align="center"><a
								href="admin_member_info?m_id=${m.m_id}&page=${page}&state=info">
									${m.m_name} </a></td>
							<td align="center">
								${m.m_tel}</td>
							<td align="center"><c:if test="${m.m_state == 0}">가입회원</c:if>
								<c:if test="${m.m_state == 1}">탈퇴회원</c:if></td>
							<td align="center">${fn:substring(m.regdate,0,10)}</td>
							<td align="center"><input type="button" value="수정"
								onclick="location=
'admin_member_info?m_id=${m.m_id}&page=${page}&state=edit';" />
								<input type="button" value="삭제"
								onclick="if(confirm('정말로 삭제할까요?') == true){
location=
'admin_member_del?m_id=${m.m_id}&page=${page}';	
}else{ return ;}" />
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty blist}">
					<tr>
						<th colspan="6">회원목록이 없습니다!</th>
					</tr>
				</c:if>
			</table>

			<%--페이징 즉 쪽나누기 추가 --%>
			<div id="mList_paging">
				<%-- 검색전 페이징 --%>
				<c:if test="${(empty find_field) && (empty find_name)}">
					<c:if test="${page<=1}">
     [이전]&nbsp;
    </c:if>
					<c:if test="${page>1}">
						<a href="admin_member_list?page=${page-1}">[이전]</a>&nbsp;
    </c:if>

					<%--현재 쪽번호 출력--%>
					<c:forEach var="a" begin="${startpage}" end="${endpage}" step="1">
						<c:if test="${a == page}">
							<%--현재 페이지가 선택되었다면--%>
      <${a}>
     </c:if>
						<c:if test="${a != page}">
							<%--현재 페이지가 선택되지 않았
     다면 --%>
							<a href="admin_member_list?page=${a}">[${a}]</a>&nbsp;
     </c:if>
					</c:forEach>

					<c:if test="${page >= maxpage}">
    [다음]
    </c:if>
					<c:if test="${page<maxpage}">
						<a href="admin_member_list?page=${page+1}">[다음]</a>
					</c:if>
				</c:if>

				<%-- 검색후 페이징 --%>
				<c:if test="${(!empty find_field) || (!empty find_name)}">
					<c:if test="${page<=1}">
     [이전]&nbsp;
    </c:if>
					<c:if test="${page>1}">
						<a
							href="admin_member_list?page=${page-1}&find_field=${find_field}&find_name=${find_name}">[이전]</a>&nbsp;
    </c:if>

					<%--현재 쪽번호 출력--%>
					<c:forEach var="a" begin="${startpage}" end="${endpage}" step="1">
						<c:if test="${a == page}">
							<%--현재 페이지가 선택되었다면--%>
      <${a}>
     </c:if>
						<c:if test="${a != page}">
							<%--현재 페이지가 선택되지 않았
     다면 --%>
							<a
								href="admin_member_list?page=${a}&find_field=${find_field}&find_name=${find_name}">[${a}]</a>&nbsp;
     </c:if>
					</c:forEach>

					<c:if test="${page >= maxpage}">
    [다음]
    </c:if>
					<c:if test="${page<maxpage}">
						<a
							href="admin_member_list?page=${page+1}&find_field=${find_field}&find_name=${find_name}">[다음]</a>
					</c:if>
				</c:if>
			</div>

			<div id="mList_menu">
				<c:if test="${(!empty find_field) && (!empty find_name)}">
					<input type="button" value="전체회원"
						onclick="location='admin_member_list?page=${page}';" />
				</c:if>
			</div>

			<%--검색 폼추가 --%>
			<div id="mFind_wrap">
				<select name="find_field">
					<option value="m_id"
						<c:if test="${find_field=='m_id'}">
   ${'selected'}</c:if>>아이디</option>
					<option value="m_name"
						<c:if test="${find_field=='m_name'}">
   ${'selected'}</c:if>>회원이름</option>
				</select> <input name="find_name" id="find_name" size="14"
					value="${find_name}" /> <input type="submit" value="검색" />
			</div>
		</div>
	</form>
</div>

<jsp:include page="../include/admin_footer.jsp" />

