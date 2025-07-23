CREATE TABLE was_product_sales_order_header(
sales_id VARCHAR( 10 ) NOT NULL, 
customer_id VARCHAR( 10 ) NOT NULL,
record_date VARCHAR( 10 ) NOT NULL,
userid VARCHAR( 6 ) NOT NULL,
status varchar(1) not null,
 PRIMARY KEY (sales_id)
)