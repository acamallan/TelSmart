CREATE TABLE was_customer_contact (
customer_contact_id MEDIUMINT NOT NULL AUTO_INCREMENT,   
record_date VARCHAR( 10 )NOT NULL, 
customer_id VARCHAR(10) NOT NULL,
address_category VARCHAR( 3 )NOT NULL,
contact_person VARCHAR( 40 ) NOT NULL, 
address_line_1 VARCHAR( 40 ) DEFAULT '',
address_line_2 VARCHAR( 40 ) DEFAULT '',
address_line_3 VARCHAR( 40 ) DEFAULT '',
address_line_4 VARCHAR( 40 ) DEFAULT '',
city VARCHAR( 3 ) NOT NULL,
country VARCHAR( 3 ) NOT NULL,
zip_code VARCHAR( 4 ) NOT NULL,
email VARCHAR( 40 ) NOT NULL,
telephone VARCHAR( 15 ) NOT NULL,
fax VARCHAR( 15 ) NOT NULL,
mobile VARCHAR( 15 ) NOT NULL,
CONSTRAINT customer_contact_pk PRIMARY KEY (customer_contact_id)
)