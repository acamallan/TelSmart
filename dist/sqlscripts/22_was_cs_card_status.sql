CREATE TABLE was_cs_card_status (
index_field VARCHAR(3) NOT NULL PRIMARY KEY ,
card_status VARCHAR( 30 ) NOT NULL);
insert into was_cs_card_status(index_field, card_status)
values(101,'Active');
insert into was_cs_card_status(index_field, card_status)
values(102,'Closed');
insert into was_cs_card_status(index_field, card_status)
values(103,'Available');
insert into was_cs_card_status(index_field, card_status)
values(104,'Not Available');