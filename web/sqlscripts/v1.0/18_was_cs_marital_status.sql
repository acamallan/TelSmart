CREATE TABLE was_cs_marital_status (
was_id VARCHAR(3) NOT NULL PRIMARY KEY ,
marital_status VARCHAR( 30 ) NOT NULL);

insert into was_cs_marital_status(was_id, marital_status)
values(101,'Single');
insert into was_cs_marital_status(was_id, marital_status)
values(102,'Merried');
insert into was_cs_marital_status(was_id, marital_status)
values(103,'Divorce');