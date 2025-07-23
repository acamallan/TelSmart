create or replace view view_card_transaction_history(card_number, transaction_id, transaction_date, transaction_time, transaction_type_id, transaction_type_txt, credit_amount, debit_amount) as
select card_number, 
	transaction_id, 
	transaction_date, 
	transaction_time, 
	details.transaction_type, 
	type.transaction_type, 
	transaction_amount as credit_amount, 
	'' as debit_amount
from was_card_transaction_details details, was_cs_transaction_type type 
	where  details.transaction_type = type.was_id
union all 
select card_number, 
	sales.sales_id, 
	sales.record_date, 
	sales.record_time, 
	'102', 
	'Sales', 
	'' as credit_amount, 
	sales.total_amount as debit_amount
from was_product_sales_invoice sales, was_product_sales_invoice_header header
	where sales.sales_id = header.sales_id and card_number <> ""
