-- Create the database
CREATE DATABASE ecommerce_store;
USE ecommerce_store;

-- Create the products table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    brand ENUM('Easy', 'Rich Man', 'Cats Eye', 'Dorjibari') NOT NULL,
    color ENUM('Red', 'Blue', 'Black', 'White') NOT NULL,
    size ENUM('XS', 'S', 'M', 'L', 'XL') NOT NULL,
    price INT CHECK (price BETWEEN 1 AND 50000),
    stock_quantity INT NOT NULL,
    UNIQUE KEY brand_color_size (brand, color, size)
);

-- Create the discounts table
CREATE TABLE discounts (
    discount_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    pct_discount DECIMAL(5,2) CHECK (pct_discount BETWEEN 0 AND 100),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Create a stored procedure to populate the products table
DELIMITER $$
CREATE PROCEDURE PopulateTShirts()
BEGIN
    DECLARE counter INT DEFAULT 0;
    DECLARE max_records INT DEFAULT 1000;
    DECLARE brand ENUM('Easy', 'Rich Man', 'Cats Eye', 'Dorjibari');
    DECLARE color ENUM('Red', 'Blue', 'Black', 'White');
    DECLARE size ENUM('XS', 'S', 'M', 'L', 'XL');
    DECLARE price INT;
    DECLARE stock INT;
    DECLARE discount INT;

    -- Seed the random number generator
    SET SESSION rand_seed1 = UNIX_TIMESTAMP();

    WHILE counter < max_records DO
        -- Generate random values
        SET brand = ELT(FLOOR(1 + RAND() * 4), 'Easy', 'Rich Man', 'Cats Eye', 'Dorjibari');
        SET color = ELT(FLOOR(1 + RAND() * 4), 'Red', 'Blue', 'Black', 'White');
        SET size = ELT(FLOOR(1 + RAND() * 5), 'XS', 'S', 'M', 'L', 'XL');
        SET price = FLOOR(10 + RAND() * 500);
        SET stock = FLOOR(10 + RAND() * 1000);
        SET discount = FLOOR(0 + RAND() * 51);

        -- Attempt to insert a new record
        -- Duplicate brand, color, size combinations will be ignored due to the unique constraint
        -- warp in a transaction for mysql
        
        START TRANSACTION;
        BEGIN
            DECLARE CONTINUE HANDLER FOR 1062 BEGIN END;  -- Handle duplicate key error
            INSERT INTO products (brand, color, size, price, stock_quantity)
            VALUES (brand, color, size, price, stock);
            SET counter = counter + 1;
            INSERT INTO discounts (product_id, pct_discount)
            VALUES (LAST_INSERT_ID(), discount);
        END;
        COMMIT;
    END WHILE;
END$$
DELIMITER ;

-- Call the stored procedure to populate the products table
CALL PopulateTShirts();