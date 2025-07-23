CREATE TABLE was_cs_customer_category (
was_id VARCHAR(3) NOT NULL PRIMARY KEY ,
customer_category VARCHAR( 30 ) NOT NULL,
group_id VARCHAR( 1 ) NOT NULL,
description VARCHAR( 20 ) NOT NULL);
insert into was_cs_customer_category(was_id, customer_category, group_id, description)
values(101,'Category 1','A', 'Loan');
insert into was_cs_customer_category(was_id, customer_category, group_id, description)
values(102,'Category 2','A', 'Loan');