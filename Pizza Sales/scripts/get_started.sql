create database pizza_sale;
select * from pizza_sale.pizzas;
select * from  pizza_sale.pizza_types;
-- import pizzas.csv & pizza_types.csv into tables

-- create Order table
create table orders (
order_id int not null,
order_date datetime not null,
order_time time not null,
primary key(order_id)
);

-- create Order_details table
create table order_details (
order_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity text not null,
primary key(order_details_id)
);

select * from  pizza_sale.orders;
select * from  pizza_sale.orders_details;