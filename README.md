# Sales Data Analysis and Visualization Using MySQL and Tableau

This project involves designing and implementing a MySQL database for a sales dataset, performing data cleaning, normalization, and denormalization processes. Additionally, it utilizes SQL queries to extract valuable insights from the data, covering aspects such as product sales, customer analysis, and order status. The results are then visualized using Tableau for effective data storytelling.

## Project Overview

The primary objective of this project is to demonstrate proficiency in database management, data cleaning, normalization, SQL querying, and data visualization techniques. By leveraging MySQL and Tableau, we aim to derive meaningful insights from a sales dataset and present them in a visually appealing and interactive manner.

## Technologies Used

- MySQL
- SQL
- Python (for data preprocessing)
- Tableau

## Data Preprocessing

1. Obtained a denormalized dataset, specifically the "Sample Sales Data," from Kaggle.
2. Performed data cleaning by removing non-essential columns and addressing values containing special characters.
3. Normalized the dataset by breaking it down into four distinct tables: Sales, Product, Customer, and OrderDetailJunction.
4. Removed duplicates from the Product and Customer tables.
5. Created a junction table named "OrderDetailJunction" to establish relationships between the Sales, Product, and Customer tables.
6. Inserted the pre-processed and refined data into the corresponding MySQL tables.

## SQL Queries

Implemented a series of SQL queries to extract valuable insights from the sales data, including:

- Total sales by product category
- Total quantity sold of each product
- Top customers by total sales amount
- Total sales by year
- Order status breakdown
- Best-selling products
- Sales by customer city
- Order status percentage breakdown
- Top customers by average order amount
- Sales by month and year
- Moving annual total sales by year
- Order status percentage breakdown by year
- Sales by country and deal size
- Sales percentage by country
- Total sales by product category and country

## Data Visualization

Converted the SQL output data to CSV files for data visualization purposes. Utilized Tableau to create an interactive dashboard, offering visual representations of the following insights:

1. Total sales by country with color saturation as a visual encoding.
2. Total number of orders per product category with color hue as a visual encoding.
3. Quantity ordered by each customer in each quarter cycle.


