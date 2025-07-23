CREATE TABLE was_cs_branch (
	was_id VARCHAR(3) not null primary key,
	branch VARCHAR(30) not null
);

insert into was_cs_branch (was_id, branch) values
('101','Tigbauan'),
('102','Leon');