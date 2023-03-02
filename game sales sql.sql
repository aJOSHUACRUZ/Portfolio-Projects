/*
Data exploration of game sales data 
*/



SELECT *
FROM game_sales_data;


-- Ten best-selling video games

SELECT *
FROM game_sales_data
ORDER BY games_sold DESC
LIMIT 10;


-- games that are missing a user_score and a critic_score


SELECT COUNT(*)
FROM game_sales_data AS g
LEFT JOIN reviews AS r
ON g.game = r.game
WHERE Critic_Score IS NULL
AND User_Score IS NULL;


-- Years with the highest average critic_score

SELECT year,
		AVG(Critic_Score) AS avg_critic_score
FROM game_sales_data AS g
LEFT JOIN review AS r
ON g.game = r.game
GROUP BY year
ORDER BY avg_critic_score DESC;


-- Years with the highest critic scores and the number of games in each year

SELECT year,
		AVG(Critic_score) AS avg_critic_score,
        COUNT(*) AS num_games
FROM game_sales_data AS g
INNER JOIN reviews AS r
GROUP BY year
HAVING COUNT(g.game) > 4
ORDER BY avg_critic_score DESC
LIMIT 10;


-- Popular years of video games


SELECT g.year,
		COUNT(g.game) AS number_games,
        AVG(r.User_Score) AS avg_user_score
FROM game_sales_data AS g
INNER JOIN reviews AS r
ON g.game = r.game
GROUP BY g.year
HAVING COUNT(g.game) > 4
ORDER BY avg_user_score DESC

        
