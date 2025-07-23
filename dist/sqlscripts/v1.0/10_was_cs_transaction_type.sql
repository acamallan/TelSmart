drop table was_cs_transaction_type;
CREATE TABLE was_cs_transaction_type (
was_id VARCHAR(3) NOT NULL PRIMARY KEY ,
transaction_type VARCHAR( 30 ) NOT NULL);
insert into was_cs_transaction_type(was_id, transaction_type)
values(101,'Purchase');
insert into was_cs_transaction_type(was_id, transaction_type)
values(102,'Sales');
insert into was_cs_transaction_type(was_id, transaction_type)
values(103,'Load Card');
insert into was_cs_transaction_type(was_id, transaction_type)
values(104,'Reload');