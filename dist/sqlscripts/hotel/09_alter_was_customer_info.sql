ALTER TABLE was_customer_info
  DROP COLUMN number_of_adult,
  DROP COLUMN number_of_minor;
alter table was_hotel_book_transactions add number_of_adult VARCHAR(2) DEFAULT '';
alter table was_hotel_book_transactions add number_of_minor VARCHAR(2) DEFAULT '';