CREATE TABLE was_cs_coa_type (
	was_id VARCHAR(1) PRIMARY KEY NOT NULL,
	coa_type VARCHAR(20) NOT NULL
);
insert into was_cs_coa_type(was_id, coa_type) values('A', 'Asset Accounts');
insert into was_cs_coa_type(was_id, coa_type) values('B', 'Liability Accounts');
insert into was_cs_coa_type(was_id, coa_type) values('C', 'Owner’s Equity Accounts');
insert into was_cs_coa_type(was_id, coa_type) values('D', 'Revenue Accounts');
insert into was_cs_coa_type(was_id, coa_type) values('E', 'Cost of Sales Accounts');
insert into was_cs_coa_type(was_id, coa_type) values('F', 'Expense Accounts');
commit;