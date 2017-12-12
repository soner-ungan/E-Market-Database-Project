update product_prices set date_start = (curdate);
update product_prices set date_end = adddate(curdate(), interval 375 day);

