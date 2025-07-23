CREATE TABLE was_transaction_description (
was_id VARCHAR(3) NOT NULL,     
description VARCHAR(10) NOT NULL,
cr_dr VARCHAR(1) NOT NULL
);
ALTER TABLE was_transaction_description ADD PRIMARY KEY(was_id);


insert into was_transaction_description(was_id,description,cr_dr) values(1,'Accounts Receivable',1);
insert into was_transaction_description(was_id,description,cr_dr) values(2,'Accounts Payable',2);
insert into was_transaction_description(was_id,description,cr_dr) values(3,'Office Supplies',2);
insert into was_transaction_description(was_id,description,cr_dr) values(4,'Electricity Expense',2);
insert into was_transaction_description(was_id,description,cr_dr) values(5,'Telephone Expense',2);
insert into was_transaction_description(was_id,description,cr_dr) values(6,'Miscellaneous Expense',2);
commit;