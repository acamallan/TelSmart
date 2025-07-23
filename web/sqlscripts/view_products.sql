create or replace view view_products(product_id, product_name, cost_price, selling_price, discount, stock_in, stock_out) as 
SELECT prod.product_id, 
	prod.product_name,
    prod.cost_price,
	prod.selling_price,
	prod.discount,
    sum(prod_in.quantity) as stock_in , 
	IFNULL((SELECT sum(prod_out.quantity) FROM was_product_sales_order prod_out, was_product prod 
		where prod_out.product_id = prod.product_id
		and prod_in.product_id = prod_out.product_id
		group by prod_out.product_id), 0) as stock_out
FROM was_product_purchase prod_in,  was_product prod 
where prod_in.product_id = prod.product_id
group by prod_in.product_id