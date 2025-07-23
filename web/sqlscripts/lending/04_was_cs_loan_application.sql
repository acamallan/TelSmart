drop table was_cs_lend_loan_application;
CREATE TABLE was_cs_loan_application (   
was_id VARCHAR(3) NOT NULL PRIMARY KEY,     
loan_type VARCHAR(30) NOT NULL);

insert into was_cs_loan_application(was_id, loan_type)
values('101','Regular Loan');
insert into was_cs_loan_application(was_id, loan_type)
values('102','Benifits/Bonus Loan');