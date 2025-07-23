CREATE TABLE was_cs_id_type (
	was_id VARCHAR(3) PRIMARY KEY NOT NULL,
	id_type VARCHAR(30) NOT NULL
);
insert into was_cs_id_type(was_id, id_type) values('101', 'SSS');
insert into was_cs_id_type(was_id, id_type) values('102', 'PhilHealth');
insert into was_cs_id_type(was_id, id_type) values('103', 'Pag-ibig');
insert into was_cs_id_type(was_id, id_type) values('104', 'Driver Licence');
insert into was_cs_id_type(was_id, id_type) values('105', 'Company');
insert into was_cs_id_type(was_id, id_type) values('999', 'Other');
commit;