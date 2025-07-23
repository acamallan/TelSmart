CREATE TABLE was_cs_purchase_status (
	was_id VARCHAR(3) not null,
	purchase_status VARCHAR(30) not null
);

insert into was_cs_purchase_status(was_id, purchase_status)
values('101','Completed');
insert into was_cs_purchase_status(was_id, purchase_status)
values('102','Ordered');
insert into was_cs_purchase_status(was_id, purchase_status)
values('103','Partialed');
commit;