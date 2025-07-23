CREATE TABLE was_cs_card_type (
	was_id VARCHAR(3) not null primary key,
	card_type VARCHAR(30) not null
);

insert into was_cs_card_type(was_id, card_type) values
('101','Stored-value Card'),
('102','Gift Card');