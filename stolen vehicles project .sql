-- Step 1: Explore the vehicle and date fields in the stolen_vehicles table to identify when vehicles tend to be stolen.

-- Query 1: Get the number of vehicles stolen each year.
SELECT
    YEAR(date_stolen) AS Year_Stolen,
    COUNT(vehicle_id) AS Vehicle_Count
FROM
    stolen_vehicles
GROUP BY
    YEAR(date_stolen);

-- Query 2: Get the number of vehicles stolen each month.
SELECT
    MONTH(date_stolen) AS Month_Stolen,
    COUNT(vehicle_id) AS Vehicle_Count
FROM
    stolen_vehicles
GROUP BY
    MONTH(date_stolen)
ORDER BY
    MONTH(date_stolen);

-- Query 3: Get the number of vehicles stolen each day of the week.
SELECT
    DAYOFWEEK(date_stolen) AS DayOfWeek_Num,
    CASE
        WHEN DAYOFWEEK(date_stolen) = 1 THEN 'Sunday'
        WHEN DAYOFWEEK(date_stolen) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(date_stolen) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(date_stolen) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(date_stolen) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(date_stolen) = 6 THEN 'Friday'
        ELSE 'Saturday'
    END AS DayOfWeek_Name,
    COUNT(vehicle_id) AS Vehicle_Count
FROM
    stolen_vehicles
GROUP BY
    DayOfWeek_Num, DayOfWeek_Name
ORDER BY
    DayOfWeek_Num;
--  bar chart that shows the number of vehicles stolen on each day of the week is in different file

-- Step 2: Explore the vehicle type, age, luxury vs standard, and color fields in the stolen_vehicles table
-- to identify which vehicles are most likely to be stolen.

-- Query 4: Get the number of vehicles stolen by vehicle type.
SELECT
    vehicle_type AS Vehicle_Type,
    COUNT(vehicle_id) AS Vehicle_Count
FROM
    stolen_vehicles
GROUP BY
    vehicle_type
ORDER BY
    Vehicle_Count DESC;

-- Query 5: Calculate the average age of vehicles stolen by vehicle type.
SELECT 
    vehicle_type AS Vehicle_Type,
    AVG(YEAR(date_stolen) - model_year) AS Avg_Age_Vehicle_By_Type
FROM
    stolen_vehicles
GROUP BY
    vehicle_type;

-- Query 6: Calculate the percentage of luxury vs standard vehicles stolen by vehicle type.
SELECT 
    vehicle_type AS Vehicle_Type,
    COUNT(vehicle_id) AS Vehicle_Count,
    COUNT(CASE WHEN make_type = 'Standard' THEN 1 ELSE NULL END) AS Num_Standard,
    COUNT(CASE WHEN make_type = 'Luxury' THEN 1 ELSE NULL END) AS Num_Luxury,
    (COUNT(CASE WHEN make_type = 'Standard' THEN 1 ELSE NULL END) * 100.0 / COUNT(vehicle_id)) AS Pct_Standard,
    (COUNT(CASE WHEN make_type = 'Luxury' THEN 1 ELSE NULL END) * 100.0 / COUNT(vehicle_id)) AS Pct_Luxury
FROM 
    make_details
INNER JOIN 
    stolen_vehicles ON make_details.make_id = stolen_vehicles.make_id
GROUP BY 
    vehicle_type;
--  Heat map of the table comparing the vehicle types and colors is in a different file

-- Step 3: Explore the population and density statistics in the regions table to identify where vehicles are getting stolen,
-- and visualize the results using a scatter plot and map.

-- Query 7: Get the number of vehicles stolen by region, along with population and density statistics.
SELECT 
    region AS Region,
    population AS Population,
    density AS Density,
    COUNT(vehicle_id) AS Num_Vehicles_Stolen
FROM 
    stolen_vehicles
LEFT JOIN 
    locations ON stolen_vehicles.location_id = locations.location_id 
GROUP BY 
    Region,
    Population,
    Density
ORDER BY 
    Num_Vehicles_Stolen DESC;
-- A map of the regions and color the regions based on the number of stolen vehicles is in a different file
