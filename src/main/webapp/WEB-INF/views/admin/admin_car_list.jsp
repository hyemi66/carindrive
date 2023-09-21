<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="../include/admin_header.jsp" />

<div id="aMain_cont">
	<form method="get" action="admin_car_list">
		<div id="cList_wrap">
			<h2 class="cList_title">차량 목록</h2>
			<div class="cList_count">차량 개수: ${listcount} 개</div>
			<table id="cList_t">
				<tr>
					<th width="6%" height="26">번호</th>
					<th width="9%">차량코드</th>
					<th width="12%">차량 이름</th>
					<th width="12%">차량 브랜드</th>
					<th width="12%">차량 년식</th>
					<th width="11%">차량 색상</th>
					<th width="11%">차량 차종</th>
					<th width="9%">차량 기름</th>										
					<th width="18%">수정/삭제</th>
				</tr>
				<c:if test="${!empty clist}">
					<c:forEach var="c" items="${clist}"  varStatus="status">
						<tr>
							<td align="center">${status.count}</td>
							<td align="center">${c.c_num}</td>
							<td align="center">
				<a href="admin_car_cont?no=${c.c_num}&page=${page}&state=cont">
							${c.c_name}
							</a></td>
							<td align="center">${c.c_brand}</td>
							<td align="center">${c.c_year}</td>
							<td align="center">${c.c_color}</td>
							<td align="center">${c.c_type}</td>
							<td align="center">${c.c_oil}</td>
							<td align="center"><input type="button" value="수정"
								onclick="location=
'admin_car_cont?no=${c.c_num}&page=${page}&state=edit';" />
								<input type="button" value="삭제"
								onclick="if(confirm('정말로 삭제할까요?') == true){
location=
'admin_car_del?no=${c.c_num}&page=${page}';   
}else{ return ;}" />
					</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty clist}">
					<tr>
						<th colspan="9">목록이 없습니다!</th>
					</tr>
				</c:if>
			</table>

			<%--페이징 즉 쪽나누기 추가 --%>
			<div id="cList_paging">
				<%-- 검색전 페이징 --%>
				<c:if test="${(empty find_field) && (empty find_name)}">
					<c:if test="${page<=1}">
     [이전]&nbsp;
    </c:if>
					<c:if test="${page>1}">
						<a href="admin_car_list?page=${page-1}">[이전]</a>&nbsp;
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
							<a href="admin_car_list?page=${a}">[${a}]</a>&nbsp;
     </c:if>
					</c:forEach>

					<c:if test="${page >= maxpage}">
    [다음]
    </c:if>
					<c:if test="${page<maxpage}">
						<a href="admin_car_list?page=${page+1}">[다음]</a>
					</c:if>
				</c:if>

				<%-- 검색후 페이징 --%>
				<c:if test="${(!empty find_field) || (!empty find_name)}">
					<c:if test="${page<=1}">
     [이전]&nbsp;
    </c:if>
					<c:if test="${page>1}">
						<a
							href="admin_car_list?page=${page-1}&find_field=${find_field}&find_name=${find_name}">[이전]</a>&nbsp;
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
								href="admin_car_list?page=${a}&find_field=${find_field}&find_name=${find_name}">[${a}]</a>&nbsp;
     </c:if>
					</c:forEach>

					<c:if test="${page >= maxpage}">
    [다음]
    </c:if>
					<c:if test="${page<maxpage}">
						<a
							href="admin_car_list?page=${page+1}&find_field=${find_field}&find_name=${find_name}">[다음]</a>
					</c:if>
				</c:if>
			</div>

			<div id="cList_menu">
				<input type="button" value="글쓰기"
					onclick="location='admin_car_write?page=${page}';" />
				<c:if test="${(!empty find_field) && 
   (!empty find_name)}">
					<input type="button" value="전체목록"
						onclick="location='admin_car_list?page=${page}';" />
				</c:if>
			</div>

			<%--검색 폼추가 --%>
			<div id="cFind_wrap">
				<select name="find_field">
					<option value="c_name"
						<c:if test="${find_field=='c_name'}">
   ${'selected'}</c:if>>차량이름</option>
					<option value="c_brand"
						<c:if test="${find_field=='c_brand'}">
   ${'selected'}</c:if>>차량브랜드</option>
				</select> <input type="search" name="find_name" id="find_name" size="14"
					value="${find_name}" /> <input type="submit" value="검색" />
			</div>
		</div>
	</form>
</div>




<jsp:include page="../include/admin_footer.jsp" />