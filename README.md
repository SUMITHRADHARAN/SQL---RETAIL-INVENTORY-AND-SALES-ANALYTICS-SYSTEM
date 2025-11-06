# SQL- RETAIL INVENTORY AND SALES ANALYTICS SYSTEM
This SQL system centralizes fragmented retail data to automate inventory &amp; sales analytics. It transforms manual processes into real-time, actionable insights for data-driven decisions. The goal: optimize stock levels, prevent stockouts, &amp; improve demand forecasting, boosting profitability &amp; customer satisfaction.

Table of Contents:
Project Overview
System Architecture
Key Features
Prerequisites
Installation & Setup
Database Schema
Usage & Analytics
Conclusion

Project Overview:
This system addresses inefficient manual processes and fragmented data across retail operations by centralizing all inventory and sales data into a robust SQL-based database. The objective is to provide real-time, actionable insights for data-driven decisions, optimize stock levels, enhance profitability, and improve overall customer satisfaction. It moves beyond basic tracking to provide comprehensive analytics for demand forecasting and operational efficiency. 

System Architecture:
The system is designed around a relational database management system (RDBMS).
 * Database Backend: Primary SQL Database (e.g., PostgreSQL, MySQL, SQL Server) hosting normalized tables for sales, inventory, products, customers, stores, and suppliers.
 * Data Input: Automated imports or manual entry of transactional data.
 * Analytics Layer: SQL queries, stored procedures, and potentially connected business intelligence (BI) tools (e.g., Power BI, Tableau) used to generate reports and dashboards.

Key Features:
1. Centralized Data Repository: A single source of truth for all retail operations data.
2. Real-Time Inventory Tracking: Accurate stock level monitoring to prevent stockouts and overstocking.
3. Sales Performance Analytics: Detailed breakdown of sales by product, category, store, and time period.
4. Demand Forecasting Support: Data available for use in predictive modeling.
5. Automated Reporting: SQL scripts and views for consistent data extraction.
6. Vendor Performance Tracking: Monitoring supplier delivery times and product quality.

Prerequisites:
An installed RDBMS (e.g., MySQL, PostgreSQL, or SQL Server).
A SQL client/management tool (e.g., DBeaver, SSMS, pgAdmin) for running scripts.
Basic knowledge of SQL commands. 

Installation & Setup:
1. Clone the Repository: Obtain the SQL scripts from the source repository.
2. Create Database: Use your SQL client to create a new database instance named Retail_Analytics_DB.

                CREATE DATABASE Retail_Analytics_DB;
                
3. Run Schema Script: Execute the schema.sql script to create all necessary tables, constraints, and relationships.
4. Load Seed Data: Run the seed_data.sql script to populate initial static data (e.g., product categories, initial inventory levels).
5. Configure Imports: Set up your ETL (Extract, Transform, Load) processes or data import routines to populate the Sales and Inventory_Transactions tables with ongoing operational data.

Database schema:
  Key tables within the database include: 
1. Customers
2. Categories
3. Suppliers
4. Products
5. Stores
6. Sales
7. Inventory

   The database schema includes the Customers table, which describes customer information and uses CustomerID as its key field, relating to the Sales table. The Categories table details product groupings using CategoryID as the key field, which links to the Products table. The Suppliers table manages vendor information with SupplierID as the key field, also relating to Products. The Products table serves as the master item list, utilizing ProductID as the key field to establish relationships with Categories, Suppliers, Inventory, and Sales. The Stores table tracks location details using StoreID as the key field, connecting to both Inventory and Sales tables. The Sales table records transaction line items, using SaleID as the key field and relating back to Products, Customers, and Stores. Finally, the Inventory table tracks stock levels with InventoryID as the key field, linking to the Products and Stores tables.

Usage & Analytics:
The core of the system's value is derived from running analytical queries. Common uses include:

Top Selling Products:
           SELECT P.ProductName, SUM(ST.Quantity) AS TotalSold FROM Sales_Transactions ST
           JOIN Products P ON ST.ProductID = P.ProductID
           GROUP BY P.ProductName
           ORDER BY TotalSold DESC;

Conclusion:
The implemented SQL Retail Inventory and Sales Analytics system successfully centralizes fragmented operational data into a unified, seven-table database structure. By integrating customer, supplier, product, store, sales, and inventory information, the system automates reporting and provides real-time, data-driven insights essential for optimizing stock levels, accurately forecasting demand, and identifying areas for process improvement. Ultimately, this system moves the organization from inefficient manual tracking to an analytical operational model, enhancing profitability and significantly improving overall customer satisfaction and loyalty.
Vendor Performance Tracking: Monitoring supplier delivery times and product quality. 
