CREATE DATABASE IF NOT EXISTS pizzeria_management 
  DEFAULT CHARACTER SET utf8mb4 
  DEFAULT COLLATE utf8mb4_0900_ai_ci 
  ENGINE=InnoDB 


USE pizzeria_management;

CREATE TABLE role (
  id_role INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(45) NOT NULL,
  description VARCHAR(255) NOT NULL,
  right_lvl INT NOT NULL,
  PRIMARY KEY (id_role)
) AUTO_INCREMENT=5;

CREATE TABLE address (
  id_address INT NOT NULL AUTO_INCREMENT,
  street_number VARCHAR(10) NULL,
  street_or_district_name VARCHAR(255) NOT NULL,
  postal_code VARCHAR(10) NOT NULL,
  city_name VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_address)
);

CREATE TABLE ingredient (
  id_ingredient INT NOT NULL AUTO_INCREMENT,
  name_ingredient VARCHAR(150) NOT NULL,
  capacity VARCHAR(20) NOT NULL,
  price DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (id_ingredient)
);

CREATE TABLE account (
  id_account INT NOT NULL AUTO_INCREMENT,
  password VARCHAR(255) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  first_name VARCHAR(45) NOT NULL,
  tel VARCHAR(20) NOT NULL,
  create_time timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  id_address INT NOT NULL,
  id_role INT NOT NULL,
  PRIMARY KEY (id_account),
  INDEX id_address_idx (id_address) VISIBLE,
  INDEX id_role_idx (id_role) VISIBLE,
  CONSTRAINT id_account_address
    FOREIGN KEY (id_address)
    REFERENCES address (id_address)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT id_account_role
    FOREIGN KEY (id_role)
    REFERENCES role (id_role)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE pizzeria (
  id_pizzeria INT NOT NULL AUTO_INCREMENT,
  pizzeria_name VARCHAR(20) NOT NULL,
  is_open TINYINT NOT NULL DEFAULT 0,
  tel VARCHAR(20) NOT NULL,
  id_address INT NOT NULL,
  PRIMARY KEY (id_pizzeria),
  INDEX id_address_idx (id_address) VISIBLE,
  CONSTRAINT id_pizzeria_address
    FOREIGN KEY (id_address)
    REFERENCES address (id_address)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE ingredient_stock (
  id_ingredient INT NOT NULL,
  id_pizzeria INT NOT NULL,
  stock_quantity INT NULL DEFAULT 0,
  PRIMARY KEY (id_ingredient, id_pizzeria),
  INDEX id_pizzeria_stock_idx (id_pizzeria) VISIBLE,
  INDEX id_ingredient_stock_idx (id_ingredient) VISIBLE,
  CONSTRAINT id_ingredient_stock
    FOREIGN KEY (id_ingredient)
    REFERENCES ingredient (id_ingredient)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT id_pizzeria_stock
    FOREIGN KEY (id_pizzeria)
    REFERENCES pizzeria (id_pizzeria)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE pizza (
  id_pizza INT NOT NULL AUTO_INCREMENT,
  name_pizza VARCHAR(150) NOT NULL,
  description VARCHAR(255) NOT NULL,
  picture BLOB DEFAULT NULL,
  price DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (id_pizza),
  UNIQUE INDEX name_pizza_UNIQUE (name_pizza) VISIBLE
);

CREATE TABLE recipe (
  id_pizza INT NOT NULL,
  id_ingredient INT NOT NULL,
  ingredient_quantity INT NOT NULL,
  PRIMARY KEY (id_pizza, id_ingredient),
  INDEX recipe_id_ingredient_idx (id_ingredient ASC) VISIBLE,
  CONSTRAINT recipe_id_pizza
    FOREIGN KEY (id_pizza)
    REFERENCES pizza (id_pizza)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT recipe_id_ingredient
    FOREIGN KEY (id_ingredient)
    REFERENCES ingredient (id_ingredient)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE command (
  id_command INT NOT NULL AUTO_INCREMENT,
  create_time TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  status VARCHAR(150) NOT NULL,
  is_payed TINYINT NOT NULL DEFAULT 0,
  id_client INT NOT NULL,
  id_pizzeria INT NOT NULL,
  id_deliverer INT NULL,
  PRIMARY KEY (id_command),
  INDEX id_client_idx (id_client ASC) VISIBLE,
  INDEX id_order_pizzeria_idx (id_pizzeria ASC) VISIBLE,
  INDEX id_deliverer_idx (id_deliverer ASC) VISIBLE,
  CONSTRAINT id_client
    FOREIGN KEY (id_client)
    REFERENCES pizzeria_management.account (id_account)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT id_order_pizzeria
    FOREIGN KEY (id_pizzeria)
    REFERENCES pizzeria (id_pizzeria)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT id_deliverer
    FOREIGN KEY (id_deliverer)
    REFERENCES account (id_account)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE command_line (
  id_command_line INT NOT NULL AUTO_INCREMENT,
  id_pizza INT NOT NULL,
  id_command INT NOT NULL,
  pizza_quantity INT NOT NULL,
  comments VARCHAR(200) NULL,
  PRIMARY KEY (id_command_line),
  INDEX id_command_pizza_idx (id_pizza ASC) VISIBLE,
  INDEX id_command_command_idx (id_command ASC) VISIBLE,
  CONSTRAINT id_line_pizza
    FOREIGN KEY (id_pizza)
    REFERENCES pizzeria_management.pizza (id_pizza)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT id_line_command
    FOREIGN KEY (id_command)
    REFERENCES pizzeria_management.command (id_command)
    ON DELETE CASCADE
    ON UPDATE CASCADE);