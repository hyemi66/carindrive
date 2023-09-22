<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>시간 연장</title>
</head>
<body>
<form action="/rent/timeUpPay" method="post">
    <input type="hidden" name="c_num" id="c_num" value="${car.c_num}">
    현재 렌트중인 차량<br>
    ${car.c_name}
    <div id="menu01">
        <p>
            기존 반납시간<br>
            <input type="datetime-local" name="cr_sdate" id="cr_sdate" value="${rental.cr_edate}" required readonly>
        </p>
    </div>
    <div id="menu02">
        <p>
            반 납 하 는 시 간 <br>
            <input type="datetime-local" name="cr_edate" id="cr_edate" onchange="setMinValue()" required>
        </p>
    </div>
    <input type="submit" value="선택완료">
</form>

<script type="text/javascript">
    // 요소들에 대한 참조를 미리 가져옴
    let startDateElement = document.getElementById("cr_sdate");
    let endDateElement = document.getElementById("cr_edate");
    
    // 기존의 반납시간을 endDateElement의 min 속성으로 설정
    endDateElement.setAttribute("min", startDateElement.value);

    function setMinValue() {
        // 두 날짜 값을 비교
        if (new Date(endDateElement.value) < new Date(startDateElement.value)) {
            alert("기존의 반납시간보다 작은 시간은 설정할 수 없습니다.");
            endDateElement.value = startDateElement.value;
        }
    }
</script>

</body>
</html>
