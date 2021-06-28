package com.littlestore.michael.maderich.service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.littlestore.michael.maderich.entity.Customer;
import com.littlestore.michael.maderich.entity.Role;
import com.littlestore.michael.maderich.repository.CustomerRepository;
import com.littlestore.michael.maderich.repository.RoleRepository;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@Service
//@Transactional
public class CustomerService {
    @Autowired
	private CustomerRepository customerRepository;
	@Autowired
	private RoleRepository roleRepository;
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;

    public CustomerService(CustomerRepository customerRepository) {
    	this.customerRepository = customerRepository;
    }

    
    @Transactional(rollbackFor = Exception.class)
    public void create(Customer customer) {	// Create new user DB entry (encrypt password and add roles)
		customer.setPassword(bCryptPasswordEncoder.encode(customer.getPassword()));
		Set<Role> userRoles = new HashSet<>();
		userRoles.add( roleRepository.findById(Role.Roles.CUSTOMER.ordinal()) );	//.findByRole("CUSTOMER") );//
		customer.setRole(userRoles);			// Customer role
        customerRepository.save(customer);
    }
     
    @Transactional(rollbackFor = Exception.class)
    public void update(Customer customer) {	// Update user (don't re-encrypt password)
        customerRepository.save(customer);
    }
     
    public List<Customer> listAll() {
        return (List<Customer>) customerRepository.findAll();
    }
     
    public Customer findById(Integer id) {
        return customerRepository.findById(id).get();
    }

    @Transactional
    public void delete(Integer id) {
        customerRepository.deleteById(id);
    }

    public List<Customer> findByName(String name) {
        return customerRepository.findByName(name);
    }
    
	public Customer findByEmail(String email) {
		return customerRepository.findByEmail(email);
	}
}