CREATE TABLE was_cs_unit_measure (
	was_id VARCHAR(3) not null,
	unit_measure VARCHAR(30) not null,
	group_id VARCHAR(1) not null
);

insert into was_cs_unit_measure(was_id, unit_measure, group_id)
values('101', 'n/a', 'A');