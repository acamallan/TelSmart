CREATE TABLE was_top_up (
	transaction_id VARCHAR(10) NOT NULL,
	record_date VARCHAR(10) NOT NULL,
	customer_id VARCHAR(10) NOT NULL,
	card_number VARCHAR(15) NOT NULL,
	amount VARCHAR(10) NOT NULL
)