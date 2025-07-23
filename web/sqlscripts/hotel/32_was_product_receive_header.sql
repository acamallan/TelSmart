ALTER TABLE was_product_receive_header add transaction_id varchar(10) default '';
update was_product_receive_header set transaction_id = receive_id;