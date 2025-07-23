CREATE TABLE was_supplier_purchase( 
	supplier_purchase_id MEDIUMINT NOT NULL AUTO_INCREMENT,
	record_date VARCHAR( 10 )NOT NULL,
	supplier_id VARCHAR( 6 )NOT NULL, 
	shipping_method VARCHAR( 3 )NOT NULL,
	payment_method VARCHAR( 3 )NOT NULL,
	net_due VARCHAR( 3 ) NOT NULL,
	discount VARCHAR( 3 ) NOT NULL,
	percentage VARCHAR( 3 ) NOT NULL,
	credit_limit VARCHAR( 10 ) NOT NULL,
	payable_gl VARCHAR( 4 ) NOT NULL,
	discount_gl VARCHAR( 4 ) NOT NULL,
	tax_gl VARCHAR( 4 ) NOT NULL,
	surcharge_gl VARCHAR( 4 ) NOT NULL,
	CONSTRAINT supplier_purchase_pk PRIMARY KEY (supplier_purchase_id)
)