CREATE TABLE was_hotel_book_transactions_history(
transaction_id varchar(10) not null primary key,
transaction_date VARCHAR( 10 ) NOT NULL,
transaction_time VARCHAR( 8 ) NOT NULL,
customer_id VARCHAR( 10 ) NOT NULL ,
room_id VARCHAR( 4 ) NOT NULL ,
in_date VARCHAR( 10 ) NOT NULL,
out_date VARCHAR( 10 ) NOT NULL,
days VARCHAR( 3 ) NOT NULL,
transaction_amount VARCHAR( 10 ) NOT NULL,
book_status varchar(1) not null,
number_of_adult VARCHAR(2) DEFAULT '',
number_of_minor VARCHAR(2) DEFAULT ''
);