CREATE TABLE was_supplier_address( 
	supplier_address_id MEDIUMINT NOT NULL AUTO_INCREMENT,
	record_date VARCHAR( 10 )NOT NULL, 
	supplier_id VARCHAR( 6 )NOT NULL, 
	address_category VARCHAR( 3 )NOT NULL,
	contact_person VARCHAR( 40 ) NOT NULL, 
	address_line_1 VARCHAR( 40 ) NOT NULL,
	address_line_2 VARCHAR( 40 ) DEFAULT '',
	address_line_3 VARCHAR( 40 ) DEFAULT '',
	address_line_4 VARCHAR( 40 ) DEFAULT '',
	city VARCHAR( 3 ) NOT NULL,
	country VARCHAR( 3 ) NOT NULL,
	zip_code VARCHAR( 4 ) NOT NULL,
	email VARCHAR( 40 ) NOT NULL,
	telephone VARCHAR( 15 ) NOT NULL,
	mobile VARCHAR( 15 ) NOT NULL,
	CONSTRAINT supplier_address_pk PRIMARY KEY (supplier_address_id)
)