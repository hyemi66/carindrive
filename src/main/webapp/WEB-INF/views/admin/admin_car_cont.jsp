<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../include/admin_header.jsp" %>

<div id="aMain_cont">
 <div id="abbsCont_wrap">
  <h2 class="abbsCont_title">차량 상세보기</h2>
  <table id="abbsCont_t">
   <tr>
    <th>차량 코드</th> <td>${c.c_num}</td>
   </tr>
   <tr>
    <th>차량 이름</th> <td>${c.c_name}</td>
   </tr>
   <tr>
    <th>차량 브랜드</th> <td>${c.c_brand}</td>
   </tr>
   <tr>
    <th>차량 년식</th> <td>${c.c_year}</td>
   </tr>
   <tr>
    <th>차량 색상</th> <td>${c.c_color}</td>
   </tr>
   <tr>
    <th>차량 상세차종</th> <td>${c.c_type}</td>
   </tr>
   <tr>
    <th>차량 차종</th> <td>${c.c_type2}</td>
   </tr>
   <tr>
    <th>차량 기름</th> <td>${c.c_oil}</td>
   </tr>
   <tr>
    <th>차량 가격</th> <td>${c.c_price}</td>
   </tr>
   <tr>
    <th>차량 가능 여부</th> <td>${c.c_ok}</td>
   </tr>
   <tr>
    <th>차량 이미지</th><td><img src="./images/car/${c.c_img}" width="280"
						height="180" />
   </tr>

  </table>
  <div id="abbsCont_menu">
   <input type="button" value="목록"
   onclick="location='admin_car_list?page=${page}';" />
  </div>
 </div>
</div>

<%@ include file="../include/admin_footer.jsp" %>