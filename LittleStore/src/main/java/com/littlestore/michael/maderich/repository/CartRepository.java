package com.littlestore.michael.maderich.repository;

import org.springframework.data.repository.CrudRepository;

import com.littlestore.michael.maderich.entity.Cart;
import com.littlestore.michael.maderich.entity.Customer;
 
public interface CartRepository extends CrudRepository<Cart, Integer> {

	public Cart findByCustomer(Customer customer);
    
}