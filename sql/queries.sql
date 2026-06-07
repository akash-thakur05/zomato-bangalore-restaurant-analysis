-- =============================================
-- ZOMATO BANGALORE RESTAURANT ANALYSIS
-- SQL Queries File
-- =============================================


-- Q1: How many restaurants are in each location?
SELECT location,
       COUNT(*) AS total_restaurants
FROM restaurants
GROUP BY location
ORDER BY total_restaurants DESC
LIMIT 10;


-- Q2: Which cuisine has the highest average rating?
SELECT cuisines,
       ROUND(AVG(rate), 2) AS avg_rating,
       COUNT(*) AS total
FROM restaurants
WHERE cuisines IS NOT NULL
GROUP BY cuisines
HAVING total >= 100
ORDER BY avg_rating DESC
LIMIT 10;


-- Q3: Average cost and rating by restaurant type?
SELECT rest_type,
       ROUND(AVG(cost_for_two), 0) AS avg_cost,
       ROUND(AVG(rate), 2) AS avg_rating,
       COUNT(*) AS total
FROM restaurants
WHERE rest_type IS NOT NULL
GROUP BY rest_type
HAVING total >= 200
ORDER BY avg_cost DESC
LIMIT 10;


-- Q4: Do online-order restaurants rate higher than dine-in only?
SELECT online_order,
       ROUND(AVG(rate), 2) AS avg_rating,
       ROUND(AVG(cost_for_two), 0) AS avg_cost,
       COUNT(*) AS total_restaurants
FROM restaurants
GROUP BY online_order;


-- Q5: Top 10 most voted restaurants in popular locations?
SELECT name, location, votes, rate
FROM restaurants
WHERE location IN ('Koramangala 5th Block', 'Indiranagar', 'BTM')
ORDER BY votes DESC
LIMIT 10;


-- Q6: Rank all locations by average rating (min 100 restaurants)
SELECT location,
       ROUND(AVG(rate), 2) AS avg_rating,
       COUNT(*) AS total,
       RANK() OVER (ORDER BY AVG(rate) DESC) AS rank_num
FROM restaurants
GROUP BY location
HAVING total >= 100
ORDER BY rank_num
LIMIT 10;


-- Q7: Budget gems — high rating, low cost, well reviewed
SELECT name, location, cuisines,
       rate, cost_for_two, votes
FROM restaurants
WHERE rate >= 4.2
  AND cost_for_two <= 300
  AND votes >= 500
ORDER BY rate DESC, votes DESC
LIMIT 10;


-- Q8: Does having table booking affect rating and cost?
SELECT book_table,
       ROUND(AVG(rate), 2) AS avg_rating,
       ROUND(AVG(cost_for_two), 0) AS avg_cost,
       ROUND(AVG(votes), 0) AS avg_votes,
       COUNT(*) AS total
FROM restaurants
GROUP BY book_table;