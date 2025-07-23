CREATE TABLE was_cs_payment_mode (
	was_id VARCHAR(3) PRIMARY KEY NOT NULL,
	payment_mode VARCHAR(30) NOT NULL
);
insert into was_cs_payment_mode(was_id, payment_mode) values('101', 'Cash');
insert into was_cs_payment_mode(was_id, payment_mode) values('102', 'Credit Card');
insert into was_cs_payment_mode(was_id, payment_mode) values('103', 'Debit Card');
commit;