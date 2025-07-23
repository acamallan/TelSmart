CREATE TABLE was_product_sales_order (
	sales_id VARCHAR(10) NOT NULL,
	product_id VARCHAR(6) NOT NULL,
	price VARCHAR(10) NOT NULL,
	quantity VARCHAR(10) NOT NULL,
	discount VARCHAR(10) NULL DEFAULT '',
	discount_amount VARCHAR(10) NULL DEFAULT '',
	total_amount VARCHAR(10) NULL DEFAULT '',
	location VARCHAR(3) NOT NULL DEFAULT '',
	description VARCHAR(100) NOT NULL DEFAULT '',
	record_date VARCHAR(10) NOT NULL
)