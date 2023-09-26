package com.carindrive.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.carindrive.service.GongjiService;

@Controller
public class GongjiController {
	
	@Autowired
	private GongjiService gjSerive;
}
