# SQL Interview Practice Questions for Product & Data Analytics

# 1. Find Top 3 Products per Category

-- Table: products
-- product_id
-- product_name
-- category
-- sales
--------

-- Write a query to find the top 3 highest-selling products in each category.
select
	category,
	product_id,
    product_name
From
	(
    select 
		category,
        product_id,
        product_name,
        sum(sales) as Total_Sales,
        dense_rank() over(partition by category order by sum(sales) DESC) as rnk
	from
		products
	group by category, product_id, product_name
    ) T
where rnk <= 3;

-- If interviever wants only three rows per catgeory, use row_number() instead of dense_rank().

# 2. Find Employees Earning More Than Department Average

-- Table: employees
-- employee_id
-- employee_name
-- department
-- salary
---------

-- Find employees whose salary is greater than the average salary of their department.

Select
	employee_id,
	employee_name,
    department,
    salary
from
	(
    Select
		employee_id,
        employee_name,
		department,
        salary,
        avg(salary) over(partition by department) as Dept_Wise_Avg_Salary
	From
		employees
    ) T
where salary > Dept_Wise_Avg_Salary;


-- Method 2: Using Correlated Subquery
SELECT
    employee_id,
    employee_name,
    department,
    salary
FROM employees e
WHERE salary >
(
    SELECT AVG(salary)
    FROM employees
    WHERE department = e.department
);

# 3. Detect Duplicate Emails
-- Table: customers
-- customer_id
-- customer_name
-- email
--------

-- Find duplicate customer emails.

select
	email
From
	customers
Group by Email
having count(*) > 1;

# 4. Find Latest Order for Each Customer

-- Table: orders
-- order_id
-- customer_id
-- order_date
-- amount
---------

-- Retrieve the latest order for every customer.

Select
	customer_id,
    order_id
From
	(
    Select
		customer_id,
        order_id,
        row_number() over(partition by customer_id order by order_date DESC, order_id DESC) as rnk
	From
		Orders
    ) T
where rnk = 1;

-- Logic
	-- DENSE_RANK() returns multiple rows if a customer has multiple orders on the same latest date.
	-- If only one latest order per customer is required, use ROW_NUMBER()
    
	-- order_date DESC → latest order first.
	-- order_id DESC → tie-breaker if same date exists.
    
# 5. Find Customers Who Never Placed Orders

-- Table: customers
-- customer_id
-- customer_name
----------------

-- Table: orders
-- order_id
-- customer_id
--------------

-- Find customers who never placed an order.
Select
	C.customer_id
From
	Customers C
Left Join 
	Orders O
On C.customer_id = O.Customer_id
where O.Customer_id is Null;

-- Method 2: Using NOT IN
SELECT
    customer_id,
    customer_name
FROM customers
WHERE customer_id NOT IN
(
    SELECT customer_id
    FROM orders
);


# 6. Find Second Highest Salary in Each Department

-- Table: employees
-- employee_id
-- department_id
-- salary
---------

-- Find employees with the second-highest salary in each department.

Select
	Department_id,
    Employee_id
From
	(
    Select
		Department_id,
		Employee_id,
        dense_rank() over(partition by department_id order by salary DESC) as RNK
	From
		Employees
    ) T
where rnk = 2;

# 7. Find Missing Dates in Sales Data

-- Table: calendar
-- date
-------

-- Table: sales
-- order_date
-- sales_amount
---------------

-- Find dates where no sales occurred.
Select C.Date
From Calendar C
Left Join Sales S
on C.date = S.order_date
where S.order_date is null;

# 8. Find Department with Highest Average Salary

-- Table: employees
-- employee_id
-- department
-- salary
---------

-- Find the department with the highest average salary.
with temp_cte as
(
Select
	Department,
    avg(salary) as Department_wise_avg_Salary
From
	Employees
Group by Department
)
select Department
From temp_cte
where Department_wise_avg_Salary in (select max(Department_wise_avg_Salary) from temp_cte);

# Method 2: Using subquery in from

SELECT
    department
FROM
(
    SELECT
        department,
        DENSE_RANK() OVER
        (
            ORDER BY AVG(salary) DESC
        ) AS rnk
    FROM employees
    GROUP BY department
) t
WHERE rnk = 1;

# Method 3: Using order by and limit 
-- Avoid this method as This will not handle ties.

SELECT
    department
