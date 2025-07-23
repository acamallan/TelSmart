CREATE TABLE was_cs_customer_type (
was_id VARCHAR(3) NOT NULL PRIMARY KEY ,
customer_type VARCHAR( 30 ) NOT NULL);
insert into was_cs_customer_type(was_id, customer_type)
values(101,'Type 1');
insert into was_cs_customer_type(was_id, customer_type)
values(102,'Type 2');
