CREATE TABLE was_product_price_info (
	record_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP PRIMARY KEY NOT NULL,
	product_id VARCHAR(6),
	method VARCHAR(3),
	normal_price VARCHAR(10),
	last_purch_price VARCHAR(10),
	discount VARCHAR(10),
	cost_unit_measure VARCHAR(10),
	cost_description VARCHAR(100),
	cogs_account VARCHAR(4) default '',
	average_cost VARCHAR(4) default '',
	srp VARCHAR(10),
	discounted VARCHAR(10),
	wholesale VARCHAR(10),
	selling_unit_measure VARCHAR(10),
	selling_description VARCHAR(100),
	income_account VARCHAR(4) default '',
	tax_code VARCHAR(6) default '',
	CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES was_product(product_id)
);