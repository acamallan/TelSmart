CREATE TABLE was_cs_payment_status (
	was_id VARCHAR(3) not null,
	payment_status VARCHAR(30) not null
);

insert into was_cs_payment_status(was_id, payment_status)
values('101','Paid');
insert into was_cs_payment_status(was_id, payment_status)
values('102','Hold');
insert into was_cs_payment_status(was_id, payment_status)
values('103','Cancel');
commit;