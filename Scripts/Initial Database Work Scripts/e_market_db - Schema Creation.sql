SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema e_market_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `e_market_db` DEFAULT CHARACTER SET utf8 ;
USE `e_market_db` ;

-- -----------------------------------------------------
-- Table `e_market_db`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_market_db`.`categories` (
  `category_id` INT(4) NOT NULL AUTO_INCREMENT,
  `parent_id` INT(4) NULL DEFAULT 0,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e_market_db`.`attributes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_market_db`.`attributes` (
  `attribute_id` INT(4) NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`attribute_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e_market_db`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_market_db`.`customers` (
  `customer_id` INT(4) NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `email` VARCHAR(100) NULL,
  `phone` VARCHAR(45) NULL,
  `password` VARCHAR(32) NULL,
  `salt` VARCHAR(9) NULL,
  `cart_id` INT(4) NULL,
  `newsletter` TINYINT(1) NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e_market_db`.`products`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `e_market_db`.`products` (
  `product_id` INT(4) NOT NULL AUTO_INCREMENT,
  `model` VARCHAR(45) NOT NULL,
  `upc` VARCHAR(13) NULL,
  `short_name` VARCHAR(45) NOT NULL,
  `long_name` VARCHAR(200) NOT NULL,
  `brand` VARCHAR(45) NULL,
  `shipping_type` VARCHAR(5) NULL,
  `quantity` INT(4) NULL DEFAULT 0,
  `list_price` DECIMAL(10,2) NULL,
  `shipping_cost` DECIMAL(10,2) NULL,
  `status` TINYINT(1) NULL DEFAULT 1,
  `status_reason` VARCHAR(45) NULL,
  `description` TEXT NULL,
  `condition_id` INT(4) NULL,
  PRIMARY KEY (`product_id`),
  INDEX `model_index` (`model` ASC),
  INDEX `condition_id_idx` (`condition_id` ASC),
  CONSTRAINT `condition_id`
    FOREIGN KEY (`condition_id`)
    REFERENCES `e_market_db`.`product_conditions` (`condition_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB

-- -----------------------------------------------------
-- Table `e_market_db`.`product_prices`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `e_market_db`.`product_prices` (
  `price_id` INT(10) NOT NULL AUTO_INCREMENT,
  `product_id` INT(4) NOT NULL,
  `listed_by_customer_id` INT(4) NOT NULL,
  `priority` INT(2) NULL DEFAULT 1,
  `price` DECIMAL(10,2) NULL,
  `date_start` DATE NULL,
  `date_end` DATE NULL,
  PRIMARY KEY (`price_id`, `product_id`, `listed_by_customer_id`),
  INDEX `product_id_idx` (`product_id` ASC),
  INDEX `listed_by_customer_id_2_idx` (`listed_by_customer_id` ASC),
  CONSTRAINT `product_id`
    FOREIGN KEY (`product_id`)
    REFERENCES `e_market_db`.`products` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `listed_by_customer_id_2`
    FOREIGN KEY (`listed_by_customer_id`)
    REFERENCES `e_market_db`.`customers` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB

-- -----------------------------------------------------
-- Table `e_market_db`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_market_db`.`orders` (
  `order_id` INT(10) NOT NULL AUTO_INCREMENT,
  `seller_customer_id` INT(4) NOT NULL,
  `buyer_customer_id` INT(4) NOT NULL,
  `seller_payment_address_id` INT(4) NOT NULL,
  `buyer_payment_address_id` INT(4) NOT NULL,
  `buyer_shipping_address_id` INT(4) NOT NULL,
  PRIMARY KEY (`order_id`, `seller_customer_id`, `buyer_customer_id`),
  INDEX `customer_id_idx` (`seller_customer_id` ASC),
  INDEX `buyer_customer_id_idx` (`buyer_customer_id` ASC),
  INDEX `buyer_address_id_idx` (`seller_payment_address_id` ASC),
  INDEX `buyer_pay_address_id_idx` (`buyer_payment_address_id` ASC),
  INDEX `buyer_shipping_address_id_idx` (`buyer_shipping_address_id` ASC),
  CONSTRAINT `seller_customer_id`
    FOREIGN KEY (`seller_customer_id`)
    REFERENCES `e_market_db`.`customers` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `buyer_customer_id`
    FOREIGN KEY (`buyer_customer_id`)
    REFERENCES `e_market_db`.`customers` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `seller_address_id`
    FOREIGN KEY (`seller_payment_address_id`)
    REFERENCES `e_market_db`.`addresses` (`address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `buyer_pay_address_id`
    FOREIGN KEY (`buyer_payment_address_id`)
    REFERENCES `e_market_db`.`addresses` (`address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `buyer_shipping_address_id`
    FOREIGN KEY (`buyer_shipping_address_id`)
    REFERENCES `e_market_db`.`addresses` (`address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `e_market_db`.`order_products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_market_db`.`order_products` (
  `order_id` INT(10) NOT NULL,
  `product_id` INT(4) NOT NULL,
  `count` INT(2) NULL,
  `sell_price` DECIMAL(10,2) NULL,
  `model` VARCHAR(45) NULL,
  `short_name` VARCHAR(45) NULL,
  PRIMARY KEY (`order_id`, `product_id`),
  INDEX `product_id_idx_2` (`product_id` ASC),
  CONSTRAINT `product_id_2`
    FOREIGN KEY (`product_id`)
    REFERENCES `e_market_db`.`products` (`product_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `e_market_db`.`orders` (`order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e_market_db`.`wishlists`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `e_market_db`.`wishlists` (
  `wishlist_id` INT(10) NOT NULL AUTO_INCREMENT,
  `customer_id` INT(4) NOT NULL DEFAULT 0,
  `wishlist_description` VARCHAR(200) NULL,
  `email` VARCHAR(100) NULL,
  PRIMARY KEY (`wishlist_id`, `customer_id`),
  INDEX `customer_id_idx` (`customer_id` ASC),
  CONSTRAINT `customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `e_market_db`.`customers` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB


-- -----------------------------------------------------
-- Table `e_market_db`.`product_attributes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_market_db`.`product_attributes` (
  `product_id` INT(4) NOT NULL,
  `attribute_id` INT(4) NOT NULL,
  `value` TEXT NULL,
  PRIMARY KEY (`product_id`, `attribute_id`),
  INDEX `attribute_id_idx` (`attribute_id` ASC),
  CONSTRAINT `product_id_3`
    FOREIGN KEY (`product_id`)
    REFERENCES `e_market_db`.`products` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `attribute_id`
    FOREIGN KEY (`attribute_id`)
    REFERENCES `e_market_db`.`attributes` (`attribute_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e_market_db`.`product_categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_market_db`.`product_categories` (
  `product_id` INT(4) NOT NULL,
  `category_id` INT(4) NOT NULL,
  PRIMARY KEY (`product_id`, `category_id`),
  INDEX `category_id_idx` (`category_id` ASC),
  CONSTRAINT `product_id_6`
    FOREIGN KEY (`product_id`)
    REFERENCES `e_market_db`.`products` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `category_id`
    FOREIGN KEY (`category_id`)
    REFERENCES `e_market_db`.`categories` (`category_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e_market_db`.`product_images`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_market_db`.`product_images` (
  `product_id` INT(4) NOT NULL,
  `image_path` VARCHAR(100) NULL,
  `image_order` INT(2) NULL,
  PRIMARY KEY (`product_id`),
  CONSTRAINT `primary_key`
    FOREIGN KEY (`product_id`)
    REFERENCES `e_market_db`.`products` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e_market_db`.`wishlist_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_market_db`.`wishlist_items` (
  `wishlist_id` INT(10) NOT NULL,
  `product_id` INT(4) NOT NULL,
  `add_date` DATE NULL,
  `count` INT(4) NULL,
  PRIMARY KEY (`wishlist_id`, `product_id`),
  INDEX `product_id_idx_3` (`product_id` ASC),
  CONSTRAINT `product_id_4`
    FOREIGN KEY (`product_id`)
    REFERENCES `e_market_db`.`products` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `wishlist_id`
    FOREIGN KEY (`wishlist_id`)
    REFERENCES `e_market_db`.`wishlists` (`wishlist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e_market_db`.`carts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_market_db`.`carts` (
  `cart_id` INT(10) NOT NULL AUTO_INCREMENT,
  `customer_id` INT(4) NULL,
  `creation_date` DATE NULL,
  `update_date` DATE NULL,
  PRIMARY KEY (`cart_id`),
  INDEX `cart_customer_id_idx` (`customer_id` ASC),
  CONSTRAINT `cart_customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `e_market_db`.`customers` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
-- -----------------------------------------------------
-- Table `e_market_db`.`cart_products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_market_db`.`cart_products` (
  `cart_id` INT(4) NOT NULL,
  `product_id` INT(4) NOT NULL,
  `count` INT(2) NULL,
  PRIMARY KEY (`cart_id`, `product_id`),
  INDEX `product_id_idx` (`product_id` ASC),
  CONSTRAINT `product_id_5`
    FOREIGN KEY (`product_id`)
    REFERENCES `e_market_db`.`products` (`product_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `cart_id`
    FOREIGN KEY (`cart_id`)
    REFERENCES `e_market_db`.`carts` (`cart_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e_market_db`.`product_masters_children`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_market_db`.`product_masters_children` (
  `product_id` INT(4) NOT NULL,
  `master_product_id` INT(4) NULL,
  PRIMARY KEY (`product_id`),
  INDEX `master_product_id_idx` (`master_product_id` ASC),
  CONSTRAINT `product_id_masters`
    FOREIGN KEY (`product_id`)
    REFERENCES `e_market_db`.`products` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `master_product_id`
    FOREIGN KEY (`master_product_id`)
    REFERENCES `e_market_db`.`products` (`product_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `e_market_db`.`urls`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `e_market_db`.`urls` (
  `url_id` INT(10) NOT NULL AUTO_INCREMENT,
  `search_key` VARCHAR(45) NULL,
  `url_text` VARCHAR(100) NULL,
  PRIMARY KEY (`url_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `e_market_db`.`wishlist_categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_market_db`.`wishlist_categories` (
  `wishlist_id` INT(10) NOT NULL AUTO_INCREMENT,
  `category_id` INT(4) NOT NULL,
  `add_date` DATE NULL,
  PRIMARY KEY (`wishlist_id`, `category_id`),
  INDEX `category_id_idx` (`category_id` ASC),
  CONSTRAINT `category_id_5`
    FOREIGN KEY (`category_id`)
    REFERENCES `e_market_db`.`categories` (`category_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `wishlist_id0`
    FOREIGN KEY (`wishlist_id`)
    REFERENCES `e_market_db`.`wishlists` (`wishlist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e_market_db`.`product_conditions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_market_db`.`product_conditions` (
  `condition_id` INT(4) NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`condition_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `e_market_db`.`addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_market_db`.`addresses` (
  `address_id` INT(4) NOT NULL AUTO_INCREMENT,
  `customer_id` INT(4) NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `address_1` VARCHAR(128) NULL,
  `address_2` VARCHAR(128) NULL,
  `city` VARCHAR(45) NULL,
  `zip_code` VARCHAR(10) NULL,
  `country` VARCHAR(45) NULL,
  PRIMARY KEY (`address_id`),
  INDEX `address_customer_id_idx` (`customer_id` ASC),
  CONSTRAINT `address_customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `e_market_db`.`customers` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
