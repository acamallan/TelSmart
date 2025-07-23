drop table was_cs_lend_loan_type;
CREATE TABLE was_cs_loan_type (   
was_id VARCHAR(3) NOT NULL PRIMARY KEY,     
loan_type VARCHAR(30) NOT NULL,
interest VARCHAR(10) default '',
group_id VARCHAR(1) NOT NULL);

insert into was_cs_loan_type(was_id, loan_type, interest, group_id)
values('101','Salary Loan', '', 'A');
