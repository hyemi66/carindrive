$(document).ready(function() {
    $('#submit').click(function() {
    	//클라이언트가 refund_Check.jsp에서 입력한 값 저장
        const enteredName = $('#name').val().trim(); // 공백 제거
        const enteredPhone = $('#phone').val().trim().replace(/-/g, ''); // 입력받은 번호에서 - 제거

        const parentMemberName = window.opener.memberName;
		const parentMemberPhone = window.opener.memberPhone.replace(/-/g, '');  // "-" 제거

        console.log('enteredName:', enteredName); // 이름을 콘솔에 출력
        console.log('enteredPhone:', enteredPhone); // 전화번호를 콘솔에 출력
        console.log('nameElement:', nameElement); // nameElement를 콘솔에 출력
        console.log('phoneElement:', phoneElement); // phoneElement를 콘솔에 출력

        if (nameElement && phoneElement) {
            const parentPhone = phoneElement.innerText.trim().replace(/-/g, ''); // 부모 창의 번호에서 - 제거
            console.log('parentPhone:', parentPhone); // 부모 창의 전화번호를 콘솔에 출력
            if (enteredName === nameElement.innerText.trim() && enteredPhone === parentPhone) {
                window.isVerified = true; // isVerified가 true인 경우 폼 제출
                window.close();
            } else {
                alert("이름 또는 전화번호가 올바르지 않습니다.");
            }
        } else {
            alert("필요한 정보를 가져오지 못했습니다 다시 로그인 해주세요.");
            window.open('/', '_blank');
        }
    });
});