CREATE TABLE was_transaction_details(
transaction_id VARCHAR( 10 ) NOT NULL, 
record_date VARCHAR( 10 ) NOT NULL,   
customer_id VARCHAR( 10 ) NOT NULL,
card_number VARCHAR( 15 ),
transaction_type VARCHAR( 3 ) NOT NULL ,
crdr VARCHAR( 1 ) NOT NULL,
amount VARCHAR( 10 ) NOT NULL)