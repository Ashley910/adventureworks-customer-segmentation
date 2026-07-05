# AdventureWorks Customer Segmentation  
SQL project analyzing customer lifetime value, segmentation, and territory performance using AdventureWorks.

## Overview  
This project focuses on exploring, validating, and analyzing customer data from the AdventureWorks database. It demonstrates a complete analyst workflow using SQL: data exploration, data quality checks, customer profiling, lifetime value calculation, segmentation, and territory analysis.

## Dataset  
Tables used in this project:  
- Sales.Customer  
- Person.Person  
- Sales.SalesOrderHeader  
- Sales.SalesOrderDetail  
- Sales.SalesTerritory  

These tables contain customer information, personal details, order history, and territory metadata.

## Project Steps  
**1. Explore customer tables**  
Preview the first 50 rows of Customer, Person, SalesOrderHeader, and SalesOrderDetail.

**2. Validate customer data**  
Check for missing PersonIDs, missing TerritoryIDs, and duplicate customers.

**3. Build customer profile view**  
Join Customer, Person, and Territory tables to create a unified customer profile.

**4. Calculate customer lifetime value (CLV)**  
Compute total revenue, total orders, and average order value per customer.

**5. Segment customers**  
Label customers as High-Value, Medium-Value, or Low-Value based on lifetime revenue.

**6. Analyze customer behavior over time**  
Calculate orders per year and revenue per year for each customer.

**7. Identify top customer territories**  
Rank territories by customer count and total revenue.

**8. Summary insights**  
Generate top customers and segment distribution using SQL outputs.

## Key Insights  
- High-value customers generate a large portion of total revenue.  
- Customer segments reveal clear differences in purchasing behavior.  
- Certain territories contain higher concentrations of valuable customers.  
- Year-over-year behavior helps identify retention and growth patterns.

## How to Run  
1. Install SQL Server and SSMS.  
2. Restore the AdventureWorks sample database.  
3. Open the `customer_segmentation_queries.sql` file.  
4. Run each step sequentially in SSMS.

## Purpose  
This project demonstrates SQL skills relevant to entry-level and junior data analyst roles, including customer analytics, segmentation, lifetime value calculation, and territory performance analysis.
