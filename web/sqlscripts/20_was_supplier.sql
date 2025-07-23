CREATE TABLE was_supplier( 
	supplier_id VARCHAR( 6 )NOT NULL, 
	company_name VARCHAR( 30 ) NOT NULL , 
	vendor_type VARCHAR( 3 ) NOT NULL ,
	website VARCHAR( 30 ) NOT NULL ,
	account_number VARCHAR( 19 ) NOT NULL ,
	account_name VARCHAR( 40 ) NOT NULL ,
	bank_name VARCHAR( 40 ) NOT NULL ,
	branch VARCHAR( 40 ) NOT NULL ,
	contact_person VARCHAR( 40 ) NOT NULL , 
	position VARCHAR( 30 ),
	contact_number VARCHAR( 15 ) NOT NULL, 
	fax VARCHAR( 15 ) , 
	email VARCHAR( 30 ), 
	record_date varchar(10) not null,
	PRIMARY KEY (supplier_id ) 
)