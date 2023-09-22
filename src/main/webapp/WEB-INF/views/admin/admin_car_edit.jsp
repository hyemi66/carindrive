<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../include/admin_header.jsp" %>
 
  <div id="aMain_cont">
    <div id="aBw_wrap">
     <h2 class="aBw_title">차량 수정</h2>
     <form method="post" action="admin_car_edit_ok"
     onsubmit="return car_write_check();" enctype="multipart/form-data">
     <input type="hidden" name="c_num" value="${c.c_num}" />
     <input type="hidden" name="page" value="${page}" />
     <table id="aBw_t">
   				<tr>
					<th>차량 이름</th>
					<td><input name="c_name" id="c_name" size="14" 
					value="${c.c_name}"/></td>
				</tr>
				<tr>
					<th>차량 브랜드</th>
					<td><input name="c_brand" id="c_brand" size="14" 
					value="${c.c_brand}"/></td>
				</tr>
				<tr>
					<th>차량 년식</th>
					<td><input name="c_year" id="c_year" size="14" 
					value="${c.c_year}"/></td>
				</tr>
				<tr>
					<th>차량 색상</th>
					<td><input name="c_color" id="c_color" size="14" 
					value="${c.c_color}"/></td>
				</tr>
				<tr>
					<th>차량 상세차종</th>
					<td><input name="c_type" id="c_type" size="14" 
					value="${c.c_type}"/></td>
				</tr>
				<tr>
					<th>차량 차종</th>
					<td><input name="c_type2" id="c_type2" size="14" 
					value="${c.c_type2}"/></td>
				</tr>
				<tr>
					<th>차량 기름</th>
					<td><input name="c_oil" id="c_oil" size="14" 
					value="${c.c_oil}"/></td>
				</tr>
				<tr>
					<th>차량 가격</th>
					<td><input name="c_price" id="c_price" size="14" 
					value="${c.c_price}"/></td>
				</tr>
				<tr>
					<th>차량 이미지</th>
					<td><input type="file" name="c_img" /><br>${c.c_img}</td>
				</tr>
   </table>
   <div id="aBw_menu">
    <input type="submit" value="수정" />
    <input type="reset" value="취소" 
    onclick="$('#c_name').focus();" />
    <input type="button" value="목록"
    onclick="location='admin_car_list?page=${page}';" />
   </div>
     </form>
    </div>
  </div>
  
<jsp:include page="../include/admin_footer.jsp" /> 
