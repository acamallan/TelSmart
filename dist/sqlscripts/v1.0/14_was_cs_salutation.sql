CREATE TABLE was_cs_salutation (
was_id VARCHAR(3) NOT NULL PRIMARY KEY ,
salutation VARCHAR( 30 ) NOT NULL);
insert into was_cs_salutation(was_id, salutation)
values(101,'Mr');
insert into was_cs_salutation(was_id, salutation)
values(102,'Mrs');
insert into was_cs_salutation(was_id, salutation)
values(103,'Miss');