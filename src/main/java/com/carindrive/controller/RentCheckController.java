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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.carindrive.service.MemberService;
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
	private MemberService memberService;

	private static final Logger log = LoggerFactory.getLogger(RentCheckController.class);

	//렌탈 정보 저장
	@RequestMapping("/rent_Check")//rentOK에서 넘어온 데이터
	public ModelAndView rent_Check(@RequestParam("merchantId") String mId,
	        @ModelAttribute OrderVO order, // OrderVO 객체에 직접 매핑
	        BindingResult bindingResult, //바인딩 체크
	        HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
	    if (bindingResult.hasErrors()) {
	        log.error("Binding errors: " + bindingResult.getAllErrors());
	        mav.setViewName("/main/error");
	        return mav;
	    }
		try {
			// 로그인 정보 가져오기
			MemberVO loggedInUser = (MemberVO) session.getAttribute("loggedInUser");
			 // 렌탈 정보 가져오기
			RentalVO rental = this.rentService.getRentOne(loggedInUser.getM_id());
			//RentalVO에 예약번호를 이용해서 주문번호 추가
			this.rentService.insertMerchantId(mId, rental.getCr_num());
			// 데이터베이스에 OrderVO 정보 저장 (필요한 서비스 메서드를 호출)
	        this.rentService.saveOrder(order);

			// Order_Info 객체를 가져올 때 orderInfo의 타입을 선언해야 합니다.
			OrderVO orderInfo = getPayInfo(mId);

			mav.addObject("orderInfo", orderInfo); // JSP에서 사용할 수 있게 orderInfo를 모델에 추가
			mav.addObject("rental", rental);
			mav.setViewName("/rent/rent_Check"); //
		} catch (Exception e) {
			log.error("Error fetching payment info: ", e);
			mav.setViewName("/main/error"); // 에러 발생 시, errorPage로 리다이렉트
		}
		return mav;
		
	}
	
	
	//예약내역 확인
	@RequestMapping(value = "/rent_Check_List")
	public ModelAndView rent_Check_List(HttpSession session, RedirectAttributes rttr) {
		ModelAndView mav = new ModelAndView();
		MemberVO loggedInUser = (MemberVO) session.getAttribute("loggedInUser");	//로그인 정보를 가져옴
		
		if (loggedInUser != null) {//로그인이 되었을 때
			List<RentalVO> rental = this.rentService.getRentList(loggedInUser.getM_id());	//로그인 아이디로 렌트 정보 가져오기
			
		}else {
			// 로그인 정보가 없을 경우 로그인 페이지로 이동 또는 처리
			rttr.addFlashAttribute("LoginNull", "alert('로그인 이후 이용 가능합니다!');");
			mav.setViewName("redirect:/member/memberLogin");
			return mav;
		}
		
		mav.setViewName("/rent/rent_Check_List");
		return mav;
	}

//	//예약내역 확인
//	@RequestMapping(value = "/rent_Check_List", method = RequestMethod.GET)
//	public String rent_Check_List(Model model, HttpSession session, RedirectAttributes rttr) {
//		MemberVO loggedInUser = (MemberVO) session.getAttribute("loggedInUser");	//로그인 정보를 가져옴
//
//		try {
//			if (loggedInUser != null) {//로그인이 되었을 때
//				RentalVO rental = this.rentService.getRentOne(loggedInUser.getM_id());
//				CarVO car = this.rentService.getCarInfo(rental.getCar_id());	//렌탈비용 데이터베이스에 추가
//				List<OrderVO> order = this.rentService.getOrder(loggedInUser.getM_id());
//
//				//DecimalFormat 는 숫자의 출력형태를 변환한다.
//				DecimalFormat decimalFormat = new DecimalFormat("#,###");
//				String rental_cost_total = decimalFormat.format(rental.getRental_cost());
//
//				model.addAttribute("rental", rental);	//렌탈정보
//				model.addAttribute("order",order);
//				model.addAttribute("rental_cost_total",rental_cost_total);//렌트비용
//
//				return "/rent/rent_Check_List";
//			}else {
//				// 로그인 정보가 없을 경우 로그인 페이지로 이동 또는 처리
//				rttr.addFlashAttribute("LoginNull", "alert('로그인 이후 이용 가능합니다!');");
//				return "redirect:/member/memberLogin";
//			}//else
//		}catch (Exception e) {
//			return "/rent/rent_Check_List_Null";
//		}
//	}
	
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

	// 결제정보 메서드
	public OrderVO getPayInfo(String mId) throws Exception { 
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

		String token = getImportToken();//토큰생성

		HttpClient client = HttpClientBuilder.create().build(); 
		HttpGet get = new HttpGet(IMPORT_PAYMENTINFO_URL + mId + "/paid"); 
		get.setHeader("Authorization", token); 
		try { 
			HttpResponse res = client.execute(get);
			ObjectMapper mapper = new ObjectMapper(); 
			String body = EntityUtils.toString(res.getEntity()); 
			JsonNode rootNode = mapper.readTree(body); 
			JsonNode resNode = rootNode.get("response"); 
			log.info("wowwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww resNode: "+resNode);
			//amount = resNode.get("amount").asText(); 
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