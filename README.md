# BikeStoreExtensions
This repo has several scripts to extend the Bikestore examples and bring it in line with 2023

The original Source of the BikeStores Sample Database can be found here:
Sources can be downloaded from   https://www.sqlservertutorial.net/sql-server-sample-database/
database Schema: https://www.sqlservertutorial.net/wp-content/uploads/SQL-Server-Sample-Database.png

It is a nice test database, but it lacks some of the key things:
- Updated data
- Key Field usage
- Build for the US Only
- 

For my project I have added bikes and products for 2020 to 2023. Also a File for 2024 is added.

What I want to setup is a script that uses the api's to get fired to add customers, orders etc. Based on the random customers from the list.
Another thing is to track if there are bikes on stock or not.

An PBIX file would be nice so that we can see the sales per shop and the stock per shop

# How to install
1) [Create Database Objects](<BikeStores Sample Database - create objects.sql>)
2) [Update Schema for Global Use](<BikeStores - GlobalSchema.sql>)
3) [Create Stored Procedures](<BikeStores - StoredProcedures.sql>)
4) [Create View](<Bikestores - View.sql>)
5) [Create Stored Proc SalesData](<BikeStores - csp_SalesData.sql>)
6) [Original Data](<BikeStores Sample Database - load data.sql>)
7) [Add data for 2020-2023](BikeStores_2020-2023.SQL)
8) [2024]