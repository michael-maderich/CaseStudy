package com.littlestore.michael.maderich.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.littlestore.michael.maderich.entity.Order;
import com.littlestore.michael.maderich.entity.OrderDetail;
import com.littlestore.michael.maderich.entity.OrderDetailId;
 
public interface OrderDetailRepository extends CrudRepository<OrderDetail, OrderDetailId> {
 
//	@Query(value = "SELECT DISTINCT p.categorySpecific FROM product p "
//			+ "WHERE p.categoryMain = :mainCat ORDER BY p.categorySpecific", nativeQuery=true)
	public List<OrderDetail> findByOrderOrderByLineNumberAsc(Order order);
}