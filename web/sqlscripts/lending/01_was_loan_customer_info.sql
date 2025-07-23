drop table was_lend_customer_entity;
drop table was_lend_interest;
drop table was_lend_loan_info;
drop table was_lend_payment_info;
drop table was_lend_customer_info;
CREATE TABLE was_loan_customer_details (   
customer_id VARCHAR(10) NOT NULL PRIMARY KEY,     
record_date VARCHAR(10) NOT NULL,
salutation VARCHAR(3) NOT NULL,
first_name VARCHAR(30) NOT NULL,
middle_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) NOT NULL,
short_name VARCHAR(30) default '',
gender VARCHAR(3) not null,
birth_date VARCHAR(10) not null,
mother_maiden_name varchar(30) default '',
customer_category VARCHAR(3) default '',
country VARCHAR(3) not null,
nationality VARCHAR(3) NOT NULL,
language VARCHAR(3) NOT NULL,
mobile_number VARCHAR(15) default '',
landline_number VARCHAR(15) default '',
office_number VARCHAR(15) default '',
fax VARCHAR(15) default '',
email VARCHAR(30) default '',
dependents VARCHAR(2) default '',
marital_status VARCHAR(3) default ''
)