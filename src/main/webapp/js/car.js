/*car.js */

function car_write_check(){

	if($.trim($("#c_name").val())==""){
		alert("차량 이름을 입력하세요!");
		$("#c_name").val("").focus();
		return false;
	}
	if($.trim($("#c_brand").val())==""){
		alert("차량 브랜드를 입력하세요!");
		$("#c_brand").val("").focus();
		return false;
	}
	if($.trim($("#c_year").val())==""){
		alert("차량 연식을 입력하세요!");
		$("#c_year").val("").focus();
		return false;
	}
	if($.trim($("#c_color").val())==""){
		alert("차량 색상을 입력하세요!");
		$("#c_color").val("").focus();
		return false;
	}
	if($.trim($("#c_type").val())==""){
		alert("차량 상세차종을 입력하세요!");
		$("#c_type").val("").focus();
		return false;
	}
	if($.trim($("#c_type2").val())==""){
		alert("차량 차종을 입력하세요!");
		$("#c_type2").val("").focus();
		return false;
	}
	if($.trim($("#c_oil").val())==""){
		alert("차량 기름을 입력하세요!");
		$("#c_oil").val("").focus();
		return false;
	}
	if($.trim($("#c_price").val())==""){
		alert("차량 가격을 입력하세요!");
		$("#c_price").val("").focus();
		return false;
	}
	if($("#c_img").val()==""){
		alert("차량 이미지를 첨부하세요!");
		$("#c_img").focus();
		return false;
	}
	
	
}