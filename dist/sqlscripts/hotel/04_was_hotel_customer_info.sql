CREATE TABLE was_hotel_customer_info (   
customer_id VARCHAR(10) NOT NULL PRIMARY KEY,     
record_date VARCHAR(10) NOT NULL,
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) NOT NULL,
gender VARCHAR(3) NOT NULL,
contact_number VARCHAR(15) NOT NULL,
email VARCHAR(30) default '',
address VARCHAR(30) NOT NULL,
city VARCHAR(3) NOT NULL,
country VARCHAR(3) NOT NULL,
id_number VARCHAR(30) default '',
number_of_adult VARCHAR(2) NOT NULL,
number_of_minor VARCHAR(2) NOT NULL
)