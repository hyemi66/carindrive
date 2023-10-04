<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>정보 확인</title>
    <link href="${path}/css/refund.css" rel="stylesheet" />
    <script src="${path}/js/jquery.js"></script>
    
</head>

<body>

    
    <h2>본인 인증</h2>
    <hr>
    <form method="post">
    <div class="form-group">
        <label for="mPwd">비밀번호:</label>
        <input type="password" id="mPwd" name="mPwd" placeholder="비밀번호를 입력해주세요.">
    </div>
    <button id="submit">환불하기</button>
    </form>
 
<script>
    $(document).ready(function() {
        $("#submit").click(function(e) {
            e.preventDefault(); // 폼의 기본 제출을 방지

            $.ajax({
                type: "POST",
                url: "/rent/refund_Check",
                data: { mPwd: $("#mPwd").val() },
                success: function(map) {
                    console.log(map);  // 전체 응답 확인

                    if (map.authSuccess) {
                        console.log("인증 완료");
                        submitMainForm();
                    } else {
                        alert("비밀번호 인증에 실패했습니다.");
                    }
                },
                error: function() {
                    alert("세션이 만료되었습니다. 다시 로그인 해주세요");
                    window.close(); // 팝업 창 닫기
                    window.opener.close();
                }
            });
        });
    });

    function submitMainForm() {
        window.opener.document.getElementById('refundForm').submit();
        window.close();
    }
</script>
 

    





    
</body>
</html>
