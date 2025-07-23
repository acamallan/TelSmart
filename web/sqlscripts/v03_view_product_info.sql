create or replace view view_product_info(reference_number, product_id, product_name, category, reorder_threshold, cost_price, selling_price, discount, product_in, product_out, type, record_date, description, location, location_text) as
select distinct concat('PO-',rec.purchase_id) reference_number,
	prod.product_id, 
	prod.product_name, 
	prod.category,
	prod.reorder_threshold,
	price.normal_price cost_price,
	price.srp as selling_price, 
	price.discounted  as discount,
	rec.quantity as quantity_in,
	0 as quantity_out,
	1 as type,
	rec.record_date,
	rec.description,
	rec.location,
	loc.location
from was_product prod, 
	was_product_price_info price, 
	was_product_receive rec,
	was_cs_product_location loc
where prod.product_id = rec.product_id 
	and prod.product_id = price.product_id
	and rec.location = loc.was_id
	and price.record_date = (select max(record_date) from was_product_price_info where product_id = prod.product_id)
	
union all

select distinct concat('SO-',sale.sales_id) reference_number,
	prod.product_id, 
	prod.product_name, 
	prod.category,
	prod.reorder_threshold,
	price.normal_price cost_price,
	price.srp as selling_price, 
	price.discounted as discount,
	0 as quantity_in,
	sale.quantity quantity_out,
	2 as type,
	sale.record_date,
	'Sales',
	sale.location,
	loc.location
from was_product prod, 
	was_product_price_info price, 
	was_product_sales_invoice sale,
	was_cs_product_location loc
where prod.product_id = price.product_id
	and prod.product_id = sale.product_id
	and sale.location = loc.was_id 
	and price.record_date = (select max(record_date) from was_product_price_info where product_id = prod.product_id)