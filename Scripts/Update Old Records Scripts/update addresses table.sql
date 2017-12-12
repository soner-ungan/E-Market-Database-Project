UPDATE `addresses`
SET
`first_name` = <{first_name: }>,
`last_name` = <{last_name: }>,
`address_1` = <{address_1: }>,
`address_2` = <{address_2: }>,
`city` = <{city: }>,
`zip_code` = <{zip_code: }>,
`country` = <{country: }>
WHERE `address_id` = <{expr}>
AND `customer_id` = <{customer_id: }>;
