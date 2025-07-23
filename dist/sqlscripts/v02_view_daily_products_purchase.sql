create or replace view view_daily_products_purchase(product_id, product_name, quantity, total_price, record_date, supplie_id, supplier) as
select prod.product_id, prod.product_name, purch.quantity, purch.total_price, purch.record_date, sup.supplier_id, sup.company_name
from was_product prod, was_product_purchase purch, was_supplier sup
where prod.product_id = purch.product_id
and purch.supplier = sup.supplier_id
order by prod.product_name