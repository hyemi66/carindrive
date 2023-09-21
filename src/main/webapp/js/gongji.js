/*gongji.js */

function gongji_write_check(){
	if($.trim($("#cs_title").val())==""){
		alert("공지제목을 입력하세요!");
		$("#cs_title").val("").focus();
		return false;
	}
	if($.trim($("#cs_cont").val())==""){
		alert("공지내용을 입력하세요!");
		$("#cs_cont").val("").focus();
		return false;
	}
}