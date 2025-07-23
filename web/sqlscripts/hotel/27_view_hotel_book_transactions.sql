create or replace view view_hotel_book_transactions(transaction_id, transaction_date, transaction_time, customer_id, customer_name, room_id, in_date, out_date, days, transaction_amount, book_status, number_of_adult, number_of_minor, userid, username, room_status_id, room_status_txt) as 
select transaction_id, transaction_date, transaction_time, trans.customer_id, concat(cust.first_name, ' ', cust.last_name) customer_name, room_id, in_date, out_date, days, transaction_amount, book_status, number_of_adult, number_of_minor, trans.userid, user.username, trans.room_status room_status_id, status.room_status room_status_txt
from was_hotel_book_transactions trans, was_user_info user, was_customer_info cust, was_cs_hotel_room_status status 
where trans.userid = user.userid and trans.customer_id = cust.customer_id
and trans.room_status = status.was_id

union all
select transaction_id, transaction_date, transaction_time, trans.customer_id, concat(cust.first_name, ' ', cust.last_name) customer_name, room_id, in_date, out_date, days, transaction_amount, book_status, number_of_adult, number_of_minor, trans.userid, user.username, trans.room_status room_status_id, status.room_status room_status_txt
from was_hotel_book_transactions_history trans, was_user_info user, was_customer_info cust, was_cs_hotel_room_status status 
where trans.userid = user.userid and trans.customer_id = cust.customer_id
and trans.room_status = status.was_id;