FROM employees
GROUP BY department
ORDER BY AVG(salary) DESC
LIMIT 1;



# 9. Remove Duplicate Rows While Keeping Latest Record 

-- Table: employee_records
-- employee_id
-- updated_at
-- salary
---------

-- Remove duplicate employee records while keeping only the latest entry.

-- max(updated_at) as latest_records
DELETE e
FROM employee_records e
JOIN
(
    SELECT
        employee_id,
        MAX(updated_at) AS latest_updated_at
    FROM employee_records
    GROUP BY employee_id
) t
ON e.employee_id = t.employee_id
WHERE e.updated_at < t.latest_updated_at;

# Method 2:
DELETE FROM Employee_Records
WHERE (Employee_Id, Updated_At) NOT IN
(
    SELECT Employee_Id, MAX(Updated_At)
    FROM Employee_Records
    GROUP BY Employee_Id
);

# 10. Find Products Sold in Every Region

-- Table: sales
-- product_id
-- region
---------

-- Find products sold in all regions.

Select product_id
From sales
group by product_id
having count(distinct region) = (select count(distinct region) from sales);

# 11. Compare Current Month vs Previous Month Sales

-- Table: monthly_sales
-- month
-- total_sales

-- Compare current month sales with previous month sales.

Select
	month,
    total_Sales as current_month_sales,
    lag(total_sales) over(order by month) prev_month_sales
From
	monthly_sales;
    
    # Method 2: Including Difference
    SELECT
    month,
    total_sales AS current_month_sales,
    LAG(total_sales) OVER (ORDER BY month) AS prev_month_sales,
    total_sales - LAG(total_sales) OVER(ORDER BY month) AS sales_difference
FROM monthly_sales;

# 12. Find Customers with More Than 3 Orders but No Returns

-- Table: orders
-- order_id
-- customer_id

-- Table: returns
-- order_id

-- Find customers with more than 3 orders and no returns.

Select O.customer_id
From Orders O
Left join Returns R
On O.Order_id = R.Order_id
Group by O.Customer_id
having count(O.order_id) > 3 and count(R.Order_id) = 0;

# Method 2:
SELECT
    Customer_Id
FROM Orders
GROUP BY Customer_Id
HAVING COUNT(Order_Id) > 3
AND Customer_Id NOT IN
(
    SELECT DISTINCT O.Customer_Id
    FROM Orders O
    JOIN Returns R
    ON O.Order_Id = R.Order_Id
);


# 13. Find First and Last Purchase Date for Each Customer

-- Table: orders
-- customer_id
-- order_date
-------------

-- Find the first and last purchase date for every customer.
Select
	Customer_id,
    min(order_date) as First_Order_Date,
    max(order_date) as Last_Order_Date
From Orders
Group by customer_id;

# 14. Identify Sudden Spike in Daily Revenue

-- Table: daily_sales
-- sale_date
-- revenue
----------

-- Find dates where revenue increased by more than 50% compared to previous day.

With Temp_CTE as
(Select
	Sale_date,
    (revenue - lag(revenue) over(order by Sale_date))/lag(revenue) over(order by Sale_date) *100 as Revenue_per_diff
From
	Daily_sales
group by sale_date)
Select
	sale_date,
    Revenue_per_diff
From Temp_CTE
Where Revenue_per_diff > 50;

# 15. Find Manager-Employee Hierarchy

-- Table: employees
-- employee_id
-- employee_name
-- manager_id
-------------

-- Display employee names along with their manager names.

SELECT
    e2.employee_name AS manager_name,
    e1.employee_name AS employee_name
FROM employees e1
JOIN employees e2
ON e1.manager_id = e2.employee_id;

# 16. Find Top Customer by Revenue in Each Region

-- Table: customers
-- customer_id
-- region
---------

-- Table: orders
-- customer_id
-- revenue
----------

-- Find the top revenue-generating customer in every region.

Select Customer_id
From 
	(
    Select 
		C.customer_id,
        dense_rank() over(partition by Region order by sum(revenue) DESC) as RNK
	From Customers C
    Join Orders O
    On C.customer_id = O.Customer_id
    Group by C.customer_id, C.Region
    ) T
where rnk = 1;

# 17. Find Consecutive Login Days

-- Table: user_logins
-- user_id
-- login_date
-------------

-- Find users who logged in for 3 consecutive days.

