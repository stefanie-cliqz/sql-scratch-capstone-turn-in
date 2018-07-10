code.sql


-- Question 1

SELECT *
FROM survey
LIMIT 10;


-- Question 2

SELECT question, COUNT (DISTINCT user_id) AS 'users_count'
FROM survey
GROUP BY question;

-- Question 3
-- see Excel sheet

-- Question 4

SELECT *
FROM quiz
LIMIT 5;

SELECT *
FROM home_try_on
LIMIT 5;

SELECT *
FROM purchase
LIMIT 5;

-- Question 5

SELECT DISTINCT q.user_id, h.user_id IS NOT NULL AS 'is_home_try_on', h.number_of_pairs, p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz AS 'q'
LEFT JOIN home_try_on AS 'h'
ON q.user_id = h.user_id
Left JOIN purchase AS 'p'
ON h.user_id = p.user_id
LIMIT 10;

-- Question 6 - 1

WITH funnels AS (
	SELECT DISTINCT q.user_id, 
	  h.user_id IS NOT NULL AS 'is_home_try_on', 
	  h.number_of_pairs, 
	  p.user_id IS NOT NULL AS 'is_purchase'
	FROM quiz AS 'q'
	LEFT JOIN home_try_on AS 'h'
	ON q.user_id = h.user_id
	Left JOIN purchase AS 'p'
	ON h.user_id = p.user_id)
SELECT COUNT(*) AS 'num_quiz_users', 
	SUM(is_home_try_on) AS 'num_home_try_out_users', 
	SUM(is_purchase) AS 'num_purchase_users', 
	ROUND (1.0 * SUM(is_home_try_on) / COUNT(user_id), 2) AS 'quiz_to_try_on', ROUND(1.0 * SUM(is_purchase) / SUM(is_home_try_on), 2) AS 'try_on_to_purchase'
FROM funnels; 


-- Question 6 - 2

WITH funnels AS (
	SELECT DISTINCT q.user_id, 
	  h.user_id IS NOT NULL AS 'is_home_try_on', 
	  h.number_of_pairs, 
	  p.user_id IS NOT NULL AS 'is_purchase'
	FROM quiz AS 'q'
	LEFT JOIN home_try_on AS 'h'
	  ON q.user_id = h.user_id
	Left JOIN purchase AS 'p'
	  ON h.user_id = p.user_id)
SELECT number_of_pairs, COUNT(*) AS 'num_quiz_users', 
	SUM(is_home_try_on) AS 'num_home_try_out_users', 
	SUM(is_purchase) AS 'num_purchase_users', 
	ROUND(1.0 * SUM(is_purchase) / SUM(is_home_try_on), 2) AS 'try_on_to_purchase'
FROM funnels
GROUP BY 1; 

-- Question 6 - 3

SELECT style, COUNT(user_id)
FROM quiz
GROUP BY style;

SELECT model_name,
  COUNT(user_id)
FROM purchase
GROUP BY 1
ORDER BY 2 DESC;

SELECT model_name, price,
  COUNT(user_id)
FROM purchase
GROUP BY 1
ORDER BY 2 DESC;









