CREATE TABLE was_journal_transaction (
transaction_type VARCHAR(3) NOT NULL,     
notes VARCHAR(100) NOT NULL,
record_date VARCHAR(10) NOT NULL,
transaction_date VARCHAR(10) NOT NULL,
credit decimal(10,2),
debit decimal(10,2)
);