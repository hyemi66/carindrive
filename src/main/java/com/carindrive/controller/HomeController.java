package com.carindrive.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {

	/*메인 페이지*/
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		return "main/index";
	}
	
	/* 에러 페이지*/
	@RequestMapping(value = "/error", method = RequestMethod.GET)
	public String error() {
		return "main/error";
	}
	
}
