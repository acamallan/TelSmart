delete from was_hotel_book_transactions_history;
delete from was_hotel_book_transactions;
delete from was_hotel_payment;
delete from was_product_sales_invoice;
delete from was_product_sales_invoice_header;
delete from was_rest_hold_transaction;
update was_rest_table_details set table_status='108';
update was_hotel_room_details set room_status='108';