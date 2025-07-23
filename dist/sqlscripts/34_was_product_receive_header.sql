CREATE TABLE was_product_receive_header (
	receive_id VARCHAR(10) NOT NULL,
	record_date VARCHAR(10) NOT NULL,
	userid VARCHAR(6) NOT NULL,
	invoice_number varchar(10) default '',
	not_invoiced varchar(1) default '0',
	supplier_id varchar(6) not null,
	PRIMARY KEY (receive_id)
)