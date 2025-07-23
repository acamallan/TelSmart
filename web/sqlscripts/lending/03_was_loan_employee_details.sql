CREATE TABLE was_loan_employee_details (   
inc_id int NOT NULL AUTO_INCREMENT primary key,     
customer_id VARCHAR(10) NOT NULL,
record_date VARCHAR(10) NOT NULL,
employment_type VARCHAR(3) NOT NULL,
employer_name VARCHAR(30) NOT NULL,
occupation VARCHAR(30) default '',
designation VARCHAR(30) default '',
employee_id VARCHAR(15) default '',
address_line_1 VARCHAR(30) NOT NULL,
address_line_2 VARCHAR(30) default '',
address_line_3 VARCHAR(30) default '',
zip_code VARCHAR(5) default '',
country varchar(3) not null,
phone_number varchar(15) default '');
ALTER TABLE was_loan_employee_details ADD CONSTRAINT fk_emp_customer_id FOREIGN KEY (customer_id) REFERENCES was_loan_customer_details(customer_id);