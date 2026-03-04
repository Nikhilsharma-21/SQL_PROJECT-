-- DATA CLEANING
#Q1 show first 10 rows of data
select * from shop limit 10;

#Q2 find null values from table
select * from shop where transactions_id is null;
select * from shop where sale_date is null;
select * from shop where sale_time is null;

#Q4 find null values using  OR operators
SELECT 
    *
FROM
    shop
WHERE
    transactions_id IS NULL
        OR sale_date IS NULL
        OR sale_time IS NULL
        OR category IS NULL
        OR gender IS NULL
        OR quantiy IS NULL
        OR cogs IS NULL
        or total_sale is null;
        
--    select*from shop;     
--    select count(*) from shop;

#Q5 delete all null rows from table
delete from shop WHERE
    transactions_id IS NULL
        OR sale_date IS NULL
        OR sale_time IS NULL
        OR category IS NULL
        OR gender IS NULL
        OR quantiy IS NULL
        OR cogs IS NULL
        or total_sale is null;
        
        select count(*) from shop;
        
        -- DATA EXPLORATION
        
        #Q1 HOW MANY SALES WE HAVE
        select count(*) as total_sale from shop;
        
        #Q2 how many unique customers we have
        select count(distinct customer_id) as total_customer from shop;
        
        #Q3 how many total unique category we have
        select count( distinct category) as total_category from shop;
        
        #Q4 how many total unique category with their name we have
        select count( distinct category) as total_category,category from shop group by category;
        
        -- DATA ANALYSIS 
        #Q1 WAP to retrieve(लौटाना) all columns for sales made on '2022-11-05'
        select *from shop where sale_date = '2022-11-05' ;
        
        #Q2 WAP to retrieve(लौटाना) all columns for sales made on '2022-11-05' top 20 sales according to price 
        select *from shop where sale_date = '2022-11-05' order by price_per_unit desc limit 20;
        
        #Q3 WAP to retrieve all transactions where the catrgory is 'clothing' and the quantity sold is more than = 2 in the mon of nov-2022
        select category,sum(quantity) from shop where category = "clothing" group by 1;
         -- AND + date_format
         select * from shop where category = "clothing" AND date_format(sale_date ,"%Y-%m")= "2022-11" and quantity >=2;
        
         #Q4 rename columnname using alter 
--         alter table shop rename column quantiy to quantity;

#Q5 WAP to find total sale for each category 
select category, sum(total_sale) as total_sale, count(*) as total_orders from shop group by category ;

#Q6 WAP to find the average age of customer bying beauty product
select round(avg(age),0) as average_age,category from shop where category= "beauty" group by category;
#Q7 find all transactions of total sale where it is greater than 1000
select *from shop;
select * from shop where total_sale > 1000  order by total_sale desc;
#Q8  find all transactions of total sale where it is greater than 1000 and item is electronics
select * from shop where total_sale > 1000 and category = "electronics" order by total_sale desc;
select count(*) from shop where total_sale > 1000 and category = "electronics" order by total_sale desc;
#Q9 WAP  to find the total number of transactions made by each gender in each category
select gender, category,count(*) from shop group by category, gender;

#Q10 WAP  to calculate the average sale for each month . find out best selling month in each year
select *from shop;
select extract(year from sale_date)as year,extract(month from sale_date) as month,round(avg(total_sale),2) as average_sale,rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as "rank" from shop group by 1,2 ;

#Q11 WAP to fond the top 5 customers based on their highest total sale
select customer_id, sum(total_sale) as total_sale from shop group by customer_id order by total_sale desc limit 5;

#Q12 WAP to find the number of customer who purchased items from each category
select category,count( distinct customer_id) as "unique customer" from shop group by 1;  

#Q13 WAP to create each shift and number of orders example morning<12, afternoon <16, evening<20;
select *, case when extract(hour from sale_time) <12 then "morning" when extract(hour from sale_time) <16 then "afternoon" else "evening" end as shifts from shop;