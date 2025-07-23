CREATE TABLE was_cs_currency_type (
	was_id VARCHAR(3) not null primary key,
	currency_type VARCHAR(30) not null
);

insert into was_cs_currency_type(was_id, currency_type) values
('101','PHP');