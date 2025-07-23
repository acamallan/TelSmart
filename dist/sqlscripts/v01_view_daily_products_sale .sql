create or replace view view_daily_products_sale (product_id, product_name, quantity, total_amount, record_date) as
select prod.product_id, prod.product_name, sale.quantity, sale.total_amount, sale.record_date
from was_product prod, was_product_sales_order sale
where prod.product_id = sale.product_id
order by prod.product_name