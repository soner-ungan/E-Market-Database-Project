UPDATE `product_prices`
SET
`priority` = <{priority: 1}>,
`price` = <{price: }>,
`date_start` = <{date_start: }>,
`date_end` = <{date_end: }>
WHERE `product_id` = <{expr}> AND `listed_by_customer_id` = <{expr}>;
