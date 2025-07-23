CREATE TABLE was_product_payment (
	payment_id VARCHAR(10) NOT NULL,
	invoice_number VARCHAR(10) NOT NULL,
	description VARCHAR(100) NOT NULL DEFAULT '',
	discount VARCHAR(10) NOT NULL DEFAULT '',
	amount VARCHAR(10) NOT NULL,
	record_date VARCHAR(10) NOT NULL
)