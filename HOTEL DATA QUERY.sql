-- Joining all years(different tables) together using UNION syntax
SELECT * FROM dbo.[2018]
UNION
SELECT * FROM dbo.[2019]
UNION
SELECT * FROM dbo.[2020];

-- Making the above joined tables a temporary table named 'hotels'
WITH hotels AS (
SELECT * FROM dbo.[2018]
UNION
SELECT * FROM dbo.[2019]
UNION
SELECT * FROM dbo.[2020])
SELECT * FROM  hotels;

-- Is the hotel revenue growing by year?
-- since we do not have a revenue column, we create ours.
/* looking through the description of the data set, adr = daily rate. We would multiply daily rate 
by the number of stay ins(week+weekends) as REVENUE */
WITH hotels AS (
SELECT * FROM dbo.[2018]
UNION
SELECT * FROM dbo.[2019]
UNION
SELECT * FROM dbo.[2020])

SELECT (stays_in_weekend_nights+stays_in_week_nights)* adr AS revenue FROM hotels;

-- to find out the total revenue per year, we use the SUM & GROUPBY syntax
WITH hotels AS (
SELECT * FROM dbo.[2018]
UNION
SELECT * FROM dbo.[2019]
UNION
SELECT * FROM dbo.[2020])

SELECT arrival_date_year,
SUM((stays_in_weekend_nights+stays_in_week_nights)* adr) AS revenue 
FROM hotels
GROUP BY arrival_date_year;

-- there are two hotel types- to segment the revenue by hotel type and round REVENUE to 2 d.p:
WITH hotels AS (
SELECT * FROM dbo.[2018]
UNION
SELECT * FROM dbo.[2019]
UNION
SELECT * FROM dbo.[2020])

SELECT arrival_date_year,
hotel,
ROUND(SUM((stays_in_weekend_nights+stays_in_week_nights)* adr), 2) AS revenue 
FROM hotels
GROUP BY arrival_date_year, hotel;
/* Recall that we have 2 more tables in our database- market_segment & meal_cost- 
we will merge both with temporary table - hotels*/
WITH hotels AS(
SELECT * FROM dbo.[2018]
UNION
SELECT * FROM dbo.[2019]
UNION
SELECT * FROM dbo.[2020])

SELECT * FROM hotels
LEFT JOIN dbo.market_segment
ON hotels.market_segment = dbo.market_segment.market_segment
LEFT JOIN dbo.meal_cost
ON   hotels.meal = dbo.meal_cost.meal;


