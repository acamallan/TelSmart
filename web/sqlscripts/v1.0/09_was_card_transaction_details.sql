CREATE TABLE was_card_transaction_details (
transaction_reference VARCHAR(10) NOT NULL PRIMARY KEY,     
transaction_date VARCHAR(10) NOT NULL,
transaction_time VARCHAR(10) NOT NULL,
card_number VARCHAR(16) NOT NULL,
customer_id VARCHAR(10) NOT NULL,
transaction_type varchar(3) not null,
currency_type varchar(3) not null,
transaction_amount varchar(10) not null,
userid varchar(6) not null);