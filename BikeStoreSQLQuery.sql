--First View the nine tables to understand the dataset before manipulating them. You can get the data by clicking on the following link address
/*
link :http://www.sqlservertutorial.net/load-sample-database/
*/

SELECT *
FROM sales.staffs

SELECT *
FROM sales.stores

SELECT *
FROM sales.orders

SELECT *
FROM sales.order_items

SELECT *
FROM sales.customers

SELECT *
FROM production.stocks

SELECT *
FROM production.products

SELECT *
FROM production.categories

SELECT *
FROM production.brands

--Create one table consisting of the following column names; order_id, order_date, customers_name, city, state, total_units, revenue, product_name
--category_name, store_name and sales_rep.
--Revenue is to be calculated by getting the SUM of the product of quantity and list_price
--Transfer the table to Excel workbook for cleaning.

SELECT
	sales.orders.order_id,
	sales.orders.order_date,
	CONCAT(sales.customers.first_name, ' ', sales.customers.last_name) AS 'customers_name',
	sales.customers.city,
	sales.customers.state,
	SUM(sales.order_items.quantity) AS 'total_units',
	SUM(sales.order_items.quantity * sales.order_items.list_price) AS 'revenue',
	production.products.product_name,
	production.categories.category_name,
	sales.stores.store_name,
	CONCAT(sales.staffs.first_name, ' ', sales.staffs.last_name) AS 'sales_rep',
	production.brands.brand_name
FROM
	sales.orders
JOIN
	sales.customers 
ON sales.orders.customer_id = sales.customers.customer_id
JOIN
	sales.order_items
ON sales.orders.order_id = sales.order_items.order_id
JOIN
	production.products
ON sales.order_items.product_id = production.products.product_id
JOIN 
	production.categories
ON production.products.category_id = production.categories.category_id
JOIN
	sales.stores
ON sales.orders.store_id = sales.stores.store_id
JOIN
	sales.staffs
ON sales.orders.staff_id = sales.staffs.staff_id
JOIN
	production.brands
ON production.products.brand_id = production.brands.brand_id
GROUP BY
	sales.orders.order_id,
	sales.orders.order_date,
	CONCAT(sales.customers.first_name, ' ', sales.customers.last_name),
	sales.customers.city,
	sales.customers.state,
	production.products.product_name,
	production.categories.category_name,
	sales.stores.store_name,
	CONCAT(sales.staffs.first_name, ' ', sales.staffs.last_name),
	production.brands.brand_name

