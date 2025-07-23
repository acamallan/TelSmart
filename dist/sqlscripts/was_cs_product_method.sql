CREATE TABLE was_cs_product_method (
	was_id VARCHAR(3) PRIMARY KEY NOT NULL,
	method VARCHAR(20) NOT NULL
);
insert into was_cs_product_method(was_id, method) values('101', 'FIFO');
insert into was_cs_product_method(was_id, method) values('102', 'LIFO');
insert into was_cs_product_method(was_id, method) values('103', 'Average');
commit;