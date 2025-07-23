drop table was_transaction_details;
CREATE TABLE was_accounting_details(
accounting_id varchar(11) not null primary key,
transaction_id VARCHAR( 10 ) NOT NULL, 
record_date VARCHAR( 10 ) NOT NULL,   
transaction_type VARCHAR( 3 ) NOT NULL ,
gl_code VARCHAR( 4 ) NOT NULL ,
credit_amount VARCHAR( 10 ) default '',
debit_amount VARCHAR( 10 ) default '');