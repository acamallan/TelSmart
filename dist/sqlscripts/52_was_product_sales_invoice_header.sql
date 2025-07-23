CREATE TABLE was_product_sales_invoice_header(
invoice_number varchar(15) not null primary key,
sales_id VARCHAR( 10 ) NOT NULL, 
customer_id VARCHAR( 10 ) NOT NULL,
record_date VARCHAR( 10 ) NOT NULL,
userid VARCHAR( 6 ) NOT NULL,
due_date varchar(10) default '',
payment_status varchar(3) not null,
due_amount varchar(10) not null,
actual_amount varchar(10) not null
)