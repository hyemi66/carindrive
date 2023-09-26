package com.carindrive.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.carindrive.dao.GongjiDAO;

@Service
public class GongjiServiceImpl implements GongjiService{
	
	
	@Autowired
	private GongjiDAO gjDao;
}
