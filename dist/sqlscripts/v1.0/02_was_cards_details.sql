drop table was_cards_info;
CREATE TABLE was_card_details (
card_number VARCHAR(19) NOT NULL PRIMARY KEY,     
record_date VARCHAR(10) NOT NULL,
record_time VARCHAR(8) NOT NULL,
expiry_date VARCHAR(10) NOT NULL,
card_status VARCHAR(3) NOT NULL,
card_type VARCHAR(3) NOT NULL,
link_number varchar(10) not null);