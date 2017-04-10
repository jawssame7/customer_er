SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS admin;
DROP TABLE IF EXISTS slip_item;
DROP TABLE IF EXISTS slip;
DROP TABLE IF EXISTS payment;
DROP TABLE IF EXISTS customer;




/* Create Tables */

CREATE TABLE admin
(
	mail_address varchar(256) NOT NULL,
	password text,
	created datetime,
	updated datetime,
	PRIMARY KEY (mail_address),
	UNIQUE (mail_address)
);




CREATE TABLE customer
(
	id bigint NOT NULL AUTO_INCREMENT,
	name varchar(40) NOT NULL,
	kana varchar(40) NOT NULL,
	postal_code varchar(7),
	address1 varchar(100),
	address2 varchar(100),
	tel varchar(14),
	fax varchar(14),
	tax_type tinyint NOT NULL,
	rounding_type tinyint NOT NULL,
	closing_day int NOT NULL,
	created datetime,
	updated datetime,
	PRIMARY KEY (id)
);


CREATE TABLE payment
(
	id bigint NOT NULL AUTO_INCREMENT,
	customer_id bigint NOT NULL,
	date varchar(6) NOT NULL,
	total_amount bigint NOT NULL,
	total_tax_amount bigint,
	payment_amount bigint,
	discount_amount bigint,
	carry_amount bigint,
	created datetime,
	updated datetime,
	PRIMARY KEY (id)
);


CREATE TABLE slip
(
	id bigint NOT NULL AUTO_INCREMENT,
	customer_id bigint NOT NULL,
	payment_id bigint,
	total_amount bigint,
	tax_amount bigint,
	created datetime,
	updated datetime,
	PRIMARY KEY (id)
);


CREATE TABLE slip_item
(
	id bigint NOT NULL AUTO_INCREMENT,
	slipid bigint NOT NULL,
	name varchar(256) NOT NULL,
	unit_price bigint NOT NULL,
	quantity int NOT NULL,
	created datetime,
	updated datetime,
	PRIMARY KEY (id)
);



/* Create Foreign Keys */

ALTER TABLE payment
	ADD FOREIGN KEY (customer_id)
	REFERENCES customer (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE slip
	ADD FOREIGN KEY (customer_id)
	REFERENCES customer (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE slip
	ADD FOREIGN KEY (payment_id)
	REFERENCES payment (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE slip_item
	ADD FOREIGN KEY (slipid)
	REFERENCES slip (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



