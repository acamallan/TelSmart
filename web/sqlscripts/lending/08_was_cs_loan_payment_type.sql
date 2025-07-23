drop table was_cs_lend_payment_type;
CREATE TABLE was_cs_loan_payment_type (   
was_id VARCHAR(3) NOT NULL PRIMARY KEY,     
payment_type VARCHAR(30) NOT NULL);

insert into was_cs_loan_payment_type(was_id, payment_type)
values('101','Regular');
insert into was_cs_loan_payment_type(was_id, payment_type)
values('102','Partial');
insert into was_cs_loan_payment_type(was_id, payment_type)
values('103','Unpaid');