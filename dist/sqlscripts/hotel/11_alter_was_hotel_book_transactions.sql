alter table was_hotel_book_transactions add userid VARCHAR(6) DEFAULT '';
alter table was_hotel_book_transactions add deposit_mode VARCHAR(3) DEFAULT '';
alter table was_hotel_book_transactions add deposit_amount VARCHAR(10) DEFAULT '';
alter table was_hotel_book_transactions add payment_status VARCHAR(3) DEFAULT '';

alter table was_hotel_book_transactions_history add userid VARCHAR(6) DEFAULT '';
alter table was_hotel_book_transactions_history add deposit_mode VARCHAR(3) DEFAULT '';
alter table was_hotel_book_transactions_history add deposit_amount VARCHAR(10) DEFAULT '';
alter table was_hotel_book_transactions_history add payment_status VARCHAR(3) DEFAULT '';