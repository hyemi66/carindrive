package com.carindrive.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.carindrive.vo.CarVO;

public interface AdminCarRepository extends JpaRepository<CarVO, Integer> {
	
	@Modifying
	@Query("update CarVO c set c.c_name=?1,c.c_brand=?2,c.c_year=?3,c.c_color=?4,c.c_type=?5,"
			+ "c.c_type2=?6,c.c_oil=?7,c.c_price=?8,c.c_img=?9 where c.c_num=?10 ")
    public void updateAdminCar(String c_name,String c_brand,String c_year,String c_color,String c_type,String c_type2,String c_oil,int c_price,String c_img,int c_num);
	
}
