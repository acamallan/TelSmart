CREATE TABLE was_cs_product_type (
	was_id VARCHAR(3) PRIMARY KEY NOT NULL,
	product_type VARCHAR(20) NOT NULL
);
insert into was_cs_product_type(was_id, product_type) values('101', 'Retail');
insert into was_cs_product_type(was_id, product_type) values('102', 'Materials');
commit;