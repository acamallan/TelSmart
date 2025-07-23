CREATE TABLE was_cr_dr (
was_id VARCHAR(1) NOT NULL,     
CR_DR VARCHAR(10) NOT NULL
);
ALTER TABLE was_cr_dr ADD PRIMARY KEY(was_id);

insert into was_cr_dr(was_id,cr_dr) values(1,'Credit');
insert into was_cr_dr(was_id,cr_dr) values(2,'Debit');
commit;