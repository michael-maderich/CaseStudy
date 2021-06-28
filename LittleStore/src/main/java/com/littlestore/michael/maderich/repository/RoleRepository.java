package com.littlestore.michael.maderich.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.littlestore.michael.maderich.entity.Role;

public interface RoleRepository extends JpaRepository<Role, Integer> {
	public Role findById(int id);
	public Role findByName(String roleName);
}