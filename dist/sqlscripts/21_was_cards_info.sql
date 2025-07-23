CREATE TABLE was_cards_info (
card_number VARCHAR(19) NOT NULL PRIMARY KEY,     
customer_id VARCHAR(10) NOT NULL,
record_date VARCHAR(10) NOT NULL,
effective_date VARCHAR(10) NOT NULL,
expiry_date VARCHAR(10) NOT NULL,
status VARCHAR(3) NOT NULL,
amount VARCHAR(10) NOT NULL);