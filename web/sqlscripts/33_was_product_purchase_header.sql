CREATE TABLE was_product_purchase_header(
purchase_id VARCHAR( 10 ) NOT NULL, 
supplier_id VARCHAR( 6 ) NOT NULL,
record_date VARCHAR( 10 ) NOT NULL,
userid VARCHAR( 6 ) NOT NULL,
invoice_number VARCHAR(10) default '',
status varchar(3) not null,
 PRIMARY KEY (purchase_id)
)