package com.carindrive.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.carindrive.CarPwdCh;
import com.carindrive.service.OrderService;
import com.carindrive.service.RentService;
import com.carindrive.vo.CarVO;
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
	@RequestMapping("/rent_Check")//rentOK.jsp에서 넘어온 데이터
	public ResponseEntity<Map<String, Object>> rent_Check(@RequestBody OrderVO order,HttpSession session) {
		System.out.println("rent_Check 메서드 동작");

		Map<String, Object> map = new HashMap<>();

		try {
			// 로그인 정보 가져오기
			MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
			// 해당 고객의 렌탈 정보 가져오기
			RentalVO rental = this.rentService.getRentOne(memberInfo.getM_id());
			// 해당 렌탈정보에 예약번호에 맞는 주문번호 추가
			String merchantId = order.getMerchantId();
			this.rentService.insertMerchantId(merchantId, rental.getCr_num());

			// 결제정보 getPayInfo 메서드에 주문번호를 넣고 OrderVO에 값들을 셋팅
			OrderVO orderInfo = getPayInfo(merchantId);

			// 데이터베이스에 OrderVO 결제정보 저장
			this.orderService.saveOrder(orderInfo);
			//결제 완료시 렌탈테이블의 wait를 clear로 변경 (주문번호 기준)
			this.rentService.rentalStatus(orderInfo.getMerchantId());
			//렌탈 테이블의 차량정비시간을 설정 (반납시간의 +3시간)
			this.rentService.waitTime(orderInfo.getMerchantId());

			System.out.println("현재 렌트하는 차량이름: "+rental.getCr_cname());

			map.put("orderInfo", orderInfo);
			map.put("rental", rental);
			map.put("success", true);
			map.put("redirectUrl", "/rent/rent_Check_List"); // 리디렉트할 URL 추가



			return new ResponseEntity<>(map, HttpStatus.OK);

		} catch (Exception e) {//결제시 문제 발생
			try {
				// 환불 처리 시작
				String token = getImportToken();

				if (token == null || token.isEmpty()) {
					log.error("인증 정보에 문제가 발생했습니다. 환불 처리를 위해 다시 시도해주세요.");
				} else {
					double refundAmount = order.getAmount(); // 주문에서 환불 금액을 가져옴
					int result_delete = cancelPay(token, order.getMerchantId(), refundAmount); 

					if (result_delete == -1) {
						log.error("환불에 실패했습니다. 다시 시도해주세요.");
					} else {
						this.orderService.refundOK(order.getMerchantId()); // 환불 완료시 refund 업데이트
						log.info("환불이 완료되었습니다.");
					}
				}// 환불 처리 종료

			} catch (Exception refundException) {
				log.error("환불 처리 중 오류 발생: ", refundException);

				// 경고창을 띄우고 서비스 센터로 리디렉션
				map.put("redirectUrl", "/service/service_center");
				map.put("message", "환불 처리 중 오류가 발생했습니다. 1:1 문의를 통해 문제를 알려주세요.");
				map.put("success", false);

				return new ResponseEntity<>(map, HttpStatus.INTERNAL_SERVER_ERROR);
			}

			map.put("success", false);
			map.put("message", "결제 정보 처리 중 오류 발생 컨트롤러");
			log.error("결제 정보 가져오기 오류: ", e);
			return new ResponseEntity<>(map, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	//예약 확인
	@RequestMapping(value = "/rent_Check_List")
	public ModelAndView rent_Check_List(HttpSession session, RedirectAttributes rttr) {
		ModelAndView mav = new ModelAndView();

		MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");

		try {
			if (memberInfo != null) {//로그인시
				List<RentalVO> rentals = this.rentService.getRentList(memberInfo.getM_id());//아이디를 기준으로 렌트정보를 다가져옴
				Map<String, RentalVO> rentalMap = new HashMap<>(); 	//키,값으로 담기위해 map 생성
				for (RentalVO rental : rentals) {					//(RentalVO)rentals를 rental로 한개씩 뽑아서 키,값으로 저장
					rentalMap.put(rental.getCr_order(), rental);	//주문번호, 렌탈정보로 저장시킴 주문번호 호출시 렌탈정보 전체가 호출됨
				}

				mav.addObject("rentalMap", rentalMap);
				mav.addObject("rentals", rentals);

				List<OrderVO> orders = this.orderService.getCashInfo(memberInfo.getM_id());
				List<OrderVO> orderInfos = new ArrayList<>();

				List<CarVO> carInfos = new ArrayList<>(); 


				for (OrderVO order : orders) {
					OrderVO orderInfo = orderService.getOrder(order.getId());
					orderInfos.add(orderInfo);
				}

				//정렬
				Collections.sort(orderInfos, Comparator.comparing(OrderVO::getBuy_date).reversed());

				//결제정보를 한개씩 추출함
				for (OrderVO order : orderInfos) {
					CarVO carInfo = null;
					//차량 정보를 불러오는 mybatis문 orders에 들어있는 차량 이름으로 검색

					//결제내역에서 예약한 차량의 이름을 ""(공백)으로 구분함
					String[] parts = order.getBuy_product_name().split(" ");
					String carName = parts[2];	//0부터 시작하는 인덱스중 2번째 값을 carName에 저장시킴 ex) 2023년식 WHITE '레이' 시간연장

					//쿼리문 Like을 돌리기위해 와일드카드 사용 //차량명이 겹치지 않아서 like문을 사용
					//다음에 프로젝트를 다시 진행한다면 carname이 아닌 carnumber를 기준으로 할것
					//carName = "%"+carName+"%";
					carName = "%"+carName;
					carInfo = this.rentService.getCarInfo(carName);	//차량정보를 carName을 기준으로 가져옴
					carInfos.add(carInfo);	//객체에 저장시킴
				}

				mav.addObject("memberInfo", memberInfo);
				mav.addObject("carInfos", carInfos);
				mav.addObject("orderInfos", orderInfos);
			} else {
				rttr.addFlashAttribute("LoginNull", "alert('로그인 이후 이용 가능합니다!');");
				mav.setViewName("redirect:/member/m_login");
				return mav;
			}

			mav.setViewName("/rent/rent_Check_List");
			return mav;
		} catch (Exception e) {
			e.printStackTrace();
			mav.setViewName("/rent/rent_Check_List");
			return mav;
		}
	}

	//예약내역 상세보기
	@RequestMapping(value="/rent_details")
	public ModelAndView rent_details(@RequestParam("merchantId") String merchantId,
			@RequestParam("carname") String carName, HttpSession session, HttpServletResponse response) 
					throws IOException {
		System.out.println("rent_details메서드 동작");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		ModelAndView model = new ModelAndView();
		//로그인정보
		MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");

		if (memberInfo == null) {
			out.println("<script>");
			out.println("window.close()");				//현재창을 닫고
			out.println("opener.location.reload();"); 	//부모창을 새로고침
			out.println("</script>");
			return null;
		}

		//차량 정보 가져오기
		CarVO carInfo = this.rentService.getCarInfo(carName);
		//렌탈 정보 가져오기
		RentalVO rentalInfo = this.rentService.getRentCar(merchantId);
		//결제내역
		OrderVO orderInfo = this.orderService.getOrder2(merchantId);
		System.out.println("주문번호: "+merchantId);

		model.addObject("memberInfo", memberInfo);
		model.addObject("carInfo",carInfo);
		model.addObject("rentalInfo",rentalInfo);
		model.addObject("orderInfo",orderInfo);

		return model;
	}

	//시간 연장 코드
	@RequestMapping(value="/timeUp")
	public ModelAndView timeUp(@RequestParam int c_num,
			@RequestParam String order_number, 
			HttpSession session, RedirectAttributes rttr) 
					throws Exception {
		System.out.println("timeUp메서드 동작");
		System.out.println("차량 코드번호: "+c_num);//차량코드번호
		System.out.println("결제 주문번호: "+order_number);//차량코드번호

		ModelAndView model = new ModelAndView();

		// 로그인 정보 가져오기
		MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
		if(memberInfo != null) {

			//해당 아이디의 결제 중단 내역들을 전부 제거	
			this.rentService.rentalDel2(memberInfo.getM_id());
			System.out.println("결제중단 내역들 삭제후 차량 출력");

			//해당 차량의 정보 가져오기
			CarVO car = this.rentService.getCarInfo2(c_num);
			System.out.println("car정보: "+car);
			//렌트 정보 가져오기
			RentalVO rental = this.rentService.getRentCar(order_number);
			System.out.println("rental정보: "+rental);

			model.addObject("rental",rental);
			model.addObject("car",car);

			return model;
		}else {
			rttr.addFlashAttribute("LoginNull", "alert('로그인 이후 이용 가능합니다!');");
			model.setViewName("redirect:/member/m_login");
			return model;
		}
	}


	//시간 정보를 계산하는 메서드
	@RequestMapping(value="/calculatePrice")
	@ResponseBody
	public double calculatePrice(@RequestParam int c_num, 
			@RequestParam String order_number, 
			@RequestParam String cr_edate) throws Exception {

		// 1. 차량 정보와 대여 정보 가져오기
		CarVO car = this.rentService.getCarInfo2(c_num);
		RentalVO rental = this.rentService.getRentCar(order_number);

		// 2. 기존 반납시간과 새로운 반납시간의 차이 계산
		cr_edate = cr_edate.replace("T", " ");
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		LocalDateTime originalEndDate = LocalDateTime.parse(rental.getCr_edate(), formatter);
		LocalDateTime newEndDate = LocalDateTime.parse(cr_edate, formatter);

		Duration duration = Duration.between(originalEndDate, newEndDate);
		long minutes = duration.toMinutes();

		if (minutes > 120) {
			throw new Exception("시간 연장은 최대 2시간까지만 가능합니다.");
		}

		// 3. 차량의 가격 정보를 이용해 연장시간의 가격 계산
		double perMinuteRate = car.getC_price();
		double price = perMinuteRate * minutes;
		return price;
	}


	//시간추가 결제창
	@RequestMapping(value="/timeUpPay", method=RequestMethod.POST)
	public ModelAndView timeUpPay(
			@RequestParam("c_num") int cNum, 
			@RequestParam("order_number") String orderNumber, 
			@RequestParam("calculatedPrice") double calculatedPrice,
			@RequestParam("cr_sdate") String sDate,
			@RequestParam("cr_edate") String eDate,
			HttpSession session) {//주문번호를 전달받은 이유는 해당차량의 데이터베이스에 접근하기 위함
		System.out.println("timeUpPay메서드 동작");
		ModelAndView model = new ModelAndView();
		// 현재 날짜 가져오기
		Date d = new Date();
		SimpleDateFormat s = new SimpleDateFormat("yyyy년 MM월 dd일 aa hh시 mm분");
		String cr_rdate = s.format(d);

		//로그인정보
		MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");

		//차정보 가져오기
		CarVO car = this.rentService.getCarInfo2(cNum);

		//날짜와 시간의 경계선인 T문자열을 공백처리
		String cr_edate = eDate;
		cr_edate = cr_edate.replace("T", " ");

		//렌탈정보 셋팅
		RentalVO rental = new RentalVO();
		rental.setCr_mid(memberInfo.getM_id()); rental.setCr_cname(car.getC_name()); rental.setCr_rdate(cr_rdate);
		rental.setCr_sdate(sDate);	rental.setCr_edate(cr_edate);	rental.setCr_price(calculatedPrice);
		rental.setCr_order(orderNumber);
		System.out.println("셋팅후 렌탈정보: "+rental);
		// 메서드 내에서 전달받은 정보들을 활용
		System.out.println("c_num: " + cNum);
		System.out.println("order_number: " + orderNumber);
		System.out.println("calculatedPrice: " + calculatedPrice);

		this.rentService.insertRental(rental);

		//5분안에 결제를 진행안하고 취소를 하면 해당 렌트내역은 5분뒤에 사라지고, 5분동안 해당차량 렌트 불가
		this.rentService.rentalDel();

		System.out.println("rental정보: "+rental);

		model.addObject("memberInfo", memberInfo);//결제내역에 사용되는 model들
		model.addObject("car", car);
		model.addObject("rental", rental);

		return model;
	}

	//본인 인증 메서드 
	@RequestMapping(value="refund_Check")
	public ModelAndView refund_Check(HttpSession session, HttpServletRequest request) throws Exception {
		System.out.println("refund_Check (GET)메서드 동작");

		ModelAndView model = new ModelAndView();//

		return model;//
	}

	@RequestMapping(value="refund_Check", method = RequestMethod.POST)
	@ResponseBody  // JSON 형태로 응답하기 위한 어노테이션 추가
	public Map<String, Object> refund_Check(HttpSession session, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		Map<String, Object> map = new HashMap<>();
		System.out.println("refund_Check (POST) 메서드 동작");
		MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo"); //로그인정보

		if(memberInfo == null) {
			map.put("status", "error");
			map.put("message", "로그인 이후 이용 가능합니다!");
			return map;
		}

		String mPwd = request.getParameter("mPwd");
		System.out.println("암호화 전: "+mPwd);

		if(mPwd != null) {//사용자에게 값을 입력 받은 뒤
			mPwd = CarPwdCh.getPassWordToXEMD5String(mPwd);
			System.out.println("암호화 후: "+mPwd);
			if (memberInfo.getM_pwd().equals(mPwd)) {
				System.out.println("map인증완료");
				map.put("authSuccess", true);
			} else {
				map.put("authSuccess", false);
			}
		}
		return map;
	}


	//렌탈 정보 저장 및 결제
	@RequestMapping("/pay_Check")//timeUpPay.jsp에서 넘어온 데이터를 처리 
	public ResponseEntity<Map<String, Object>> pay_Check(@RequestBody OrderVO order, HttpSession session) {
		System.out.println("pay_Check메서드 동작");
		Map<String, Object> map = new HashMap<>();

		try {
			// 로그인 정보 가져오기
			MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
			// 해당 고객의 렌탈 정보 가져오기
			RentalVO rental = this.rentService.getRentOne(memberInfo.getM_id());
			System.out.println("pay_Check메서드의 rental정보: "+rental);
			// 해당 렌탈정보에 예약번호에 맞는 주문번호 추가
			String merchantId = order.getMerchantId();
			this.rentService.insertMerchantId(merchantId, rental.getCr_num());

			//결제정보 getPayInfo 메서드에 주문번호를 넣고 OrderVO에 값들을 셋팅
			OrderVO orderInfo = getPayInfo(merchantId);
			orderInfo.setPMerchantId(order); //저장하기전 전달받은 원래의 주문번호를 orderInfo에 셋팅

			//RentalVO rental = this.rentService.getRentCar(order.getParent_merchant_id());
			System.out.println("기존 렌탈 정보: "+rental);

			//결제된 품목에서 차량의 정보를 얻기위해 값을 추출
			String productName = order.getBuy_product_name(); // 예를 들어서 "2019년식 BLACK A4 시간연장" 이 문자를
			String[] parts = productName.split(" "); // 공백을 기준으로 문자열을 나눔

			String year = parts[0]; // "2019년식"
			String color = parts[1]; // "BLACK"
			String carName = parts[2]; // "A4"

			System.out.println("년식: " + year);
			System.out.println("색상: " + color);
			System.out.println("차량명: " + carName);

			CarVO car = this.rentService.getCarInfo(carName);
			System.out.println("차량 정보 : "+car);

			// 데이터베이스에 OrderVO 결제정보 저장
			this.orderService.saveOrder(orderInfo);
			this.orderService.addTime(orderInfo.getMerchantId());
			//결제 완료시 렌탈테이블의 wait를 clear로 변경 (주문번호 기준)
			this.rentService.rentalStatus(orderInfo.getMerchantId());

			//현재 레코드에서 부모키로 부모의 레코드에 접근
			String key = orderInfo.getParent_merchant_id();
			//부모의 레코드를 가져옴
			RentalVO pKey = this.rentService.getRentCar(key);
			System.out.println("부모의 레코드: "+pKey);
			//부모키의 waitTime을 저장
			String waitTime = pKey.getCr_waitTime();

			//현재 결제한 레코드를 가져옴
			RentalVO myKey = this.rentService.getRentCar(orderInfo.getMerchantId());
			//null이었던 waitTime에 값을 주입시킴
			myKey.setCr_waitTime(waitTime);
			System.out.println("myKey의 값: "+myKey);
			//DB에 저장
			this.rentService.insertTime(myKey);
			System.out.println("DB저장완료");


			System.out.println("시간추가 완료");
			//주문번호 기준
			String oldOrder = orderInfo.getParent_merchant_id();
			// 기존예약은 정상결제 -> 시간연장 으로 바꿈
			this.orderService.addTime(oldOrder);

			map.put("orderInfo", orderInfo);
			map.put("rental", rental);
			map.put("car", car);
			map.put("success", true);
			map.put("redirectUrl", "/rent/rent_Check_List"); // 리디렉트할 URL 추가

			return new ResponseEntity<>(map, HttpStatus.OK);

		} catch (Exception e) {//결제시 문제 발생
			try {
				// 환불 처리 시작
				String token = getImportToken();

				if (token == null || token.isEmpty()) {
					log.error("인증 정보에 문제가 발생했습니다. 환불 처리를 위해 다시 시도해주세요.");
				} else {
					double refundAmount = order.getAmount(); // 주문에서 환불 금액을 가져옴
					int result_delete = cancelPay(token, order.getMerchantId(), refundAmount); 

					if (result_delete == -1) {
						log.error("환불에 실패했습니다. 다시 시도해주세요.");
					} else {
						this.orderService.refundOK(order.getMerchantId()); // 환불 완료시 refund 업데이트
						log.info("환불이 완료되었습니다.");
					}
				}// 환불 처리 종료

			} catch (Exception refundException) {
				log.error("환불 처리 중 오류 발생: ", refundException);

				// 경고창을 띄우고 서비스 센터로 리디렉션
				map.put("redirectUrl", "/service/service_center");
				map.put("message", "환불 처리 중 오류가 발생했습니다. 1:1 문의를 통해 문제를 알려주세요.");
				map.put("success", false);

				return new ResponseEntity<>(map, HttpStatus.INTERNAL_SERVER_ERROR);
			}

			map.put("success", false);
			map.put("message", "결제 정보 처리 중 오류 발생 컨트롤러");
			log.error("결제 정보 가져오기 오류: ", e);
			return new ResponseEntity<>(map, HttpStatus.INTERNAL_SERVER_ERROR);
		}
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
		String parent_merchant_id="";

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

			paid_at = resNode.get("paid_at").asText(); //결제시간
			buy_product_name = resNode.get("name").asText(); 
			buyer_buyid = resNode.get("imp_uid").asText(); 
			buyer_merid = resNode.get("merchant_uid").asText(); 
			amount = resNode.get("amount").asText();
			buyer_card_num = resNode.get("apply_num").asText(); 
			buyer_pay_ok = resNode.get("status").asText(); 
			//buy_date = resNode.get("buy_date").asText(); 



			log.info("++++++++++++++++++++++++++++++++++++import buyer_name: "+buyer_name);
			log.info("++++++++++++++++++++++++++++++++++++import paid_at: "+paid_at);

		} catch (Exception e) { 
			e.printStackTrace(); 
		} 

		buyer_pay_price = Long.parseLong(amount);

		// 결제 시간 - 형식 바꾸기
		paid_atLong = Long.parseLong(paid_at);
		unixTime = paid_atLong * 1000;
		date = new Date(unixTime);

		// 형식 바꾸기
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		sdf.setTimeZone(TimeZone.getTimeZone("GMT+9")); // GMT(그리니치 표준시 +9 시가 한국의 표준시

		String buy_date = sdf.format(date);	//paid_at를 이용해서 생성된 buy_date
		log.info("++++++++++++++++++++++++++++++++++++import date: "+buy_date);


		OrderVO order_info = new OrderVO(-1L, buyer_name, buyer_phone, member_email, 
				buy_date, buy_product_name, buyer_buyid, buyer_merid, 
				buyer_pay_price, buyer_card_num, buyer_pay_ok, -1, parent_merchant_id);

		return order_info;
	}

	//환불하기 기능
	@PostMapping("/refund")
	public void refund(@RequestParam String order_number, HttpServletResponse response, HttpSession session) throws Exception {
		System.out.println("refund메서드 동작");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		try {
			// 로그인 고객정보 가져오기
			MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");

			// 해당 아이디의 모든 렌트 정보를 가져옴
			List<RentalVO> rentals = this.rentService.getRentList(memberInfo.getM_id());

			// 리스트에 담긴 모든 렌트 정보에서 주문번호로 예약 내역 찾기
			RentalVO rentalRefund = null;
			for (RentalVO rental : rentals) {
				if (order_number.equals(rental.getCr_order())) {//RentalVO에 들어있는 주문번호와 order_number가 
					rentalRefund = rental;						//동일할때 까지 돌려서 어떤걸 환불할때 주문번호로 사용할것인지 찾음
					break;										//rentalRefund에 환불할 정보들이 담김
				}
			}

			if (rentalRefund == null) {
				out.print("일치하는 주문번호를 찾을 수 없습니다.");
				out.close();
				return;
			}

			// String 날짜를 LocalDateTime으로 변환
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
			LocalDateTime rentalDateTime = LocalDateTime.parse(rentalRefund.getCr_sdate(), formatter);

			// 하루 전 및 이틀 전 날짜 계산
			LocalDateTime oneDayBeforeRental = rentalDateTime.minusDays(1);
			LocalDateTime twoDaysBeforeRental = rentalDateTime.minusDays(2);

			// 현재 날짜와 시간
			LocalDateTime now = LocalDateTime.now();

			String token = getImportToken();

			if (token == null || token.isEmpty()) {
				alertMessage(out, "인증 정보에 문제가 발생했습니다 다시 시도해주세요!");
				return;
			}

			double refundAmount;

			// 하루 전 환불 불가능
			if (now.isAfter(oneDayBeforeRental)) {
				out.println("<script>");
				out.println("alert('대여시간 24시간 이내는 환불이 불가능합니다.');");
				out.println("window.close()");	//현재창을 닫음
				out.println("</script>");
			}
			// 이틀 전 환불
			else if (now.isAfter(twoDaysBeforeRental) && now.isBefore(oneDayBeforeRental)) {	
				refundAmount = rentalRefund.getCr_price() * 0.5; //환불처리후 새로고침
				cancelPay(token, order_number, refundAmount);
				this.orderService.refundOK(order_number); //환불완료로 업데이트
				this.rentService.reValueDate(order_number); //주문번호를 기준으로 해당 렌탈내역의 날짜를 초기화
				alertMessage(out, "환불 처리 되었으나, 환불 금액은 50%입니다.");
				out.println("<script>");
				out.println("window.close()");	//현재창을 닫고
				out.println("opener.location.reload();"); //부모창을 새로고침
				out.println("</script>");


				// order_number를 기준으로 parent_merchant_id 값이 주문번호와 동일한 모든 레코드를 찾음
				List<OrderVO> childOrders = this.orderService.getAllChildOrders(order_number);

				for(OrderVO childOrder : childOrders) {
					RentalVO rental = this.rentService.getRentCar(childOrder.getMerchantId());

					//환불처리
					double price = rental.getCr_price(); 	//환불 금액
					String token2 = getImportToken(); 		//토큰 생성
					String orderNum = rental.getCr_order(); //자식의 주문번호
					//환불처리 메서드 (토큰, 주문번호, 가격)
					cancelPay(token2,orderNum,price);
					this.orderService.refundOK(orderNum);
					this.rentService.reValueDate(orderNum);  //주문번호를 기준으로 해당 렌탈내역의 날짜들을 초기화
					alertMessage(out, "관련된 모든 예약이 취소 되었습니다 !");
					out.println("<script>");
					out.println("window.close()");	//현재창을 닫고
					out.println("opener.location.reload();"); //부모창을 새로고침
					out.println("</script>");
				}
				out.close();
			}
			// 그 외 환불 금액 100% 가능, 시간연장은 100퍼센트 환불
			else {
				refundAmount = rentalRefund.getCr_price(); //환불처리후 새로고침
				cancelPay(token, order_number, refundAmount);
				this.orderService.refundOK(order_number); //환불완료로 업데이트
				this.rentService.reValueDate(order_number); //주문번호를 기준으로 해당 렌탈내역의 날짜를 초기화
				alertMessage(out, "환불이 완료 되었습니다!");
				out.println("<script>");
				out.println("window.close()");	//현재창을 닫고
				out.println("opener.location.reload();"); //부모창을 새로고침
				out.println("</script>");

				// order_number를 기준으로 parent_merchant_id 값이 주문번호와 동일한 모든 레코드를 찾음
				List<OrderVO> childOrders = this.orderService.getAllChildOrders(order_number);

				for(OrderVO childOrder : childOrders) {
					RentalVO rental = this.rentService.getRentCar(childOrder.getMerchantId());

					//환불처리
					double price = rental.getCr_price(); 	//환불 금액
					String token2 = getImportToken(); 		//토큰 생성
					String orderNum = rental.getCr_order(); //자식의 주문번호
					//환불처리 메서드 (토큰, 주문번호, 가격)
					cancelPay(token2,orderNum,price);
					this.orderService.refundOK(orderNum);
					this.rentService.reValueDate(orderNum);  //주문번호를 기준으로 해당 렌탈내역의 날짜들을 초기화
					alertMessage(out, "관련된 모든 예약이 취소 되었습니다 !");
					out.println("<script>");
					out.println("window.close()");	//현재창을 닫고
					out.println("opener.location.reload();"); //부모창을 새로고침
					out.println("</script>");
				}
				out.close();
			}

		}catch (Exception e) {
			e.printStackTrace();
			out.println("<script>");
			out.println("alert('세션이 만료되었습니다 다시 로그인해주세요!');");
			out.println("window.open('/member/m_login', '_blank');");//로그인창으로 이동
			out.println("</script>");
		} finally {
			out.close();
		}
	}

	//관리자 전용 환불하기 기능 금액 100% 환불
	@PostMapping("/adminRefund")
	public void adminRefund(@RequestParam String order_number, HttpServletResponse response, HttpSession session) throws Exception {
		System.out.println("adminRefund메서드 동작");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		// 로그인 고객정보 가져오기
		MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
		try {
			if(memberInfo.getM_id().equals("admin01")) { 
				
				//주문번호를 기준으로 해당 결제 내역을 가져옴
				OrderVO orderInfo = this.orderService.getOrder2(order_number);
				double refundAmount = orderInfo.getAmount();


				//토큰 생성
				String token = getImportToken();
				System.out.println("환불토큰생성 : "+token);

				if (token == null || token.isEmpty()) {
					alertMessage(out, "인증 정보에 문제가 발생했습니다 다시 시도해주세요!");
					return;
				}

				//관리자 권한으로 100퍼센트 환불
				cancelPay(token, order_number, refundAmount);
				this.orderService.refundOK(order_number); //환불완료로 업데이트
				this.rentService.reValueDate(order_number); //주문번호를 기준으로 해당 렌탈내역의 날짜를 초기화
				alertMessage(out, "환불이 완료 되었습니다!");
				out.println("<script>");
				out.println("location.href = '/admin/admin_pay';");
				out.println("</script>");

				// order_number를 기준으로 parent_merchant_id 값이 주문번호와 동일한 모든 레코드를 찾음
				List<OrderVO> childOrders = this.orderService.getAllChildOrders(order_number);

				for(OrderVO childOrder : childOrders) {
					RentalVO rental = this.rentService.getRentCar(childOrder.getMerchantId());

					//환불처리
					double price = rental.getCr_price(); 	//환불 금액
					String token2 = getImportToken(); 		//토큰 생성
					String orderNum = rental.getCr_order(); //자식의 주문번호
					//환불처리 메서드 (토큰, 주문번호, 가격)
					cancelPay(token2,orderNum,price);
					this.orderService.refundOK(orderNum);
					this.rentService.reValueDate(orderNum);  //주문번호를 기준으로 해당 렌탈내역의 날짜들을 초기화
					alertMessage(out, "관련된 모든 예약이 취소 되었습니다 !");
					out.println("<script>");
					out.println("location.href = '/admin/admin_pay';");
					out.println("</script>");
				}
			}else {
				out.println("<script>");
				out.println("alert('관리자 전용입니다!');");
				out.println("window.open('/member/m_login', '_blank');");//로그인창으로 이동
				out.println("</script>");
			}
		}catch (Exception e) {
			System.err.println("로그인이 되어있지 않습니다.");
			out.println("<script>");
			out.println("alert('로그인 정보가 필요합니다!');");
			out.println("window.open('/member/m_login', '_blank');");//로그인창으로 이동
			out.println("</script>");
		}finally {
			out.close();
		}
	}

	//반복되는 자바스크립트 코드 메서드화
	private void alertMessage(PrintWriter out, String message) {
		out.println("<script>");
		out.println("alert('" + message + "');");
		out.println("</script>");
	}


	//환불 API 구현
	public static final String IMPORT_CANCEL_URL = "https://api.iamport.kr/payments/cancel"; 

	public int cancelPay(String token, String order_number, double refundAmount) { 
		CloseableHttpClient client = HttpClientBuilder.create().build();
		HttpPost post = new HttpPost(IMPORT_CANCEL_URL); 
		Map<String, String> map = new HashMap<String, String>(); 
		post.setHeader("Authorization", token); 
		map.put("merchant_uid", order_number);						//주문번호와
		map.put("amount", String.valueOf(refundAmount));	//환불금액 정보 추가

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
				System.out.println("IAMPORT Response: " + responseBody);

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