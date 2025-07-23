CREATE TABLE was_product_purchase(
purchase_id VARCHAR( 10 ) NOT NULL, 
record_date VARCHAR( 10 ) NOT NULL,  
product_id VARCHAR( 6 ) NOT NULL,
quantity VARCHAR( 10 ) NOT NULL,
description VARCHAR( 30 ) NOT NULL ,
cost_price VARCHAR( 10 ) NOT NULL,
total_price VARCHAR( 10 ) NOT NULL,
purchase_status VARCHAR( 3 ) NOT NULL,
partial VARCHAR( 6 ) DEFAULT 0,
CONSTRAINT purchase_fk_product_id FOREIGN KEY (product_id) REFERENCES was_product(product_id)
)