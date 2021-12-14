create database Instacart;
use Instacart;

create table orders 
	(order_id varchar(25) not null,
    user_id varchar(25) not null,
    eval_set varchar(25) not null,
    order_number varchar(25) not null,
    order_dow int not null,
    order_hour_of_day int not null,
    days_since_prior varchar(25) not null,
	PRIMARY KEY (order_id));

create table products
	(product_id int not null,
    product_name varchar(225) null,
    aisle_id int not null,
    department_id int not null,
    PRIMARY KEY (product_id));


create table aisles 
	(aisle_id varchar(50) not null,
    aisle varchar(50) not null,
    PRIMARY KEY (aisle_id));
 
create table departments
	(department_id varchar(25) not null,
    department varchar(25) not null,
    PRIMARY KEY (department_id));
    
create table order_products__train
	(order_id  varchar(25) not null,
    product_id varchar(25) not null,
    add_to_cart_order integer  not null,
    reordered integer not null,
    PRIMARY KEY (order_id, product_id));
    
create table order_products__prior
	(order_id varchar(25) not null,
    product_id varchar(25) not null,
    add_to_cart_order integer not null,
    reordered integer not null,
    PRIMARY KEY (order_id, product_id));
 
        


