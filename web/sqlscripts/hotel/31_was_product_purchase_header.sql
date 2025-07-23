ALTER TABLE was_product_purchase_header add transaction_id varchar(10) default '';
update was_product_purchase_header set transaction_id = purchase_id;