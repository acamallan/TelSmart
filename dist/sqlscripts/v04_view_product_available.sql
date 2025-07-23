create or replace view view_product_available(product_id, product_name, category, selling_price, discount, available) as
select product_id, product_name, category, selling_price, discount, sum(product_in - product_out) as available from view_product_info
group by product_id