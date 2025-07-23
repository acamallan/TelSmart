CREATE TABLE was_counter (
  counter_id varchar(3) NOT NULL,
  counter_value varchar(10) NOT NULL,
  description varchar(20) NOT NULL
); 
ALTER TABLE was_counter
  ADD PRIMARY KEY (counter_id);


INSERT INTO was_counter (counter_id, counter_value,description) VALUES
('001', '000001', 'Product Items');
INSERT INTO was_counter (counter_id, counter_value,description) VALUES
('002', '0000000001','Product Sales');
INSERT INTO was_counter (counter_id, counter_value,description) VALUES
('003', '0000000001','Journal Entry');
INSERT INTO was_counter (counter_id, counter_value,description) VALUES
('004', '200000','User ID');
INSERT INTO was_counter (counter_id, counter_value,description) VALUES
('005', '000000','Supplier ID');
INSERT INTO was_counter (counter_id, counter_value,description) VALUES
('006', '0000000000','Customer ID');
commit;