//환불포함보기, 환불제외보기 스크립트
$(document).ready(function() {
    $('input[name="filter"]').change(function() {
        const value = $(this).val();
        if (value === "all") {
            $('.box').show();
        } else if (value === "notRefunded") {
            $('.box').each(function() {
                const paymentStatus = $(this).find('span[style="color: blue;"], span[style="color: red;"]').text().trim();
                if (paymentStatus === "환불완료") {
                    $(this).hide();
                } else {
                    $(this).show();
                }
            });
        }
    });

    //환불시 인증
    $('form[action="/rent/refund"]').submit(function(e) {
        e.preventDefault();

        const isConfirmed = confirm("정말로 환불하시겠습니까?");
        if (isConfirmed) {
            const popupWindow = window.open("refund_Check", "Member_Check", "width=600,height=350");
            popupWindow.focus();

            const self = this;
            popupWindow.onunload = function() {
                if (popupWindow.isVerified) {
                    self.submit();
                }
            }
        }
    });
});