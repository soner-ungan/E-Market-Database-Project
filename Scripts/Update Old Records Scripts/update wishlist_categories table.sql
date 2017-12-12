UPDATE `wishlist_categories`
SET
`category_id` = <{category_id: }>,
`add_date` = <{add_date: }>
WHERE `wishlist_id` = <{expr}> AND `category_id` = <{expr}>;
