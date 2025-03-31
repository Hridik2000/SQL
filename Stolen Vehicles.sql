#the data set is about stolen vehicles in new zealand 
#checking the tables
SELECT * FROM stolen_vehicles;
SELECT * FROM make_details;
SELECT * FROM locations;

#checking for duplicates
SELECT vehicle_id, vehicle_type, make_id, vehicle_desc,color,date_stolen,location_id,COUNT(*) as no_of_duplicates
FROM stolen_vehicles
GROUP BY vehicle_id, vehicle_type, make_id, vehicle_desc,color,date_stolen,location_id
HAVING no_of_duplicates >1;

SELECT make_id,make_name, make_type,COUNT(*) as no_of_duplicates
FROM make_details
GROUP BY make_id,make_name,make_type
HAVING no_of_duplicates>1;

SELECT location_id,region, country,population, density, COUNT(*) as no_of_duplicates
FROM locations
GROUP BY location_id,region, country,population, density
HAVING no_of_duplicates>1;

#checking for null values
SELECT COUNT(vehicle_type),vehicle_type
FROM stolen_vehicles
GROUP BY vehicle_type;

SELECT *
FROM stolen_vehicles
WHERE vehicle_type = "";

#deleting the null values from the table
DELETE FROM stolen_vehicles 
WHERE vehicle_type = "";

#we will be doing most of the joins with the soteln vehicles table
#Joins
#checking the how much a particular type of vehicle was stolen
SELECT make_type,COUNT(make_type) as times_stolen
FROM stolen_vehicles sv
JOIN make_details md on sv.make_id = md.make_id
GROUP BY make_type;
#Standard vehicles were stolen more compared to luxury vehicles

#chekcing the top 10 types of vehicles which were stolen based on make type= standard
SELECT vehicle_type,COUNT(vehicle_type) as times_stolen, make_type
FROM stolen_vehicles sv
JOIN make_details md ON sv.make_id = md.make_id
WHERE make_type = "Standard"
GROUP BY vehicle_type,make_type
ORDER BY times_stolen DESC
LIMIT 10;

#chekcing the top 10 types of vehicles which were stolen based on make type= luxury
SELECT vehicle_type,COUNT(vehicle_type) as times_stolen, make_type
FROM stolen_vehicles sv
JOIN make_details md ON sv.make_id = md.make_id
WHERE make_type = "Luxury"
GROUP BY vehicle_type,make_type
ORDER BY times_stolen DESC
LIMIT 10;

#Checking the bottom 10 vehicle_type which were stolen based on make type=standard
SELECT vehicle_type,COUNT(vehicle_type) as times_stolen, make_type
FROM stolen_vehicles sv
JOIN make_details md ON sv.make_id = md.make_id 
WHERE make_type = "Standard"
GROUP BY vehicle_type,make_type
ORDER BY times_stolen ASC
LIMIT 10; 

#Checking the bottom 10 vehicle_type which were stolen based on make type=luxury
SELECT vehicle_type,COUNT(vehicle_type) as times_stolen, make_type
FROM stolen_vehicles sv
JOIN make_details md ON sv.make_id = md.make_id 
WHERE make_type = "Luxury"
GROUP BY vehicle_type,make_type
ORDER BY times_stolen ASC
LIMIT 10; 

#checking theft based on regions and vehicle type and make type standard of new zealand
SELECT region,vehicle_type,make_type,COUNT(vehicle_type) as times_stolen
FROM stolen_vehicles sv
JOIN locations l on sv.location_id = l.location_id
JOIN make_details md ON sv.make_id = md.make_id 
WHERE make_type = "standard"
GROUP BY region,vehicle_type,make_type
ORDER BY times_stolen DESC;

#checking theft based on regions and vehicle type and make type luxury of new zealand
SELECT region,vehicle_type,make_type,COUNT(vehicle_type) as times_stolen
FROM stolen_vehicles sv
JOIN locations l on sv.location_id = l.location_id
JOIN make_details md ON sv.make_id = md.make_id 
WHERE make_type = "luxury"
GROUP BY region,vehicle_type,make_type
ORDER BY times_stolen DESC;

#To see which type of vehicle were stolen the most on which day according to region.
SELECT vehicle_type,region,dayname(str_to_date(date_stolen, '%m/%d/%Y')) AS day_name
FROM stolen_vehicles sv
JOIN locations l on sv.location_id = l.location_id;

#To see which day has the most stolen cases.
SELECT dayname(str_to_date(date_stolen, '%m/%d/%Y')) as Day,COUNT(dayname(str_to_date(date_stolen, '%m/%d/%Y'))) as count_of_theft_occuring
FROM stolen_vehicles
GROUP BY Day
ORDER BY count_of_theft_occuring DESC;

#Checking the thefts based on the region and density and ranking it.
SELECT vehicle_type, density,region, COUNT(*) as times_theft_occured,DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS theft_occurrence_rank
FROM stolen_vehicles sv
JOIN locations l on sv.location_id = l.location_id
GROUP BY vehicle_type, density,region
ORDER BY times_theft_occured DESC;
#we can see that high density doesn't really mean having high theft as there are some regions which have lower
#density but higher theft rate.alter

