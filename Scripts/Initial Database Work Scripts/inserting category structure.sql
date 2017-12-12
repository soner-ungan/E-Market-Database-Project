-- -----------------------------------------------------
-- Inserting Top Categories
-- -----------------------------------------------------

insert into categories(parent_id,description) values (0,'Bath');
insert into categories(parent_id,description) values (0,'Kitchen');

-- -----------------------------------------------------
-- Inserting First Level Sub Categories
-- -----------------------------------------------------

insert into categories(parent_id,description) values (1,'Faucets');
insert into categories(parent_id,description) values (2,'Faucets');

-- -----------------------------------------------------
-- Inserting Second Level Sub Categories
-- -----------------------------------------------------

insert into categories(parent_id,description) values (3,'Bath and Shower Faucets');
insert into categories(parent_id,description) values (3,'Bed Pan Cleansers');
insert into categories(parent_id,description) values (3,'Bidet Faucets');
insert into categories(parent_id,description) values (3,'Fittings and Valves');
insert into categories(parent_id,description) values (3,'Parts and Accessories');
insert into categories(parent_id,description) values (3,'Shower Faucets');
insert into categories(parent_id,description) values (3,'Sink Faucets');
insert into categories(parent_id,description) values (3,'Tub Fillers');
insert into categories(parent_id,description) values (4,'Bar Faucets');
insert into categories(parent_id,description) values (4,'Basket Strainers');
insert into categories(parent_id,description) values (4,'Laundry Faucets');
insert into categories(parent_id,description) values (4,'Parts and Accessories');
insert into categories(parent_id,description) values (4,'Service Faucets');
insert into categories(parent_id,description) values (4,'Sink Faucets');
