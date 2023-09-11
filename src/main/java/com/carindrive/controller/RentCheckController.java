package com.carindrive.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.carindrive.service.OrderService;
import com.carindrive.service.RentService;
import com.carindrive.vo.MemberVO;
import com.carindrive.vo.OrderVO;
import com.carindrive.vo.RentalVO;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("/rent/*")
public class RentCheckController {
	
	@Autowired
	private RentService rentService;
	
	@Autowired
	private OrderService orderService;

	@Autowired
	private static final Logger log = LoggerFactory.getLogger(RentCheckController.class);

	//렌탈 정보 저장
	@RequestMapping("/rent_Check")//rentOK에서 넘어온 데이터
	public ResponseEntity<Map<String, Object>> rent_Check(
	        @RequestBody OrderVO order,
	        HttpSession session) {
		
	    Map<String, Object> map = new HashMap<>();
		 
		try {
			// 로그인 정보 가져오기
			MemberVO loggedInUser = (MemberVO) session.getAttribute("loggedInUser");
			// 해당 고객의 렌탈 정보 가져오기
			RentalVO rental = this.rentService.getRentOne(loggedInUser.getM_id());
			// 해당 렌탈정보에 예약번호에 맞는 주문번호 추가
	        String merchantId = order.getMerchantId();  // Assuming merchantId is part of OrderVO
	        this.rentService.insertMerchantId(merchantId, rental.getCr_num());
	        
			// 데이터베이스에 OrderVO 결제정보 저장
	        this.orderService.saveOrder(order);
	        System.out.println(order.getBuy_date());
	        System.out.println(order.getBuy_date());
	        System.out.println(order.getBuy_date());
	        System.out.println(order.getBuy_date());
	        System.out.println(order.getBuy_date());
	        System.out.println(order.getBuy_date());
	        System.out.println(order.getAmount());
	        System.out.println(order.getBuy_product_name());
	        System.out.println(order.getBuyer_buyid());
	        System.out.println(order.getBuyer_phone());
	        
	        // 결제정보 getPayInfo 메서드에 주문번호를 넣고
	        OrderVO orderInfo = getPayInfo(merchantId);

	        map.put("orderInfo", orderInfo);
	        map.put("rental", rental);
	        map.put("success", true);
	        map.put("redirectUrl", "/rent/rent_Check_List"); // 리디렉트할 URL 추가

	        
	        return new ResponseEntity<>(map, HttpStatus.OK);
	        
	    } catch (Exception e) {
	    	map.put("success", false);
	    	map.put("message", "결제 정보 처리 중 오류 발생 컨트롤러");
	        log.error("결제 정보 가져오기 오류: ", e);
	        return new ResponseEntity<>(map, HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}
	
	
	@RequestMapping(value = "/rent_Check_List")
	public ModelAndView rent_Check_List(HttpSession session, RedirectAttributes rttr) {
	    ModelAndView mav = new ModelAndView();
	    MemberVO loggedInUser = (MemberVO) session.getAttribute("loggedInUser");    //로그인 정보를 가져옴

	    if (loggedInUser != null) {//로그인이 되었을 때

	        // 렌트 정보 전체를 가져옴
	        List<RentalVO> rental = this.rentService.getRentList(loggedInUser.getM_id());
	        mav.addObject("rental", rental);
	        
	        //해당고객의 예약번호를 가져오는 메서드 (OrderVO에 바인딩)
	        List<OrderVO> orders = this.orderService.getId(loggedInUser.getM_id());
	        
	        //예약정보가 여러가지 일수도 있으므로 리스트 제작
	        List<OrderVO> orderInfos = new ArrayList<>();

	        for(OrderVO order : orders) {
	        	//리스트에 있는 예약들을 분류함
	            OrderVO orderInfo = orderService.getOrder(order.getId());
	            
	            //분류된 리스트들을 정리해서 orderInfos에 추가
	            orderInfos.add(orderInfo);
	        }

	        mav.addObject("orderInfos", orderInfos);

	    } else {
	        // 로그인 정보가 없을 경우 로그인 페이지로 이동 또는 처리
	        rttr.addFlashAttribute("LoginNull", "alert('로그인 이후 이용 가능합니다!');");
	        mav.setViewName("redirect:/member/memberLogin");
	        return mav;
	    }

	    mav.setViewName("/rent/rent_Check_List");
	    return mav;
	}
	
	//환불 관련 메서드

	//토큰을 받아오는 코드
	// IAMPORT의 API 키와 시크릿
	private static final String API_KEY = "6723566850304883";
	private static final String API_SECRET = "0HPz5ReT4GqEPChHkVJas7cdWUdBhlXrFY6Ny9YrB6J3Q9ad9zpfzeMSlZx260IcSFIGnLfxWYSkw3By";
	public static final String IMPORT_PAYMENTINFO_URL = "https://api.iamport.kr/payments/find/";

	//토큰 얻어오기
	private String getImportToken() throws Exception {
		String tokenUrl = "https://api.iamport.kr/users/getToken";
		RestTemplate restTemplate = new RestTemplate();

		Map<String, String> params = new HashMap<>();
		params.put("imp_key", API_KEY);
		params.put("imp_secret", API_SECRET);

		// HttpEntity 객체를 생성하여 본문과 헤더를 함께 전달합니다.
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<Map<String, String>> entity = new HttpEntity<>(params, headers);

		ResponseEntity<Map> response = restTemplate.postForEntity(tokenUrl, entity, Map.class);

		if (response.getStatusCode() == HttpStatus.OK && response.getBody().get("code").equals(0)) {
			Map<String, Object> responseData = (Map<String, Object>) response.getBody().get("response");
			String accessToken = (String) responseData.get("access_token");

			// 얻은 토큰을 콘솔에 출력
			System.out.println("IAMPORT Access Token: " + accessToken);

			return accessToken;
		} else {
			throw new Exception("IAMPORT token request failed: " + response.getBody().get("message"));
		}
	}

	// 결제정보 조회 메서드
	public OrderVO getPayInfo(String merchantId) throws Exception { 
		String buyer_name = "";
		String buyer_phone = "";
		String member_email = "";
		String buyer_addrStr = "";
		String buyer_postcode = "";
		String buyer_addr = "";
		String paid_at = "";
		String buy_product_name = "";
		String buyer_buyid = "";
		String buyer_merid = "";
		String amount = "";
		String buyer_card_num = "";
		String buyer_pay_ok = "";
		long buyer_pay_price = 0L;
		long paid_atLong = 0L;
		long unixTime = 0L;
		Date date = null;

		String token = getImportToken();	//토큰생성 API요청 인증에 활용

		//HttpClient를 사용하여 API에게 요청을 보냄
		HttpClient client = HttpClientBuilder.create().build(); 
		HttpGet get = new HttpGet(IMPORT_PAYMENTINFO_URL + merchantId + "/paid"); //merchantId를 보낸 이유
		get.setHeader("Authorization", token); 
		try { 
			HttpResponse res = client.execute(get);
			ObjectMapper mapper = new ObjectMapper(); 
			String body = EntityUtils.toString(res.getEntity()); 
			JsonNode rootNode = mapper.readTree(body); 
			JsonNode resNode = rootNode.get("response"); 
			log.info("wowwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww resNode: "+resNode);
			
			// API에게 받은 응답은 JsonNode방식으로 파싱됨
			///JsonNode에 저장되어 있는 값들을 변수에 저장
			buyer_name = resNode.get("buyer_name").asText(); 
			buyer_phone = resNode.get("buyer_tel").asText(); 
			member_email = resNode.get("buyer_email").asText(); 

			buyer_addrStr = resNode.get("buyer_addr").asText(); 
			buyer_postcode = resNode.get("buyer_postcode").asText(); 
			buyer_addr = buyer_addrStr+" "+buyer_postcode; //주소에 우편번호 합치기

			paid_at = resNode.get("paid_at").asText(); //결제시간
			buy_product_name = resNode.get("name").asText(); 
			buyer_buyid = resNode.get("imp_uid").asText(); 
			buyer_merid = resNode.get("merchant_uid").asText(); 
			amount = resNode.get("amount").asText();
			buyer_card_num = resNode.get("apply_num").asText(); 
			buyer_pay_ok = resNode.get("status").asText(); 



			log.info("++++++++++++++++++++++++++++++++++++import buyer_name: "+buyer_name);
			log.info("++++++++++++++++++++++++++++++++++++import paid_at: "+paid_at);

		} catch (Exception e) { 
			e.printStackTrace(); 
		} 

		buyer_pay_price = Long.parseLong(amount);

		// 카드 결제 시간 - 형식 바꾸기
		paid_atLong = Long.parseLong(paid_at);
		unixTime = paid_atLong * 1000;
		date = new Date(unixTime);

		// 형식 바꾸기
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		sdf.setTimeZone(TimeZone.getTimeZone("GMT+9")); // GMT(그리니치 표준시 +9 시가 한국의 표준시
		String buy_date = sdf.format(date);
		log.info("++++++++++++++++++++++++++++++++++++import date: "+buy_date);

		OrderVO order_info = new OrderVO(-1L, buyer_name, buyer_phone, member_email, 
				buyer_addr, buy_date, buy_product_name, buyer_buyid, buyer_merid, 
				buyer_pay_price, buyer_card_num, buyer_pay_ok, -1);

		return order_info;
	}

	//환불하기 기능
	@PostMapping("/refund")
	public void refund(@RequestParam String order_index, @RequestParam String order_number,
			HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		long order_index2 = Long.parseLong(order_index);

		String token = getImportToken();
		
		if (token == null || token.isEmpty()) {
			out.println("<script>");
			out.println("alert('환불도중 문제가 발생되었습니다! 다시 시도해주세요!');");
			out.println("location.href='/';");
			out.println("</script>");
		}

		int result_delete = cancelPay(token, order_number);

		if(result_delete == -1) {
			out.println("<script>");
			out.println("alert('환불에 실패 했습니다 다시 시도해주세요!');");
			out.println("location.href='/';");
			out.println("</script>");

		} else {
			out.println("<script>");
			out.println("alert('환불이 완료 되었습니다!');");
			out.println("location.href='/';");
			out.println("</script>");
		}
	}


	public static final String IMPORT_CANCEL_URL = "https://api.iamport.kr/payments/cancel"; 

	//환불 메서드
	public int cancelPay(String token, String mid) { 
		CloseableHttpClient client = HttpClientBuilder.create().build();
		HttpPost post = new HttpPost(IMPORT_CANCEL_URL); 
		Map<String, String> map = new HashMap<String, String>(); 
		post.setHeader("Authorization", token); 
		map.put("merchant_uid", mid); 

		try { 
			post.setEntity(new UrlEncodedFormEntity(convertParameter(map), "UTF-8")); 
			CloseableHttpResponse res = client.execute(post); 

			if (res.getStatusLine().getStatusCode() != 200) {
				System.err.println("환불 요청 실패: " + res.getStatusLine().getReasonPhrase());
				return -1;
			}

			String responseBody = EntityUtils.toString(res.getEntity());
			ObjectMapper mapper = new ObjectMapper(); 
			JsonNode rootNode = mapper.readTree(responseBody);

			if (rootNode.has("response") && !rootNode.get("response").isNull()) {
				System.out.println("환불성공");
				return 1;
			} else {
				System.err.println("환불실패");
				return -1;
			}

		} catch (Exception e) {
			e.printStackTrace(); 
			System.err.println("환불 요청 중 오류 발생");
			return -1;
		} finally {
			try {
				client.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}


	private List<NameValuePair> convertParameter(Map<String, String> params) {
		List<NameValuePair> paramList = new ArrayList<>();
		for (Map.Entry<String, String> entry : params.entrySet()) {
			paramList.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
		}
		return paramList;
	}



}