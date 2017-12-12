UPDATE `cart_products`
SET
`count` = <{count: }>
WHERE `cart_id` = <{expr}> AND `product_id` = <{expr}>;
