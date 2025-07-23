CREATE TABLE was_chart_of_account (
was_id VARCHAR(4) NOT NULL,     
account_type VARCHAR(40) NOT NULL,
group_id VARCHAR(1) NOT NULL
);
ALTER TABLE was_chart_of_account ADD PRIMARY KEY(was_id);