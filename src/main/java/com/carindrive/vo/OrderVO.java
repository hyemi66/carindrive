package com.carindrive.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderVO {

    private long id;
    private String buyer_name;      // 수정된 이름
    private String buyer_phone;     // 수정된 이름
    private String member_email;    // 수정된 이름
    private String buyer_addr;      // 수정된 이름
    private String buy_date;        // 수정된 이름
    private String buy_product_name; // 수정된 이름
    private String buyer_buyid;     // 수정된 이름
    private String merchantId;      // 유지
    private long amount;            // 수정된 이름 (변수 타입은 long으로 유지)
    private String buyer_card_num;  // 수정된 이름
    private String buyer_pay_ok;    // 수정된 이름 (변수 타입은 String으로 유지)
    private Integer buyer_postcode; 
    
    public OrderVO() {}

    public OrderVO(long id, 
                      String buyer_name, 
                      String buyer_phone, 
                      String member_email, 
                      String buyer_addr, 
                      String buy_date, 
                      String buy_product_name, 
                      String buyer_buyid, 
                      String merchantId, 
                      long amount, 
                      String buyer_card_num, 
                      String buyer_pay_ok, 
                      Integer buyer_postcode) {
        this.id = id;
        this.buyer_name = buyer_name;
        this.buyer_phone = buyer_phone;
        this.member_email = member_email;
        this.buyer_addr = buyer_addr;
        this.buy_date = buy_date;
        this.buy_product_name = buy_product_name;
        this.buyer_buyid = buyer_buyid;
        this.merchantId = merchantId;
        this.amount = amount;
        this.buyer_card_num = buyer_card_num;
        this.buyer_pay_ok = buyer_pay_ok;
        this.buyer_postcode = buyer_postcode;
    }

 

	@Override
    public String toString() {
        return "Order_Info{" +
                "id=" + id +
                ", buyerName='" + buyer_name + '\'' +
                ", buyerPhone='" + buyer_phone + '\'' +
                ", memberEmail='" + member_email + '\'' +
                ", buyerAddress='" + buyer_addr + '\'' +
                ", buyDate='" + buy_date + '\'' +
                ", productName='" + buy_product_name + '\'' +
                ", buyId='" + buyer_buyid + '\'' +
                ", merchantId='" + merchantId + '\'' +
                ", payPrice=" + amount +
                ", cardNum='" + buyer_card_num + '\'' +
                ", payStatus='" + buyer_pay_ok + '\'' +
                ", postcode=" + buyer_postcode +
                '}';
    }
}

