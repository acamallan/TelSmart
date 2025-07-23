drop table was_cs_card_status;
CREATE TABLE was_cs_card_status (
was_id VARCHAR(3) NOT NULL PRIMARY KEY ,
card_status VARCHAR( 30 ) NOT NULL);
insert into was_cs_card_status(was_id, card_status)
values(101,'Active');
insert into was_cs_card_status(was_id, card_status)
values(102,'In Active');
insert into was_cs_card_status(was_id, card_status)
values(103,'Link to Customer');