   //환불시 이름과 연락처 입력후 검증
    $(document).ready(function() {
    	$('#submit').click(function() {
    		const enteredName = $('#name').val().trim(); //공백제거
    		const enteredPhone = $('#phone').val().trim().replace(/-/g, ''); // 입력받은 번호에서 - 제거

    		const nameElement = window.opener.document.querySelector('span[data-member-name]');
    		const phoneElement = window.opener.document.querySelector('span[data-member-phone]');

    		if (nameElement && phoneElement) {
    		    const parentPhone = phoneElement.innerText.trim().replace(/-/g, ''); // 부모 창의 번호에서 - 제거
    		    if (enteredName === nameElement.innerText.trim() && enteredPhone === parentPhone) {
    		        window.isVerified = true;	//isVerified가 true인 경우 폼 제출
    		        window.close();
    		    } else {
    		        alert("이름 또는 전화번호가 올바르지 않습니다.");
    		    }
    		} else {
    		    alert("필요한 정보를 가져오지 못했습니다 다시 로그인 해주세요.");
    		}
    	});
    });