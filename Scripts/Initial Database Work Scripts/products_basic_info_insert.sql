LOAD DATA LOCAL INFILE '\\Database Uploads\\faucets.csv' 
INTO TABLE products 
    FIELDS TERMINATED BY ',' 
           OPTIONALLY ENCLOSED BY '"'
    LINES  TERMINATED BY '\n' ignore 1 lines
    (`model`,`upc`,`short_name`,`long_name`,`brand`,`shipping_type`,`quantity`,`list_price`,`shipping_cost`);