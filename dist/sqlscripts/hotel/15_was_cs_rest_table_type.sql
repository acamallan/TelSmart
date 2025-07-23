CREATE TABLE was_cs_rest_table_type (
	was_id VARCHAR(3) PRIMARY KEY NOT NULL,
	table_type VARCHAR(30) NOT NULL
);
insert into was_cs_rest_table_type(was_id, table_type) values('101', 'Type 1');
insert into was_cs_rest_table_type(was_id, table_type) values('102', 'Type 2');
insert into was_cs_rest_table_type(was_id, table_type) values('103', 'Type 3');
commit;