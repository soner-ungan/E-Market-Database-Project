UPDATE `products`
SET
`model` = <{model: }>,
`upc` = <{upc: }>,
`short_name` = <{short_name: }>,
`long_name` = <{long_name: }>,
`brand` = <{brand: }>,
`shipping_type` = <{shipping_type: }>,
`quantity` = <{quantity: 0}>,
`list_price` = <{list_price: }>,
`shipping_cost` = <{shipping_cost: }>,
`status` = <{status: 1}>,
`status_reason` = <{status_reason: }>,
`description` = <{description: }>,
`condition_id` = <{condition_id: 1}>
WHERE `product_id` = <{expr}>;
