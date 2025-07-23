CREATE TABLE was_cs_employment_type (
was_id VARCHAR(3) NOT NULL PRIMARY KEY ,
employment_type VARCHAR( 30 ) NOT NULL,
group_id VARCHAR( 1 ) NOT NULL,
description VARCHAR( 20 ) NOT NULL);
insert into was_cs_employment_type(was_id, employment_type, group_id, description)
values(101,'Full Time','A', 'Loan');
insert into was_cs_employment_type(was_id, employment_type, group_id, description)
values(102,'Part Time','A', 'Loan');
insert into was_cs_employment_type(was_id, employment_type, group_id, description)
values(103,'Contract Based','A', 'Loan');