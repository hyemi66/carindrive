/**
 * member.js
 */

function edit_check(){
	$m_pwd=$.trim($("#m_pwd").val());
	$m_pwd2=$.trim($("#m_pwd2").val());
	if($m_pwd == ""){
		alert("비번을 입력하세요!");
		$("#m_pwd").val("").focus();
		return false;
	}
	if($m_pwd2 == ""){
		alert("비번확인을 입력하세요!");
		$("#m_pwd2").val("").focus();
		return false;
	}
	if($m_pwd != $m_pwd2){
		alert("비번이 다릅니다!");
		$("#m_pwd").val("");//비번 입력박스를 초기화
		$("#m_pwd2").val("");
		$("#m_pwd").focus();
		return false;
	}
	if($.trim($("#m_name").val())==""){
		alert("회원이름을 입력하세요!");
		$("#m_name").val("").focus();
		return false;
	}
	if($.trim($("#m_phone").val())==""){
		alert("폰번호를 입력하세요!");
		$("#m_phone").val("").focus();
		return false;
	}
	if($.trim($("#m_email").val())==""){
		alert("이메일을 입력하세요!");		
		$("#m_email").val("").focus();
		return false;
	}
}//edit_check()