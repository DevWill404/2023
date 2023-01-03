CREATE TABLE IF NOT EXISTS rol(
	id SERIAL NOT NULL,
	name VARCHAR (50) NOT NULL,
	description VARCHAR(200) NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS users(
	id SERIAL NOT NULL,
	names VARCHAR(100) NOT NULL,
	lastname VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL,
	password VARCHAR(100) NOT NULL,
	old_password VARCHAR(100) NOT NULL,
	address VARCHAR(160),
	created_at DATE NOT NULL,
	updated_at DATE NOT NULL,
	rol_id SERIAL NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(rol_id) REFERENCES rol(id)
	
);

CREATE TABLE IF NOT EXISTS payment_method(
	id SERIAL NOT NULL,
	name VARCHAR(100) NOT NULL,
	description VARCHAR(120) NOT NULL
);

CREATE TABLE IF NOT EXISTS payment_state(
	id SERIAL NOT NULL,
	name VARCHAR(100) NOT NULL,
	description VARCHAR(120) NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS order_state(
	id SERIAL NOT NULL,
	name VARCHAR(100) NOT NULL,
	description VARCHAR(120) NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS category(
	id SERIAL NOT NULL,
	name VARCHAR(100) NOT NULL,
	description VARCHAR(120) NOT NULL,
	abbreviation VARCHAR(3) NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS subcategory(
	id SERIAL NOT NULL,
	name VARCHAR(100) NOT NULL,
	description VARCHAR(120) NOT NULL,
	abbreviation VARCHAR(3) NOT NULL,
	category_id SERIAL NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(category_id) REFERENCES category(id)
);

CREATE TABLE IF NOT EXISTS country(
	id SERIAL NOT NULL,
	name VARCHAR(100) NOT NULL,
	zip_code int NOT NULL,
	abbreviation VARCHAR(3) NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS state(
	id SERIAL NOT NULL,
	name VARCHAR(100) NOT NULL,
	zip_code int NOT NULL,
	abbreviation VARCHAR(3) NOT NULL,
	country_id SERIAL NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(country_id) REFERENCES country(id)
);

CREATE TABLE IF NOT EXISTS town(
	id SERIAL NOT NULL,
	name VARCHAR(100) NOT NULL,
	zip_code int NOT NULL,
	abbreviation VARCHAR(3) NOT NULL,
	state_id SERIAL NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(state_id) REFERENCES state(id)
);


CREATE TABLE IF NOT EXISTS product(
	id SERIAL NOT NULL,
	name VARCHAR(100) NOT NULL,
	description VARCHAR(255) NOT NULL,
	color VARCHAR(20) NOT NULL,
	price DECIMAL NOT NULL,
	photo VARCHAR(255) NOT NULL,
	SKU VARCHAR(60) NOT NULL,
	created_by SERIAL not null,
	subcategory_id SERIAL NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(created_by) REFERENCES users(id),
	FOREIGN KEY(subcategory_id) REFERENCES subcategory(id)
);


CREATE TABLE IF NOT EXISTS shopping_car_state(
	id SERIAL NOT NULL,
	name VARCHAR(50) NOT NULL,
	description VARCHAR(100) NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS shopping_car(
	id SERIAL NOT NULL,
	product_id SERIAL NOT NULL,
	state_id SERIAL NOT NULL,
	created_by SERIAL NOT NULL,
	quantity INT NOT NULL,
	total_price DECIMAL NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(product_id) REFERENCES product(id),
	FOREIGN KEY(state_id) REFERENCES shopping_car_state(id),
	FOREIGN KEY(created_by) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS orders(
	id SERIAL NOT NULL,
	town_id SERIAL NOT  NULL,
	payment_method_id SERIAL NOT NULL,
	payment_state_id SERIAL NOT NULL,
	order_state_id SERIAL NOT NULL,
	shopping_car_id SERIAL NOT NULL,
	total DECIMAL NOT NULL,
	subtotal DECIMAL NOT NULL,
	address VARCHAR(100) NOT NULL,
	date_delivery DATE NOT NULL,
	created_at DATE NOT NULL,
	updated_at DATE NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(town_id) REFERENCES town(id),
	FOREIGN KEY(payment_method_id) REFERENCES payment_method(id),
	FOREIGN KEY(payment_state_id) REFERENCES payment_state(id),
	FOREIGN KEY(order_state_id) REFERENCES order_state(id),
	FOREIGN KEY(shopping_car_id) REFERENCES shopping_car(id)
);
