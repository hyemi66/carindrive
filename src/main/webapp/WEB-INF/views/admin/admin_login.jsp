<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인</title>
<link rel="stylesheet" type="text/css" href="./css/admin.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
 function admin_check(){
    if($.trim($("#ca_id").val()) == ""){
       alert("관리자 아이디를 입력하세요!");
       $("#ca_id").val("").focus();
       return false;
    }
    if($.trim($("#ca_pwd").val()) == ""){
       alert("관리자 비번을 입력하세요!");
       $("#ca_pwd").val("").focus();
       return false;
    }
 }
</script>
</head>
<body>
	<h2 align="center">관리자 로그인</h2>
	<div id="Login_wrap">
			<div id="logo">
				<hr>
				CARINDRIVE
				<hr>
			</div>
			<form action="admin_login_ok"
			method="post" onsubmit="return admin_check();">
			<div id="log_form">
				<div id="id_form">
					<input id="ca_id" name="ca_id" placeholder="관리자 아이디"
					onfocus="this.placeholder=''" onblur="this.placeholder='관리자 아이디'">
					
				</div>
				<div id="pwd_form">
					<input type="password" id="ca_pwd" name="ca_pwd" placeholder=" 관리자 비밀번호"
					onfocus="this.placeholder=''" onblur="this.placeholder='관리자 비밀번호'">
					
				</div><%--pwd_form --%>
				<div id="button_form">
					 <input type="submit" value="로그인" id="btn1">
				</div>
			</div>
			</form>
			<div id="ano">
				<span>CARINDRIVE&nbsp;&nbsp;&#124;</span>
				<span> Copyright&nbsp;</span>
				<span>All Rights Reserved.</span>
			</div>
	</div>
</body>
</html>