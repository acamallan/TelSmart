drop table was_cs_lend_loan_scheme;
CREATE TABLE was_cs_loan_scheme (   
was_id VARCHAR(3) NOT NULL PRIMARY KEY,     
loan_scheme VARCHAR(30) NOT NULL);

insert into was_cs_loan_scheme(was_id, loan_scheme)
values('101','15th');
insert into was_cs_loan_scheme(was_id, loan_scheme)
values('102','30th');
insert into was_cs_loan_scheme(was_id, loan_scheme)
values('103','15th/30th');