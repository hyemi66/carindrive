package com.carindrive.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller //스프링 MVC 게시판 컨트롤러 클래스
@RequestMapping("/event/*")
public class EventController {
	
	@RequestMapping(value="/event", method=RequestMethod.GET)
	public String event_page() {
		return "event/event";
	}
	
	
}
