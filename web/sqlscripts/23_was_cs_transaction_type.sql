CREATE TABLE was_cs_transaction_type (
index_field VARCHAR(3) NOT NULL PRIMARY KEY ,
transaction_type VARCHAR( 30 ) NOT NULL);
insert into was_cs_transaction_type(index_field, transaction_type)
values(101,'Purchase');
insert into was_cs_transaction_type(index_field, transaction_type)
values(102,'Sales');
insert into was_cs_transaction_type(index_field, transaction_type)
values(103,'Load Card');
insert into was_cs_transaction_type(index_field, transaction_type)
values(104,'Top up');