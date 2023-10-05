package com.carindrive.vo;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class PageVO {
	
	
	private int startrow;
	private int endrow;

    private String find_field;
    private String find_name;
}
