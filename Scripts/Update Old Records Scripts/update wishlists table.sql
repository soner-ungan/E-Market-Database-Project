UPDATE `wishlists`
SET
`wishlist_description` = <{wishlist_description: }>,
`email` = <{email: }>
WHERE `wishlist_id` = <{expr}> AND `customer_id` = <{expr}>;
