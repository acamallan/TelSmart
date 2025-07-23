CREATE TABLE was_cs_address_category (
was_id VARCHAR(3) NOT NULL PRIMARY KEY ,
address_category VARCHAR( 30 ) NOT NULL);
insert into was_cs_address_category(was_id, address_category)
values(101,'Headquarter');
insert into was_cs_address_category(was_id, address_category)
values(102,'Warehouse');
insert into was_cs_address_category(was_id, address_category)
values(103,'Shipping');
insert into was_cs_address_category(was_id, address_category)
values(104,'Billing');
