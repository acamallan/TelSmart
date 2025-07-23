CREATE TABLE was_employee_info(
employee_id INT( 6 ) UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
firstname VARCHAR( 30 ) NOT NULL ,
lastname VARCHAR( 30 ) NOT NULL ,
sss_id VARCHAR( 30 ) ,
phil_health_id VARCHAR( 50 ) ,
pag_ibig_id VARCHAR( 50 ) ,
record_date TIMESTAMP,
modified_date TIMESTAMP
)