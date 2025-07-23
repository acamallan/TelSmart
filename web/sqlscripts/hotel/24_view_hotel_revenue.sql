create or replace view view_hotel_revenue(sales_invoice_number, transaction_date, transaction_amount, userid, user_fullname, location, location_txt) as
select concat('S',invoice_number), transaction_date, transaction_amount, hotel.userid, concat(user.firstname, " ", user.lastname), '1','Hotel'
from was_hotel_payment hotel, was_user_info user
where hotel.userid = user.userid

union all
select concat('S',invoice_number), sales.record_date, actual_amount, sales.userid, concat(user.firstname, " ", user.lastname),'2','Restaurant'
from was_product_sales_invoice_header sales, was_user_info user
where sales.userid = user.userid