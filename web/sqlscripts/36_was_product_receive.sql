CREATE TABLE was_product_receive(
receive_id VARCHAR( 10 ) NOT NULL, 
purchase_id VARCHAR( 10 ) NOT NULL, 
record_date VARCHAR( 10 ) NOT NULL,  
product_id VARCHAR( 6 ) NOT NULL,
quantity VARCHAR( 10 ) NOT NULL,
description VARCHAR( 30 ) NOT NULL ,
cost_price VARCHAR( 10 ) NOT NULL,
total_price VARCHAR( 10 ) NOT NULL,
purchase_status VARCHAR( 3 ) NOT NULL,
location varchar(3),
tab varchar(1) not null
CONSTRAINT receive_fk_purchase_id FOREIGN KEY (purchase_id) REFERENCES was_product_purchase_header(purchase_id)
)