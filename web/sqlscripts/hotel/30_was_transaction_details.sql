CREATE TABLE was_transaction_details (
reference_number varchar(10) NOT NULL,     
transaction_id VARCHAR(10) default '',
debit varchar(15) default '',
credit varchar(15) default '',
gl_id varchar(8) default '',
gl_category varchar(30) default '',
eod_date varchar(10) default '',
transaction_date varchar(10) default ''
);
ALTER TABLE was_transaction_details ADD PRIMARY KEY(reference_number);