with Temp_CTE as 
( select
	user_id,
    login_date as Current_Login,
    lag(login_date,2) over(partition by User_id order by login_date) as two_days_prev,
    lag(login_date,1) over(partition by User_id order by login_date) as Prev_day
From user_logins)

Select
	distinct user_id
 From Temp_CTE
 Where datediff(Prev_day, two_days_prev) = 1 AND datediff(Current_Login, Prev_day) = 1;


# 18. Find Rolling 7-Day Average Sales

-- Table: daily_sales
-- sale_date
-- sales_amount
---------------

-- Calculate rolling 7-day average sales.
Select
	sale_date,
    avg(sales_amount) over(order by sale_date rows between 6 preceding and current row) as Rolling_7_Day_AVG
From
	daily_sales;
    
# 19. Find Monthly Active Users

-- Table: user_activity
-- user_id
-- activity_date
----------------

-- Calculate monthly active users.
-- DATE_FORMAT(Signup_Date, '%Y-%m')

Select 
	date_format(activity_date, '%Y-%m') as active_month,
    count(distinct user_id) as Monthly_active_users
From user_activity
Group by date_format(activity_date, '%Y-%m');

# 20. Calculate Customer Retention

-- Table: users
-- user_id
-- signup_date
--------------

-- Table: logins
-- user_id
-- login_date
-------------

-- Calculate monthly retention by signup cohort.
	-- Find how many users from each signup month (cohort) returned and logged in again in later months.	
    
SELECT
    DATE_FORMAT(u.signup_date, '%Y-%m') AS signup_cohort,
    DATE_FORMAT(l.login_date, '%Y-%m') AS login_month,
    COUNT(DISTINCT u.user_id) AS retained_users
FROM users u
JOIN logins l
ON u.user_id = l.user_id
WHERE DATE_FORMAT(l.login_date, '%Y-%m') >= DATE_FORMAT(u.signup_date, '%Y-%m')
GROUP BY
    DATE_FORMAT(u.signup_date, '%Y-%m'),
    DATE_FORMAT(l.login_date, '%Y-%m')
ORDER BY
    signup_cohort,
    login_month;


# 21. Calculate Churn Rate

-- Table: subscriptions
-- customer_id
-- subscription_start
-- subscription_end
-------------------

-- Find monthly churn rate.
	-- Find percentage of customers who ended/cancelled subscriptions each month out of total active customers.
    
Select
	date_format(subscription_end, '%Y-%m') as churn_month,
    count(distinct customer_id) as churned_customers,
    round(count(distinct customer_id)/(select COUNT(DISTINCT customer_id) FROM subscriptions),2) as Churn_Rate
FROM subscriptions
WHERE subscription_end IS NOT NULL
GROUP BY DATE_FORMAT(subscription_end, '%Y-%m')
ORDER BY churn_month;


# 22. Find Users Who Purchased in Consecutive Months

-- Table: orders
-- customer_id
-- order_date

WITH Temp_CTE AS
(
    SELECT 
        Customer_Id,
        Order_Date,
        ROW_NUMBER() OVER
        (
            PARTITION BY Customer_Id
            ORDER BY Order_Date
        ) AS Row_Num
    FROM Orders
)

SELECT DISTINCT
    T1.Customer_Id
FROM Temp_CTE T1
JOIN Temp_CTE T2
ON T1.Customer_Id = T2.Customer_Id
AND T1.Row_Num = T2.Row_Num - 1
WHERE TIMESTAMPDIFF(MONTH, T1.Order_Date, T2.Order_Date) = 1;

# Method 2:

