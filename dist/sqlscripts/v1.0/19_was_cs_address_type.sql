CREATE TABLE was_cs_address_type (
was_id VARCHAR(3) NOT NULL PRIMARY KEY ,
address_type VARCHAR( 30 ) NOT NULL,
group_id VARCHAR( 1 ) NOT NULL,
description VARCHAR( 20 ) NOT NULL);
insert into was_cs_address_type(was_id, address_type, group_id, description)
values(101,'Permanent','A', 'Loan');
insert into was_cs_address_type(was_id, address_type, group_id, description)
values(102,'Home','A', 'Loan');
insert into was_cs_address_type(was_id, address_type, group_id, description)
values(103,'Work','A', 'Loan');
insert into was_cs_address_type(was_id, address_type, group_id, description)
values(104,'Temporary','A', 'Loan');
insert into was_cs_address_type(was_id, address_type, group_id, description)
values(105,'Others','A', 'Loan');
