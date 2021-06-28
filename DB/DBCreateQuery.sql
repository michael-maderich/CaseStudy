/*DROP DATABASE IF EXISTS LittleStore;*/

CREATE DATABASE LittleStore;

USE LittleStore;

DROP TABLE IF EXISTS `Customer_Role`;
DROP TABLE IF EXISTS `Role`;
DROP TABLE IF EXISTS `CartDetails`;
DROP TABLE IF EXISTS `Cart`;
DROP TABLE IF EXISTS `OrderDetails`;
DROP TABLE IF EXISTS `Order`;
DROP TABLE IF EXISTS `Product`;
DROP TABLE IF EXISTS `Customer`;

CREATE TABLE `customer` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`email` VARCHAR(50) NOT NULL COLLATE 'latin1_swedish_ci',
	`password` VARCHAR(60) NOT NULL COLLATE 'latin1_swedish_ci',
	`firstName` VARCHAR(50) NOT NULL COLLATE 'latin1_swedish_ci',
	`lastName` VARCHAR(50) NOT NULL COLLATE 'latin1_swedish_ci',
	`address` VARCHAR(50) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`city` VARCHAR(50) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`state` INT(11) NULL DEFAULT NULL,
	`phone` VARCHAR(10) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`preferredPayment` VARCHAR(255) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`paymentHandle` VARCHAR(50) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`isEnabled` BIT(1) NOT NULL DEFAULT b'1',
	PRIMARY KEY (`id`) USING BTREE,
	UNIQUE INDEX `UK_dwk6cx0afu8bs9o4t536v1j5v` (`email`) USING BTREE
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
AUTO_INCREMENT=29
;

CREATE TABLE `product` (
	`upc` VARCHAR(12) NOT NULL COLLATE 'latin1_swedish_ci',
	`categoryMain` VARCHAR(50) NOT NULL COLLATE 'latin1_swedish_ci',
	`categorySpecific` VARCHAR(50) NOT NULL COLLATE 'latin1_swedish_ci',
	`name` VARCHAR(50) NOT NULL COLLATE 'latin1_swedish_ci',
	`options` VARCHAR(50) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`size` VARCHAR(10) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`cost` FLOAT NOT NULL,
	`basePrice` FLOAT NOT NULL,
	`currentPrice` FLOAT NOT NULL,
	`onSale` BIT(1) NOT NULL,
	`stockQty` INT(11) NOT NULL,
	`description` VARCHAR(200) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`image` VARCHAR(255) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	PRIMARY KEY (`upc`) USING BTREE
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;

CREATE TABLE `orders` (
	`orderNum` INT(11) NOT NULL AUTO_INCREMENT,
	`customerId` INT(11) NOT NULL,
	`orderDateTime` DATETIME NOT NULL,
	`reqDeliveryDateTime` DATETIME NULL DEFAULT NULL,
	`status` VARCHAR(255) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`comments` VARCHAR(200) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	PRIMARY KEY (`orderNum`) USING BTREE,
	INDEX `FK1ptw1l1kw6lk5o8mve55enocc` (`customerId`) USING BTREE,
	CONSTRAINT `FK1ptw1l1kw6lk5o8mve55enocc` FOREIGN KEY (`customerId`) REFERENCES `littlestore`.`customer` (`id`) ON UPDATE RESTRICT ON DELETE RESTRICT
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
AUTO_INCREMENT=13
;

CREATE TABLE `orderdetail` (
	`orderNum` INT(11) NOT NULL,
	`upc` VARCHAR(12) NOT NULL COLLATE 'latin1_swedish_ci',
	`qty` INT(11) NOT NULL,
	`price` FLOAT NOT NULL,
	`lineNumber` INT(11) NOT NULL,
	PRIMARY KEY (`orderNum`, `upc`) USING BTREE,
	INDEX `FKluqc5c2ol6haqf0tliv2uarsp` (`upc`) USING BTREE,
	CONSTRAINT `FK6swv8h7hllfd11l0srf5pojbp` FOREIGN KEY (`orderNum`) REFERENCES `littlestore`.`orders` (`orderNum`) ON UPDATE RESTRICT ON DELETE RESTRICT,
	CONSTRAINT `FKluqc5c2ol6haqf0tliv2uarsp` FOREIGN KEY (`upc`) REFERENCES `littlestore`.`product` (`upc`) ON UPDATE RESTRICT ON DELETE RESTRICT
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;

CREATE TABLE `cart` (
	`cartId` INT(11) NOT NULL AUTO_INCREMENT,
	`customerId` INT(11) NOT NULL,
	`cartCreationDateTime` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`cartId`) USING BTREE,
	INDEX `FK61b13xd3epu1lxhphpgoa58wn` (`customerId`) USING BTREE,
	CONSTRAINT `FK61b13xd3epu1lxhphpgoa58wn` FOREIGN KEY (`customerId`) REFERENCES `littlestore`.`customer` (`id`) ON UPDATE RESTRICT ON DELETE RESTRICT
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
AUTO_INCREMENT=21
;

CREATE TABLE `cartdetail` (
	`cartId` INT(11) NOT NULL,
	`upc` VARCHAR(12) NOT NULL COLLATE 'latin1_swedish_ci',
	`qty` INT(11) NOT NULL,
	`price` FLOAT NOT NULL,
	`lineNumber` INT(11) NOT NULL,
	PRIMARY KEY (`cartId`, `upc`) USING BTREE,
	INDEX `FK3f3l54hbltew5n8eb0dficwtm` (`upc`) USING BTREE,
	CONSTRAINT `FK3f3l54hbltew5n8eb0dficwtm` FOREIGN KEY (`upc`) REFERENCES `littlestore`.`product` (`upc`) ON UPDATE RESTRICT ON DELETE RESTRICT,
	CONSTRAINT `FKgeceslwdpwfr23n1b9bagdokl` FOREIGN KEY (`cartId`) REFERENCES `littlestore`.`cart` (`cartId`) ON UPDATE RESTRICT ON DELETE RESTRICT
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;

CREATE TABLE `role` (
	`id` INT(11) NOT NULL,
	`name` VARCHAR(255) NOT NULL COLLATE 'latin1_swedish_ci',
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;