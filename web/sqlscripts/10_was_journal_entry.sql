CREATE TABLE was_journal_entry (
  auto_inc_id int(10) unsigned NOT NULL,
  journal_id varchar(10) NOT NULL,
  crdr varchar(1) NOT NULL,
  account_type varchar(4) NOT NULL,
  notes varchar(100) NOT NULL,
  record_date varchar(10) NOT NULL,
  transaction_date varchar(10) DEFAULT NULL,
  credit decimal(10,2) DEFAULT NULL,
  debit decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=latin1;