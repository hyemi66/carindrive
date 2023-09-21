<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="../include/admin_header.jsp" />

<div id="aMain_cont">
	<form method="get" action="admin_gongji_list">
		<div id="gList_wrap">
			<h2 class="gList_title">공지사항 목록</h2>
			<div class="gList_count">글개수: ${listcount} 개</div>
			<table id="gList_t">
				<tr>
					<th width="6%" height="26">번호</th>
					<th width="34%">제목</th>
					<th width="14%">작성자</th>
					<th width="18%">작성일</th>
					<th width="10%">조회수</th>
					<th width="18%">수정/삭제</th>
				</tr>
				<c:if test="${!empty glist}">
					<c:forEach var="g" items="${glist}"  varStatus="status">
						<tr>
							<td align="center">${status.count}</td>
							<td align="center">
				<a href="admin_gongji_cont?no=${g.cs_no}&page=${page}&state=cont">
									<c:if test="${fn:length(g.cs_title)>16}">
 ${fn:substring(g.cs_title,0,16)}...
									</c:if> <c:if test="${fn:length(g.cs_title)<16}">
${g.cs_title}
</c:if>
							</a></td>
							<td align="center">${g.cs_name}</td>
							<td align="center">${fn:substring(g.cs_date,0,10)}</td>
							                   <%-- 0이상 10미만 사이의 년월일 만 반환 --%>
							<td align="center">${g.cs_hit}</td>
							<td align="center"><input type="button" value="수정"
								onclick="location=
'admin_gongji_cont?no=${g.cs_no}&page=${page}&state=edit';" />
								<input type="button" value="삭제"
								onclick="if(confirm('정말로 삭제할까요?') == true){
location=
'admin_gongji_del?no=${g.cs_no}&page=${page}';   
}else{ return ;}" />
					</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty glist}">
					<tr>
						<th colspan="6">목록이 없습니다!</th>
					</tr>
				</c:if>
			</table>

			<%--페이징 즉 쪽나누기 추가 --%>
			<div id="gList_paging">
				<%-- 검색전 페이징 --%>
				<c:if test="${(empty find_field) && (empty find_name)}">
					<c:if test="${page<=1}">
     [이전]&nbsp;
    </c:if>
					<c:if test="${page>1}">
						<a href="admin_gongji_list?page=${page-1}">[이전]</a>&nbsp;
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
							<a href="admin_gongji_list?page=${a}">[${a}]</a>&nbsp;
     </c:if>
					</c:forEach>

					<c:if test="${page >= maxpage}">
    [다음]
    </c:if>
					<c:if test="${page<maxpage}">
						<a href="admin_gongji_list?page=${page+1}">[다음]</a>
					</c:if>
				</c:if>

				<%-- 검색후 페이징 --%>
				<c:if test="${(!empty find_field) || (!empty find_name)}">
					<c:if test="${page<=1}">
     [이전]&nbsp;
    </c:if>
					<c:if test="${page>1}">
						<a
							href="admin_gongji_list?page=${page-1}&find_field=${find_field}&find_name=${find_name}">[이전]</a>&nbsp;
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
								href="admin_gongji_list?page=${a}&find_field=${find_field}&find_name=${find_name}">[${a}]</a>&nbsp;
     </c:if>
					</c:forEach>

					<c:if test="${page >= maxpage}">
    [다음]
    </c:if>
					<c:if test="${page<maxpage}">
						<a
							href="admin_gongji_list?page=${page+1}&find_field=${find_field}&find_name=${find_name}">[다음]</a>
					</c:if>
				</c:if>
			</div>

			<div id="gList_menu">
				<input type="button" value="글쓰기"
					onclick="location='admin_gongji_write?page=${page}';" />
				<c:if test="${(!empty find_field) && 
   (!empty find_name)}">
					<input type="button" value="전체목록"
						onclick="location='admin_gongji_list?page=${page}';" />
				</c:if>
			</div>

			<%--검색 폼추가 --%>
			<div id="gFind_wrap">
				<select name="find_field">
					<option value="cs_title"
						<c:if test="${find_field=='cs_title'}">
   ${'selected'}</c:if>>제목</option>
					<option value="cs_cont"
						<c:if test="${find_field=='cs_cont'}">
   ${'selected'}</c:if>>내용</option>
				</select> <input type="search" name="find_name" id="find_name" size="14"
					value="${find_name}" /> <input type="submit" value="검색" />
			</div>
		</div>
	</form>
</div>




<jsp:include page="../include/admin_footer.jsp" />