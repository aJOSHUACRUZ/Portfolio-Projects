/* 
Exploration of tripdata Dataset
Dataset has been cleaned using Microsoft Excel
Rows with null values which are deemed unusable have been removed
date and time columns are formatted to the proper format 

*/



SELECT * FROM tripdata;


-- Count of all rows

SELECT COUNT(*)
FROM tripdata;


-- Total member vs Total casual 
SELECT COUNT(*),
	   member_casual
FROM tripdata
GROUP BY member_casual;

-- Count of trips started in each station name

SELECT start_station_name,
       COUNT(*) AS 'Count of trips'
FROM tripdata
GROUP BY start_station_name
ORDER BY COUNT(*) DESC;

-- Count of trips ended in each station name 
SELECT end_station_name,
       COUNT(*) AS 'Count of trips'
FROM tripdata
GROUP BY end_station_name
ORDER BY COUNT(*) DESC;


-- Count of trips by different ride types
SELECT rideable_type,
	   COUNT(*) AS 'Count of trips'
FROM tripdata
GROUP BY rideable_type
ORDER BY COUNT;

-- Show stations where only docked bikes and member type users have used 
SELECT start_station_name
FROM tripdata
WHERE rideable_type = "docked_bike" AND member_casual = "member";

-- Show ride id's which used the bikes for atleast 1 day

SELECT ride_id
FROM tripdata
WHERE ride_id IN 
(SELECT ride_id
FROM tripdata
WHERE DATEDIFF(end_date, start_date) > 0 
AND member_casual = 'casual'); 


-- Find the count of users for each day 

SELECT start_date,
	   COUNT(*),
       RANK() OVER (partition by start_date
					ORDER BY COUNT(*) DESC) AS ranking
FROM tripdata
GROUP BY start_date;



