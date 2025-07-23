drop table was_cs_lend_payment_mode;
CREATE TABLE was_cs_loan_payment_mode (   
was_id VARCHAR(3) NOT NULL PRIMARY KEY,     
payment_mode VARCHAR(30) NOT NULL);

insert into was_cs_loan_payment_mode(was_id, payment_mode)
values('101','Cash');
insert into was_cs_loan_payment_mode(was_id, payment_mode)
values('102','Check');
insert into was_cs_loan_payment_mode(was_id, payment_mode)
values('103','ATM');