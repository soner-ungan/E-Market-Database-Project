update order_products o, product_prices p set o.sell_price = p.price where o.product_id = p.product_id;

update order_products o, products p set o.model = p.model, o.short_name = p.short_name where o.product_id = p.product_id;