CREATE TABLE customers(
	customer_id smallint,
	customer_name varchar(100),
	customer_ceo varchar(50),
	customer_websites varchar(100),
	customer_description varchar(300),
	PRIMARY KEY (customer_id)
);



CREATE TABLE states(
	state_code char(2),
	state_name varchar(20),
  State_abbreviation varchar(10),
	PRIMARY KEY (state_code)
);


CREATE TABLE cities (
	city_id  integer,
	city_name varchar(50),
	state_code char(2),
	PRIMARY KEY (city_id),
	FOREIGN KEY (state_code) REFERENCES states(state_code)
);


CREATE TABLE sites(
	site_id integer,
	site_address varchar(100),
	zipcode char(5),
	longitude numeric(8,2),
	latitude numeric(8,2),
	city_id  integer,
	PRIMARY KEY (site_id),
	FOREIGN KEY (city_id) REFERENCES cities(city_id)
);



CREATE TABLE cust_sites(
	customer_id smallint,
	site_id integer,
	PRIMARY KEY (customer_id, site_id),
	FOREIGN KEY (site_id) REFERENCES sites(site_id),
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);



Create Table organizations (
org_id smallint,
org_name VARCHAR(50),
PRIMARY KEY (org_id));

Create Table categories (
cat_id smallint,
cat_name VARCHAR(50),
PRIMARY KEY(cat_id));

CREATE TABLE org_cat (
cat_id smallint,
org_id smallint,
FOREIGN KEY (cat_id) REFERENCES categories(cat_id),
FOREIGN KEY (org_id) REFERENCES organizations(org_id),
PRIMARY KEY (org_id,cat_id)
);


CREATE TABLE groups(
	group_id char(10),
	group_name char(8),
	cat_id int,
	PRIMARY KEY (group_id),
	FOREIGN KEY (cat_id) REFERENCES categories (cat_id) 
);


CREATE TABLE manufacturers(
	manu_id integer,
	manu_name varChar(50),
	PRIMARY KEY (manu_id)
);

CREATE TABLE plants(
	plant_id char(10),
	plant_name varChar(50),
	manu_id integer,
	PRIMARY KEY (plant_id),
	FOREIGN KEY (manu_id) REFERENCES manufacturers (manu_id)
);

CREATE TABLE suppliers(
	supplier_id integer,
	supplier_name varChar(50),
	supplier_website varChar(255),
	PRIMARY KEY (supplier_id)
);

CREATE TABLE manu_suppliers(
	supplier_id integer,
	manu_id integer,
	PRIMARY KEY (supplier_id, manu_id),
	FOREIGN KEY (supplier_id) REFERENCES suppliers (supplier_id),
	FOREIGN KEY (manu_id) REFERENCES manufacturers (manu_id)
);



CREATE TABLE products(
	product_id char(10),
	product_name varChar(20),
	group_id char(10),
	manu_id integer,
	PRIMARY KEY (product_id),
	FOREIGN KEY (group_id) REFERENCES groups (group_id),
	FOREIGN KEY (manu_id) REFERENCES manufacturers (manu_id)
);

CREATE TABLE inventories(
	product_id char(10),
	inv_quantity integer,
	inv_department char(1),
	FOREIGN KEY (product_id) REFERENCES products (product_id)
);

create table discounts 
(
discount_id smallint,
discount_rate numeric(2,1),
primary key (discount_id)
);

create table orders
(
	order_id char(12),
	total_sales numeric(10,2),
	discount_id smallint,
	customer_id smallint,
	primary key (order_id),
	foreign key (discount_id) references discounts(discount_id ),
	foreign key (customer_id) references customers(customer_id )
);


create table order_products(
order_id char(12),
product_id char(5),
product_quantity integer,
primary key (order_id, product_id),
foreign key (order_id) references orders(order_id ),
foreign key (product_id) references products(product_id )
);


CREATE TABLE materials(
material_id integer,
material_name varchar(30),
PRIMARY KEY (material_id)
);

CREATE TABLE supp_mater(
supplier_id integer,
material_id integer,
PRIMARY KEY (supplier_id, material_id),
FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
FOREIGN KEY (material_id) REFERENCES materials(material_id)
);



drop table customers;
drop table states;
drop table cities;
drop table cust_site;
drop table sites;
drop table orders;
drop table discounts;
drop table order_product;
drop table products;
drop table inventories;
drop table groups;
drop table categories;
drop table org_cat;
drop table organizations;
drop table manufacturers;
drop table plants;
drop table manu_supp;
drop table suppliers;
drop table supp_mater;
drop table materials;












