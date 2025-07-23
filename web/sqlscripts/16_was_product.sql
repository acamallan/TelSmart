CREATE TABLE was_product (
	product_id VARCHAR(6) NOT NULL,
	product_name VARCHAR(30) NOT NULL,
	product_type VARCHAR(3) NOT NULL,
	coa_type VARCHAR(4) NOT NULL,
	category VARCHAR(30) NOT NULL,
	supplier VARCHAR(3) NOT NULL,
	cost_price VARCHAR(10) NULL DEFAULT NULL,
	selling_price VARCHAR(10) NULL DEFAULT NULL,
	note VARCHAR(30) NOT NULL,
	discount VARCHAR(2) NOT NULL DEFAULT '0',
	barcode varchar(20) default '',
	reorder_quantity VARCHAR(6) default '',
	reorder_threshold VARCHAR(6) default '',
	PRIMARY KEY (product_id)
)