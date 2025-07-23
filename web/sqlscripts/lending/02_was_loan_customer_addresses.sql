CREATE TABLE was_loan_customer_addresses (   
inc_id int NOT NULL AUTO_INCREMENT primary key,     
customer_id VARCHAR(10) NOT NULL,
record_date VARCHAR(10) NOT NULL,
address_type VARCHAR(3) NOT NULL,
address_line_1 VARCHAR(30) NOT NULL,
address_line_2 VARCHAR(30) default '',
address_line_3 VARCHAR(30) default '',
contact_number VARCHAR(15) default '',
zip_code VARCHAR(5) default '',
country varchar(3) not null);
ALTER TABLE was_loan_customer_addresses ADD CONSTRAINT fk_loan_customer_id FOREIGN KEY (customer_id) REFERENCES was_loan_customer_details(customer_id);