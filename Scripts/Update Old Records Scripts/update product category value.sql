UPDATE `product_categories`
SET
`category_id` = <{category_id: }>
WHERE `product_id` = <{expr}> AND `category_id` = <{expr}>;
