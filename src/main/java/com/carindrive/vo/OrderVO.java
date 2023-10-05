package com.carindrive.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderVO {

    private long id;
    private String buyer_name;      // 구매자아이디
    private String buyer_phone;     // 구매자폰번호
    private String member_email;    // 구매자이메일
    private String buy_date;        // 결제일자
    private String product_name;
    private String merchant_Id;
    private String buy_product_name; // 결제한 물품
    private String buyer_buyid;     // 결제번호
    private String merchantId;      // 주문번호
    private long amount;            // 물품가격 (변수 타입은 long으로 유지)
    private String buyer_card_num;  // 카드번호
    private String buyer_pay_ok;    // 결제정보
    private Integer buyer_postcode; // (수정예정)
    private String refund;	//환불여부
    private String parent_merchant_id;	//추가 결제시 원래의 주문번호를 저장하는 공간
    
    public OrderVO() {}

    public OrderVO(long id, 
                      String buyer_name, 
                      String buyer_phone, 
                      String member_email, 
                      String buy_date, 
                      String buy_product_name, 
                      String buyer_buyid, 
                      String merchantId, 
                      long amount, 
                      String buyer_card_num, 
                      String buyer_pay_ok, 
                      Integer buyer_postcode,
                      String parent_merchant_id
    				  ) {
        this.id = id;
        this.buyer_name = buyer_name;
        this.buyer_phone = buyer_phone;
        this.member_email = member_email;
        this.buy_date = buy_date;
        this.buy_product_name = buy_product_name;
        this.buyer_buyid = buyer_buyid;
        this.merchantId = merchantId;
        this.amount = amount;
        this.buyer_card_num = buyer_card_num;
        this.buyer_pay_ok = buyer_pay_ok;
        this.buyer_postcode = buyer_postcode;
        this.parent_merchant_id = parent_merchant_id;
    }

 

	@Override
    public String toString() {
        return "Order_Info{" +
                "id=" + id +
                ", buyerName='" + buyer_name + '\'' +
                ", buyerPhone='" + buyer_phone + '\'' +
                ", memberEmail='" + member_email + '\'' +
                ", buyDate='" + buy_date + '\'' +
                ", productName='" + buy_product_name + '\'' +
                ", buyId='" + buyer_buyid + '\'' +
                ", merchantId='" + merchantId + '\'' +
                ", payPrice=" + amount +
                ", cardNum='" + buyer_card_num + '\'' +
                ", payStatus='" + buyer_pay_ok + '\'' +
                ", postcode=" + buyer_postcode +
                ", parent_merchant_id=" + parent_merchant_id +
                '}';
    }
	
    public void setPMerchantId(OrderVO order) {
        this.parent_merchant_id = order.getParent_merchant_id();
    }
}



