UPDATE `customers`
SET
`first_name` = <{first_name: }>,
`last_name` = <{last_name: }>,
`email` = <{email: }>,
`phone` = <{phone: }>,
`password` = <{password: }>,
`salt` = <{salt: }>,
`cart_id` = <{cart_id: }>,
`newsletter` = <{newsletter: }>
WHERE `customer_id` = <{expr}>;
