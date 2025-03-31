--Checking Domestic Consumption Table
SELECT *
FROM dbo.Coffee_domestic_consumption;

--Looking for NULL values 
SELECT *
FROM Coffee_domestic_consumption
WHERE [Coffee Type] is NULL;

--The different types of coffee
SELECT DISTINCT([Coffee Type])
FROM dbo.Coffee_domestic_consumption;

--Counting the which coffee type is being consumed the most
SELECT COUNT([Coffee Type]) AS [Count of Countries which Consume Arabica]
FROM dbo.Coffee_domestic_consumption
WHERE [Coffee Type] = 'Arabica';

SELECT COUNT([Coffee Type]) AS [Count of Countries which Consume Arabica/Robusta]
FROM dbo.Coffee_domestic_consumption
WHERE [Coffee Type] = 'Arabica/Robusta';

SELECT COUNT([Coffee Type]) AS [Count of Countries which Consume Robusta]
FROM dbo.Coffee_domestic_consumption
WHERE [Coffee Type] = 'Robusta';

SELECT COUNT([Coffee Type]) AS [Count of Countries which Consume Robusta/Arabica]
FROM dbo.Coffee_domestic_consumption
WHERE [Coffee Type] = 'Robusta/Arabica';

--Checking which country consumes which type of coffee
SELECT Country, [Coffee Type], [Total Domestic Consumption]
FROM dbo.Coffee_domestic_consumption
WHERE [Coffee Type] = 'Arabica';

SELECT Country, [Coffee Type], [Total Domestic Consumption]
FROM dbo.Coffee_domestic_consumption
WHERE [Coffee Type] = 'Robusta';

SELECT Country, [Coffee Type], [Total Domestic Consumption]
FROM dbo.Coffee_domestic_consumption
WHERE [Coffee Type] = 'Arabica/Robusta';

SELECT Country, [Coffee Type], [Total Domestic Consumption]
FROM dbo.Coffee_domestic_consumption
WHERE [Coffee Type] = 'Robusta/Arabica';

--Selecting Country and Total Domestic Consumption
SELECT Country, [Total Domestic Consumption]
FROM dbo.Coffee_domestic_consumption
WHERE [Total Domestic Consumption] <> 0
ORDER BY[Total Domestic Consumption];

--Checking the Coffee Export Table
SELECT *
FROM Coffee_export;

--Checking for any Null Values
SELECT * 
FROM Coffee_export
WHERE Country is NULL;

--Selecting Country and Total Export 
SELECT Country, [Total Export ]
FROM Coffee_export
WHERE [Total Export ] <> 0
ORDER BY [Total Export ]; 

--Checking the Coffee Import Table
SELECT *
FROM Coffee_import;

--Checking for NULL Values
SELECT *
FROM Coffee_import
WHERE Country is NULL;

--Selecting Country and Total Export
SELECT Country,[Total Import]
FROM Coffee_Import
WHERE [Total Import] <> 0
ORDER BY [Total Import];

--Checking the Coffee Importers Consumption
SELECT *
FROM Coffee_importers_consumption;

--Checking the Number of Countries
SELECT COUNT(Country)
FROM Coffee_importers_consumption;

--Selecting Country and Total Import Consumption
SELECT Country,[Total Import Consumption]
FROM Coffee_importers_consumption
WHERE [Total Import Consumption] <> 0
ORDER BY [Total Import Consumption];

--Checking Coffee Inventories Table
SELECT *
FROM [Coffee_inventories];

--Checking for NULL Values
SELECT * 
FROM [Coffee_inventories]
WHERE Country is NULL;

--Selecting Country and Total Inventory
SELECT Country, [Total Inventory]
FROM Coffee_inventories
WHERE [Total Inventory] <> 0
ORDER BY [Total Inventory];

--Checking the Coffee Production Table
SELECT *
FROM Coffee_production;

--Production based on different type of coffee
SELECT Country,[Coffe Type],[Total Production] 
FROM Coffee_production
WHERE [Coffe Type] = 'Arabica';

SELECT Country,[Coffe Type],[Total Production] 
FROM dbo.Coffee_production
WHERE [Coffe Type] = 'Arabica/Robusta';

SELECT Country,[Coffe Type],[Total Production] 
FROM dbo.Coffee_production
WHERE [Coffe Type] = 'Robusta';

SELECT Country,[Coffe Type],[Total Production]
FROM dbo.Coffee_production
WHERE [Coffe Type] = 'Robusta/Arabica';

--Selecting Country and Total Production
SELECT Country,[Total Production]
FROM Coffee_production
WHERE [Total Production] <> 0
ORDER BY [Total Production];

--Joining to get Country, Coffee Type,Total Domestic Consumption and Total Export
SELECT Coffee_domestic_consumption.Country, [Coffee Type],[Total Domestic Consumption],[Total Export ]
FROM Coffee_domestic_consumption
FULL Outer Join Coffee_export
ON Coffee_domestic_consumption.Country = Coffee_export.Country;

--Joining to get Country, Coffee Type,Total Domestic Consumption and Total Production
SELECT Coffee_domestic_consumption.Country, [Coffee Type],[Total Domestic Consumption],[Total Production ]
FROM Coffee_domestic_consumption
FULL Outer Join Coffee_production
ON Coffee_domestic_consumption.Country = Coffee_production.Country;

--Joining Total Import Consumption and Total Import
SELECT Coffee_import.Country,[Total Import Consumption],[Total Import ]
FROM Coffee_import
FULL Outer Join Coffee_importers_consumption
ON Coffee_import.Country = Coffee_importers_consumption.Country;

--Joining Country, Total Export and Total Production
SELECT Coffee_production.Country,[Total Export],[Total Production ]
FROM Coffee_export
FULL Outer Join Coffee_production
ON Coffee_export.Country = Coffee_production.Country;










