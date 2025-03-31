-- Creating a Main table Medicine to insert the Other Tables 
CREATE Table Medicine(Medication_Name NVARCHAR(100),
	Package_Size float,
	Max_Retailer_Price float,
	Max_Consumer_Price float,
	Max_Consumer_VAT_Price float,
	Year smallint);

--Inserting Tables Sales2007 - Sales 2015 	
INSERT INTO Medicine(Medication_Name,Package_Size,Max_Retailer_Price,Max_Consumer_Price,Max_Consumer_VAT_Price,Year)
SELECT Medication_Name,Package_Size,Max_Retailer_Price,Max_Consumer_Price,Max_Consumer_VAT_Price,2007 AS Year
FROM Sales2007;

INSERT INTO Medicine(Medication_Name,Package_Size,Max_Retailer_Price,Max_Consumer_Price,Max_Consumer_VAT_Price,Year)
SELECT Medication_Name,Package_Size,Max_Retailer_Price,Max_Consumer_Price,Max_Consumer_VAT_Price,2008 AS Year
FROM Sales2008;

INSERT INTO Medicine(Medication_Name,Package_Size,Max_Retailer_Price,Max_Consumer_Price,Max_Consumer_VAT_Price,Year)
SELECT Medication_Name,Package_Size,Max_Retailer_Price,Max_Consumer_Price,Max_Consumer_VAT_Price,2009 AS Year
FROM Sales2009;


INSERT INTO Medicine(Medication_Name,Package_Size,Max_Retailer_Price,Max_Consumer_Price,Max_Consumer_VAT_Price,Year)
SELECT Medication_Name,Package_Size,Max_Retailer_Price,Max_Consumer_Price,Max_Consumer_VAT_Price,2010 AS Year
FROM Sales2010;


INSERT INTO Medicine(Medication_Name,Package_Size,Max_Retailer_Price,Max_Consumer_Price,Max_Consumer_VAT_Price,Year)
SELECT Medication_Name,Package_Size,Max_Retailer_Price,Max_Consumer_Price,Max_Consumer_VAT_Price,2011 AS Year
FROM Sales2011;


INSERT INTO Medicine(Medication_Name,Package_Size,Max_Retailer_Price,Max_Consumer_Price,Max_Consumer_VAT_Price,Year)
SELECT Medication_Name,Package_Size,Max_Retailer_Price,Max_Consumer_Price,Max_Consumer_VAT_Price,2012 AS Year
FROM Sales2012;


INSERT INTO Medicine(Medication_Name,Package_Size,Max_Retailer_Price,Max_Consumer_Price,Max_Consumer_VAT_Price,Year)
SELECT Medication_Name,Package_Size,Max_Retailer_Price,Max_Consumer_Price,Max_Consumer_VAT_Price,2013 AS Year
FROM Sales2013;


INSERT INTO Medicine(Medication_Name,Package_Size,Max_Retailer_Price,Max_Consumer_Price,Max_Consumer_VAT_Price,Year)
SELECT Medication_Name,Package_Size,Max_Retailer_Price,Max_Consumer_Price,Max_Consumer_VAT_Price,2014 AS Year
FROM Sales2014;


INSERT INTO Medicine(Medication_Name,Package_Size,Max_Retailer_Price,Max_Consumer_Price,Max_Consumer_VAT_Price,Year)
SELECT Medication_Name,Package_Size,Max_Retailer_Price,Max_Consumer_Price,Max_Consumer_VAT_Price,2015 AS Year
FROM Sales2015;

--Highest Retail, Consumer Price and Consumer VAT Price based on Year
SELECT Year,Medication_Name,Package_Size, Max_Retailer_Price AS Highest_Retail_Price, 
	Max_Consumer_Price AS Highest_Consumer_Price,
	Max_Consumer_VAT_Price AS Highest_VAT_Price
FROM Medicine m1
WHERE Year IN (2007, 2008,2009,2010,2011,2012,2013,2014,2015)
  AND Max_Retailer_Price = (SELECT MAX(Max_Retailer_Price) FROM Medicine m2 WHERE m2.Year = m1.Year)
  AND Max_Consumer_Price = (SELECT MAX(Max_Consumer_Price) FROM Medicine m3 WHERE m3.Year = m1.Year)
  AND Max_Consumer_VAT_Price = (SELECT MAX(Max_Consumer_VAT_Price) FROM Medicine m3 WHERE m3.Year = m1.Year);

--Lowest Retail and Consumer Price based on Year
SELECT Year,Medication_Name,Package_Size, Max_Retailer_Price AS Lowest_Retail_Price,
	Max_Consumer_Price AS Lowest_Consumer_Price, 
	Max_Consumer_VAT_Price AS Lowest_VAT_Price
FROM Medicine m1
WHERE Year IN (2007, 2008,2009,2010,2011,2012,2013,2014,2015)
  AND Max_Retailer_Price = (SELECT MIN(Max_Retailer_Price) FROM Medicine m2 WHERE m2.Year = m1.Year)
  AND Max_Consumer_Price = (SELECT MIN(Max_Consumer_Price) FROM Medicine m3 WHERE m3.Year = m1.Year)
  AND Max_Consumer_VAT_Price = (SELECT MIN(Max_Consumer_VAT_Price) FROM Medicine m3 WHERE m3.Year = m1.Year);

--Average Price of the Medicine in different Years
SELECT Year, AVG(Max_Retailer_Price) AS Average_Retail_Price, 
	AVG(Max_Consumer_Price) AS Average_Consumer_Price, 
	AVG(Max_Consumer_VAT_Price) AS Average_Consumer_VAT_Price
FROM Medicine
WHERE Year IN (2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015)
GROUP BY Year
ORDER BY Year;

--Minimum and Maximum Prices of the medicines based on package size along with the count for the package size and Year 
SELECT Year, Package_Size, COUNT(*) AS Count,
    COALESCE(CAST(Max(Max_Retailer_Price) AS VARCHAR(10)), 'N/A') AS Max_Retailer_Price,
    COALESCE(CAST(Min(Max_Retailer_Price) AS VARCHAR(10)), 'N/A') AS Min_Retailer_Price,
    COALESCE(CAST(Max(Max_Consumer_Price) AS VARCHAR(10)), 'N/A') AS Max_Consumer_Price,
    COALESCE(CAST(Min(Max_Consumer_Price) AS VARCHAR(10)), 'N/A') AS Min_Consumer_Price,
    COALESCE(CAST(Max(Max_Consumer_VAT_Price) AS VARCHAR(10)), 'N/A') AS Max_Consumer_VAT_Price,
    COALESCE(CAST(Min(Max_Consumer_VAT_Price) AS VARCHAR(10)), 'N/A') AS Min_Consumer_VAT_Price
FROM Medicine
GROUP BY Year, Package_Size
ORDER BY Year ASC, Package_Size ASC;

--Percentage change in Price for the medicines for each year
SELECT
  m1.Year,
  m1.Medication_Name,
  m1.Max_Retailer_Price AS Current_Price,
  m2.Max_Retailer_Price AS Previous_Price,
  ((m1.Max_Retailer_Price - m2.Max_Retailer_Price) / m2.Max_Retailer_Price) * 100 AS Percent_Change
FROM
  Medicine m1
JOIN
  Medicine m2 ON m1.Medication_Name = m2.Medication_Name AND m1.Year = m2.Year + 1
WHERE m1.Max_Retailer_Price is NOT NULL
ORDER BY
  m1.Year, m1.Medication_Name;


