# SQL Interview Practice Questions for Product & Data Analytics

# 1. Find Top 3 Products per Category

-- Table: products
-- product_id
-- product_name
-- category
-- sales
--------

-- Write a query to find the top 3 highest-selling products in each category.

# 2. Find Employees Earning More Than Department Average

-- Table: employees
-- employee_id
-- employee_name
-- department
-- salary
---------

-- Find employees whose salary is greater than the average salary of their department.

# 3. Detect Duplicate Customers Based on Email

-- Table: customers
-- customer_id
-- customer_name
-- email
--------

-- Find duplicate customer emails.

# 4. Find Latest Order for Each Customer

-- Table: orders
-- order_id
-- customer_id
-- order_date
-- amount
---------

-- Retrieve the latest order for every customer.

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

# 6. Find Second Highest Salary in Each Department

-- Table: employees
-- employee_id
-- department_id
-- salary
---------

-- Find employees with the second-highest salary in each department.


# 7. Find Missing Dates in Sales Data

-- Table: calendar
-- date
-------

-- Table: sales
-- order_date
-- sales_amount
---------------

-- Find dates where no sales occurred.

# 8. Find Department with Highest Average Salary

-- Table: employees
-- employee_id
-- department
-- salary
---------

-- Find the department with the highest average salary.

# 9. Remove Duplicate Rows While Keeping Latest Record

-- Table: employee_records
-- employee_id
-- updated_at
-- salary
---------

-- Remove duplicate employee records while keeping only the latest entry.


# 10. Find Products Sold in Every Region

-- Table: sales
-- product_id
-- region
---------

-- Find products sold in all regions.

# 11. Compare Current Month vs Previous Month Sales

-- Table: monthly_sales
-- month
-- total_sales
-- Compare current month sales with previous month sales.

# 12. Find Customers with More Than 3 Orders but No Returns

-- Table: orders
-- order_id
-- customer_id

-- Table: returns
-- order_id

-- Find customers with more than 3 orders and no returns.

# 13. Find First and Last Purchase Date for Each Customer

-- Table: orders
-- customer_id
-- order_date
-------------

-- Find the first and last purchase date for every customer.

# 14. Identify Sudden Spike in Daily Revenue

-- Table: daily_sales
-- sale_date
-- revenue
----------

-- Find dates where revenue increased by more than 50% compared to previous day.


# 15. Find Manager-Employee Hierarchy

-- Table: employees
-- employee_id
-- employee_name
-- manager_id
-------------

-- Display employee names along with their manager names.

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

# 17. Find Consecutive Login Days

-- Table: user_logins
-- user_id
-- login_date
-------------

-- Find users who logged in for 3 consecutive days.


# 18. Find Rolling 7-Day Average Sales

-- Table: daily_sales
-- sale_date
-- sales_amount
---------------

-- Calculate rolling 7-day average sales.

# 19. Find Monthly Active Users

-- Table: user_activity
-- user_id
-- activity_date
----------------

-- Calculate monthly active users.

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




# 21. Calculate Churn Rate

-- Table: subscriptions
-- customer_id
-- subscription_start
-- subscription_end
-------------------

-- Find monthly churn rate.

# 22. Find Users Who Purchased in Consecutive Months

-- Table: orders
-- customer_id
-- order_date

# 23. Find Most Frequently Ordered Product

-- Table: orders
-- order_id
-- product_id
-------------

-- Find the most frequently ordered product.

# 24. Find Customers with Highest Lifetime Value

-- Table: orders
-- customer_id
-- revenue
----------

-- Find top 10 customers based on lifetime value.

# 25. Find Average Order Value per Customer

-- Table: orders
-- order_id
-- customer_id
-- revenue
----------

-- Calculate average order value for each customer.

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

# 27. Find Products Never Sold

-- Table: products
-- product_id
-- product_name
---------------

-- Table: sales
-- product_id
-------------

-- Find products never sold.

# 28. Find Daily Running Total Revenue

-- Table: daily_sales
-- sale_date
-- revenue
----------

-- Calculate cumulative revenue over time.
-- rows between unbounded preceding and current row

# 29. Find Repeat Customers

-- Table: orders
-- customer_id
-- order_id
-----------

-- Find customers who placed more than one order.

# 30. Find Users with No Activity in Last 30 Days

-- Table: user_activity
-- user_id
-- activity_date
----------------

-- Find inactive users.
-- DATEADD(month, -2, '2017/08/25')

# 31. Find Highest Selling Product per Month

-- Table: sales
-- product_id
-- sales_amount
-- order_date
-------------

-- Find top-selling product every month.

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

# 34. Find Customers Who Ordered Every Month

-- Table: orders
-- customer_id
-- order_date
-------------

-- Find customers who ordered in every month of the year.

# 35. Find Longest Gap Between Purchases

-- Table: orders
-- customer_id
-- order_date
-------------

-- Find longest gap between two purchases for each customer.
# Find the difference between the latest and second latest purchase

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