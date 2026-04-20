######## SQL Sales Analysis Project ########


## Database creation


create database Project; 

use Project;

show databases;


## Table creation


create table Sales (
sales_id int primary key,
customer_name varchar(50),
customer_id int,
product_name varchar(50),
product_id int,
sale_date datetime,
qty int,
unit_price decimal(10,2),
amount decimal(10,2),
sales_region varchar(50),
region_id int,
foreign key(customer_id) references customer(customer_id),
foreign key(product_id) references product(product_id),
foreign key(region_id) references region(region_id)
);

select * from Sales;  --- to get the data from Sales table ---

create table product(
product_id int primary key,
product_name varchar(50),
qty_in_stock int,
unit_price decimal(10,2)
);

select * from product;

create table customer(
customer_id int primary key,
customer_name varchar(50),
contact_no varchar(25),
gender varchar(10),
Age int
);

select * from customer;

create table region(
region_id int primary key,
region_name varchar(20),
zone varchar(20)
);

select * from region;


## Insert values in the table

insert into Sales
(sales_id ,customer_name , customer_id , product_name, product_id, sale_date, qty, unit_price, amount, sales_region, region_id) values
(001, "Yashi Srivastava", 002, "Pen", 002 , "2026-04-19", 5, 5, 25, "North",001),
(002, "Gauri Srivastava", 004, "Pen", 002 , "2026-04-19", 10, 5, 50, "South",002),
(003, "Utkasrh Srivastava", 006, "Pen", 002 , "2026-04-19", 20, 5, 100, "East",003),
(004, "Sanya Srivastava", 008, "Chart", 001 , "2026-04-19", 1, 20, 20, "East",003),
(005, "Virat Bansal", 010, "Chart", 001 , "2026-04-19", 2, 20, 40, "North",001),
(006, "Arush Triverdi", 003, "Colour Box", 003 , "2026-04-19", 4, 200, 800, "South",002),
(007, "Aarohi Gupta", 009, "Notebook", 004 , "2026-04-19", 10, 150, 1500, "East",003),
(008, "Aman Pal", 001, "Notebook", 004 , "2026-04-19", 3, 150 , 450, "West",004),
(009, "Manya Gaur", 005, "Stickers", 005 , "2026-04-19", 6, 10, 60, "North",001),
(010, "Prakriti Sharma", 007, "Pen", 002 , "2026-04-19", 2, 5, 10, "North",001);


insert into product
(product_id, product_name, qty_in_stock, unit_price) values
(001, "Chart", 200, 20),
(002, "Pen", 1000, 5),
(003, "Colour Box", 500, 200),
(004, "Notebook", 4000, 150),
(005, "Stickers", 4500, 10);

insert into customer
(customer_id, customer_name, contact_no, gender, Age) values
(001, "Aman Pal", "9226836718", "Male", 20),
(002, "Yashi Srivastava", "9226836568", "Female", 23),
(003, "Arush Trivedi", "9226836720", "Male", 15),
(004, "Gauri Srivastava", "9126836718", "Female", 19),
(005, "Manya Gaur", "9226833618", "Female", 26),
(006, "Utkarsh Srivastava", "9228936718", "Male", 14),
(007, "Prakriti Sharma", "9206836718", "Female", 21),
(008, "Sanya Srivastava", "9226006718", "Female", 23),
(009, "Aarohi Gupta", "9556836718", "Female", 14),
(010, "Virat Bansal", "9226893718", "Male", 45);

insert into region 
(region_id, region_name, zone) values
(001, "North", "Urban"),
(002, "South", "Urban"),
(003, "East", "Urban"),
(004, "West", "Rural");


#### Queries ####


## Query 1 - Which product sells the most?


select product_name, sum(qty) as total_qty from Sales -- Sum function , Aliases , Group by , Order by and Limit are used here --
group by product_name
order by total_qty desc
limit 1;


## Query 2 - Which region generates the highest revenue?


select sales_region , sum(amount) as total_revenue from Sales -- Sum function , Aliases , Group by , Order by and Limit are used here --
group by sales_region
order by total_revenue desc
limit 1;


## Query 3 - Which region generates the most sales?

select sales_region, sum(qty) as total_qty from Sales -- Sum function , Aliases, Group by , Order by and Limit are used here --
group by sales_region
order by total_qty desc
limit 1;


## Query 4 - Which zone generated the most sales?


select zone, sum(qty) as total_qty  from region -- Sum function , Aliases , inner join , Group by , Order by and Limit are used here --
inner join Sales 
on region.region_id = Sales.region_id
group by zone
order by total_qty desc
limit 1;


## Query 5 - Who is the highest spending customer? 


select customer_name, sum(amount) as total_revenue from Sales -- Sum function , Aliases , Group by , Order by and Limit are used here --
group by customer_name
order by total_revenue desc
limit 1;


## Query 6 - What are the details of the customer spending the most?


select customer.customer_name, sum(Sales.amount), contact_no, gender, Age from customer -- Sum function , Inner join, Group by , Order by and Limit are used here --
inner join Sales
on customer.customer_id = Sales.customer_id
group by customer_name
order by sum(Sales.amount) desc
limit 1;

## Query 7 - Who is the customers spending more than the average speding of all the customers?

select customer_name, amount from Sales -- Group by , Aliases , Having , Sub Query , Order by and Average Function are used here --
group by customer_name 
having amount > (select avg(amount) as avgamount_of_all_customers from Sales)
order by amount desc;


## Query 8 - Gender wise revenue generation.


select customer.gender, sum(Sales.amount) from customer -- Sum function , inner join , Group by , Order by and Limit are used here --
inner join Sales
on customer.customer_id = Sales.customer_id
group by gender
order by sum(Sales.amount) desc;


## Query 9 - Categorize sales by amount.


select customer_name, amount, -- Case is used here --
case
when amount >= 1000 then 'High Value'
when amount between 100 and 999 then 'Medium Value'
else 'Low Value'
end as sale_category
from Sales;


## Query 10 - Age group classification.


select customer_name, Age, -- Case is used here --
case 
when Age < 18 then 'Teen'
when Age between 18 and 30 then 'Young Adult'
when Age between 31 and 50 then 'Adult'
else 'Senior'
end as age_group
from customer;


## Query 11 - Which age group has the most customers? -- Subquery is used as a derived table . Aliases , Case , Group By , Order By and Limit are used here. --


select age_group, count(*) as total_customers
from (
    select customer_name, Age,
    case 
        when Age < 18 then 'Teen'
        when Age between 18 and 30 then 'Young Adult'
        when Age between 31 and 50 then 'Adult'
        else 'Senior'
    end as age_group
    from customer
) as age_data
group by age_group
order by total_customers desc
limit 1;


######## End of the project ########








 




























 




