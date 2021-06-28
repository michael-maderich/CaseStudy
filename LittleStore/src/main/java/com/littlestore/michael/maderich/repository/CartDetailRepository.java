package com.littlestore.michael.maderich.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.littlestore.michael.maderich.entity.Cart;
import com.littlestore.michael.maderich.entity.CartDetail;
import com.littlestore.michael.maderich.entity.CartDetailId;
 
public interface CartDetailRepository extends CrudRepository<CartDetail, CartDetailId> {
 
	public List<CartDetail> findByCartOrderByLineNumberAsc(Cart cart);

	public void delete(CartDetail item);
	
	@Query(value = "SELECT * FROM cartDetail line "
	+ "WHERE line.cartNum = :cartNum AND line.upc = :upc", nativeQuery=true)
	public CartDetail findLineByCartNumAndUpc(@Param("cartNum") int cartNum, String upc);
	
}