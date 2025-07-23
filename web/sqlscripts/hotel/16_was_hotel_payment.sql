CREATE TABLE was_hotel_payment(
transaction_id VARCHAR( 10 ) NOT NULL primary key, 
transaction_date VARCHAR( 10 ) NOT NULL,
transaction_time VARCHAR( 8 ) NOT NULL,  
customer_id VARCHAR( 10 ) NOT NULL,
room_id VARCHAR( 4 ) not null,
payment_mode VARCHAR( 3 ) not null,
transaction_amount VARCHAR( 10 ) NOT NULL)