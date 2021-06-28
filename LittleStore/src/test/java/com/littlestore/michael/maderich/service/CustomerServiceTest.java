package com.littlestore.michael.maderich.service;

import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.test.annotation.Rollback;

import com.littlestore.michael.maderich.entity.Customer;

@DataJpaTest
@Rollback(false)
//@Sql(scripts={"/test-data.sql"})		// Source test data from external file in src/main/resources. Run once for each test
@AutoConfigureTestDatabase(replace=AutoConfigureTestDatabase.Replace.NONE)	// Use actual DB instead of temp one
public class CustomerServiceTest {

	@Autowired
	private CustomerService service;
	static int testId;
	
	@Test
	@Order(1)
	void testSave() {
		Customer cust = new Customer();
		cust.setId(50);
		cust.setEmail("test@junit5.com");
		cust.setFirstName("Johnny");
		cust.setLastName("Five");
		cust.setPassword((new BCryptPasswordEncoder()).encode("isAlive"));
		cust.setIsEnabled(true);
		service.create(cust);
		testId = 50;
//		System.out.println(testId);
		assertNotNull(service.findById(testId));
	}
	
	@Test
	@Order(2)
	void testFindByEmail() {
		Customer expected = new Customer();
		expected.setId(24);
		expected.setEmail("test@junit5.com");
		expected.setFirstName("Johnny");
		expected.setLastName("Five");
		expected.setPassword((new BCryptPasswordEncoder()).encode("isAlive"));
		expected.setIsEnabled(true);
		Customer actual = service.findByEmail("test@junit5.com");
		assertEquals(expected, actual);
	}

}