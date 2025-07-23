CREATE TABLE was_rest_table_details (
table_id VARCHAR(4) NOT NULL,     
table_type VARCHAR(3) NOT NULL,
table_status varchar(3) not null
);
ALTER TABLE was_rest_table_details ADD PRIMARY KEY(table_id);