alter table was_customer_info add address VARCHAR(30) DEFAULT '';
alter table was_customer_info add city VARCHAR(3) DEFAULT '';
alter table was_customer_info add country VARCHAR(3) DEFAULT '';
alter table was_customer_info add number_of_adult VARCHAR(2) DEFAULT '';
alter table was_customer_info add number_of_minor VARCHAR(2) DEFAULT '';
alter table was_customer_info add has_multiple_address VARCHAR(1) DEFAULT '';