WITH temp_cte AS
(
    SELECT
        customer_id,
        DATE_FORMAT(order_date, '%Y-%m') AS order_month,
        LAG(DATE_FORMAT(order_date, '%Y-%m')) OVER
        (
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS prev_month
    FROM orders
)
SELECT DISTINCT customer_id
FROM temp_cte
WHERE TIMESTAMPDIFF
(
    MONTH,
    STR_TO_DATE(prev_month, '%Y-%m'),
    STR_TO_DATE(order_month, '%Y-%m')
) = 1;

# 23. Find Most Frequently Ordered Product

-- Table: orders
-- order_id
-- product_id
-------------

-- Find the most frequently ordered product.
with temp_cte as
(
select product_id, count(order_id) as count_
from orders
group by product_id
)

Select Product_id
From temp_cte
WHERE count_ = (SELECT MAX(count_) FROM temp_cte);

# 24. Find Customers with Highest Lifetime Value

-- Table: orders
-- customer_id
-- revenue
----------

-- Find top 10 customers based on lifetime value.

Select Customer_id
From
	(Select 
		Customer_id,
		dense_rank() over(order by sum(revenue) DESC) as rnk
	From Orders
	Group by Customer_id) T
Where rnk <= 10;

# 25. Find Average Order Value per Customer

-- Table: orders
-- order_id
-- customer_id
-- revenue
----------

-- Calculate average order value for each customer.

Select
	customer_id,
    ROUND(AVG(revenue), 2) AS average_order_value
From Orders
Group by customer_id;

# 26. Find Revenue Contribution Percentage by Category

-- Table: products
-- product_id
-- category
-----------

-- Table: sales
-- product_id
-- revenue
----------

-- Find revenue contribution percentage by category.

wITH Temp_CTE as
(
Select
	P.Category,
    sum(S.Revenue) as Revenue_by_category
From
	Products as P
Join Sales as S
On P.product_id = S.product_id
Group by P.Category
)
Select
	Category,
    Round((Revenue_by_category/sum(Revenue_by_category) over()) * 100,2) as Contri_Percentage
From
	Temp_cte;

# 27. Find Products Never Sold

-- Table: products
-- product_id
-- product_name
---------------

-- Table: sales
-- product_id
-------------

-- Find products never sold.

Select product_id
From Products P
Left Join Sales S
on P.Product_id = S.Product_id
where S.Product_id is null;

# 28. Find Daily Running Total Revenue

-- Table: daily_sales
-- sale_date
-- revenue
----------

-- Calculate cumulative revenue over time.
	-- rows between unbounded preceding and current row

Select 
	Sale_date,
    sum(revenue) over(order by sale_date rows between unbounded preceding and current row) as cum_revenue
From daily_sales;

# 29. Find Repeat Customers

-- Table: orders
-- customer_id
-- order_id
-----------

-- Find customers who placed more than one order.

Select Customer_id
From Orders
Group by customer_id
having count(order_id) > 1;

# 30. Find Users with No Activity in Last 30 Days

-- Table: user_activity
-- user_id
-- activity_date
----------------

-- Find inactive users.
	-- DATEADD(month, -2, '2017/08/25')

SELECT 
    user_id
FROM user_activity
GROUP BY user_id
HAVING MAX(activity_date) < CURDATE() - INTERVAL 30 DAY;


# 31. Find Highest Selling Product per Month

-- Table: sales
-- product_id
-- sales_amount
-- order_date
-------------

-- Find top-selling product every month.

Select
	date_format(order_date, '%Y-%m'),
	product_id

from
	(
    Select 
		date_format(order_date, '%Y-%m'),
		product_id,
        dense_rank() over(partition by date_format(order_date, '%Y-%m') order by sum(sales_amount) desc) as RNK
	From sales
     GROUP BY
        DATE_FORMAT(order_date, '%Y-%m'),
        product_id
    ) T
where rnk = 1;

# 32. Find Median Salary by Department

-- Table: employees
-- employee_id
-- department
-- salary
---------

-- Find median salary department-wise.



# 33. Find Conversion Rate from Signup to Purchase

-- Table: users
-- user_id
-- signup_date
--------------

-- Table: orders
-- customer_id
-- order_id
-----------

-- Calculate signup-to-purchase conversion rate.

select
	round(count(distinct O.customer_id)/count(U.User_id)*100,2) as conversion_rate
From USers U
join orders O
on U.user_id = O.customer_id;

# 34. Find Customers Who Ordered Every Month

-- Table: orders
-- customer_id
-- order_date
-------------

-- Find customers who ordered in every month of the year.

Select Distinct customer_id, Year(Order_Date) as Order_Year
From Orders
Group by customer_id, Year(Order_Date)
having count(distinct month(order_date)) = 12;

# 35. Find Longest Gap Between Purchases

-- Table: orders
-- customer_id
-- order_date
-------------

-- A. Find longest gap between two purchases for each customer.



-- B. Find the difference between the latest and second latest purchase

# 36. Find Top 5 Categories by Revenue

-- Table: products
-- product_id
-- category
-----------

-- Table: sales
-- product_id
-- revenue
----------

-- Find top 5 categories by total revenue.

# 37. Find Products with Declining Sales Trend

-- Table: monthly_sales
-- product_id
-- month
-- sales
--------

-- Identify products with declining sales for 3 consecutive months.

# 38. Find Users Who Added to Cart but Never Purchased

-- Table: cart_events
-- user_id
-- product_id
-------------

-- Table: orders
-- customer_id
-- product_id
-------------

-- Find users who abandoned carts.

# 39. Find Average Session Duration

-- Table: sessions
-- user_id
-- session_start
-- session_end
--------------

-- Calculate average session duration per user.

# 40. Find Top Performing Salesperson per Quarter

-- Table: sales
-- salesperson_id
-- quarter
-- revenue
----------

-- Find highest revenue-generating salesperson per quarter.

# 41. Find Duplicate Transactions

-- Table: transactions
-- transaction_id
-- customer_id
-- amount
-- transaction_date
-------------------

-- Identify duplicate transactions.

# 42. Find Users Retained After 30 Days

-- Table: users
-- user_id
-- signup_date
--------------

-- Table: activity
-- user_id
-- activity_date
----------------

-- Find users active after 30 days of signup.

# 43. Find Revenue Growth Percentage Month-over-Month

-- Table: monthly_sales
-- month
-- revenue
----------

-- Calculate MoM revenue growth percentage.

# 44. Find Customers with Highest Return Rate

-- Table: orders
-- order_id
-- customer_id
--------------

-- Table: returns
-- order_id
-----------

-- Find customers with highest return percentage.

# 45. Find Average Revenue per Active User

-- Table: user_activity
-- user_id
-- activity_date
----------------

-- Table: revenue
-- user_id
-- amount
---------

-- Calculate ARPU.

# 46. Find Most Popular Product Category by Region

-- Table: sales
-- product_id
-- region
-- quantity
-----------

-- Table: products
-- product_id
-- category
-----------

-- Find most popular category region-wise.

# 47. Find Percentage of Returning Customers

-- Table: orders
-- customer_id
-- order_id
-----------

-- Calculate percentage of returning customers.

# 48. Cohort Revenue Analysis

-- Table: customers
-- customer_id
-- signup_date
--------------

-- Table: orders
-- customer_id
-- order_date
-- revenue
----------

-- Calculate monthly cohort revenue.

# 49. Feature Adoption Analysis

-- Table: feature_usage
-- user_id
-- feature_name
-- usage_date
-------------

-- Find users who adopted a feature and compare retention.

# 50. Funnel Conversion Analysis

-- Table: funnel_events
-- user_id
-- stage_name
-- event_date
-------------

-- Calculate conversion percentage across funnel stages.

# 51. Find Top 5 Customers per Region

-- Table: customers
-- customer_id
-- region
---------

-- Table: orders
-- customer_id
-- revenue
----------

-- Find top 5 customers by revenue in each region.

# 52. Identify Revenue Anomalies

-- Table: daily_revenue
-- sale_date
-- revenue
----------

-- Identify unusual revenue spikes or drops.

# 53. Find Users with Multiple Devices

-- Table: logins
-- user_id
-- device_id
------------

-- Find users logging in from multiple devices.

# 54. Find Product Retention by Category

-- Table: purchases
-- customer_id
-- product_category
-- purchase_date
----------------

-- Analyze repeat purchases category-wise.

# 55. Find Average Time Between Orders

-- Table: orders
-- customer_id
-- order_date
-------------

-- Calculate average time gap between orders.

# 56. Find Fastest Growing Product

-- Table: monthly_sales
-- product_id
-- month
-- sales
--------

-- Find fastest growing product month-over-month.

# 57. Find Customers Who Purchased All Categories

-- Table: orders
-- customer_id
-- category
-----------

-- Find customers who purchased from every category.

# 58. Find Rolling 30-Day Revenue

-- Table: daily_sales
-- sale_date
-- revenue
----------

-- Calculate rolling 30-day revenue.

# 59. Find Most Retained Cohort

-- Table: users
-- user_id
-- signup_date
--------------

-- Table: activity
-- user_id
-- activity_date
----------------

-- Identify cohort with highest retention.

# 60. Debug Revenue Mismatch in Dashboard

-- Table: dashboard_sales
-- date
-- revenue
----------

-- Table: raw_sales
-- order_date
-- revenue
----------

-- Validate why dashboard revenue differs from raw sales.