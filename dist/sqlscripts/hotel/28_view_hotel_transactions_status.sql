drop view view_hotel_transactions;
create or replace view view_hotel_transactions_status(transaction_id, transaction_date, transaction_time,customer_id, room_id, transaction_amount, description, payment_status_id, payment_status_txt) as
select transaction_id, 
	transaction_date, 
	transaction_time,
	customer_id, 
	room_id,
	transaction_amount, 
	'Room' description, 
	trans.payment_status payment_status_id, 
	status.payment_status payment_status_txt 
 from was_hotel_book_transactions trans, was_cs_payment_status status
 where trans.payment_status = status.was_id
 
 union all
 select sales_id, 
 	record_date, 
	record_time, 
	customer_id, 
 	room_id, 
 	actual_amount, 
 	'Restaurant',
	trans.payment_status payment_status_id, 
	status.payment_status payment_status_txt 
from was_product_sales_invoice_header trans, was_cs_payment_status status
where trans.payment_status = status.was_id and trans.room_id <> '';