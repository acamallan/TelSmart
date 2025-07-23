CREATE TABLE was_cs_payment_method (
was_id VARCHAR(3) NOT NULL PRIMARY KEY ,
payment_method VARCHAR( 30 ) NOT NULL);
insert into was_cs_payment_method(was_id, payment_method)
values(101,'Shipping Method 1');
insert into was_cs_payment_method(was_id, payment_method)
values(102,'Shipping Method 1');
