UPDATE `wishlist_items`
SET
`product_id` = <{product_id: }>,
`add_date` = <{add_date: }>,
`count` = <{count: }>
WHERE `wishlist_id` = <{expr}> AND `product_id` = <{expr}>;
