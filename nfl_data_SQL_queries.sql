#1: What are the top 10 Home EPAs for a team for a single play in any season in the data?

SELECT 
YEAR(game_date) as season 
	,fullName AS 'Home Team Name'
	,ROUND(MAX(total_home_epa),2) AS 'Total Home EPA' 
FROM nfl_data.teams as tms 
JOIN nfl_data.plays as plys 
ON tms.abbr = plys.home_team 
GROUP BY game_id, YEAR(game_date), fullName 
ORDER BY MAX(total_home_epa) DESC
LIMIT 10;




#2: The 2002 Detroit Lions had the highest single play epa in the data. Who are all of the players and their positions on the team in the data?

SELECT plyrs.season
	,tms.fullName as team_name
	,plyrs.position
	,CONCAT(plyrs.firstName, ' ', plyrs.lastName) AS player_name
FROM teams tms
JOIN players plyrs
ON tms.teamId = plyrs.teamId
WHERE plyrs.season = 2002 and tms.fullName = 'Detroit Lions'
GROUP BY plyrs.season, tms.fullName, plyrs.position, player_name;



#3: What is the average home epa for each team by each year ordered by team and epa from the data we have?

SELECT 
	fullName AS 'Home Team Name'
    ,YEAR(game_date) as season
    ,ROUND(AVG(total_home_epa),2) AS 'Average Total Home EPA' 
FROM nfl_data.teams as tms 
JOIN nfl_data.plays as plys 
ON tms.abbr = plys.home_team 
GROUP BY YEAR(game_date), fullName
ORDER BY fullName ASC, AVG(total_home_epa) DESC;



#4: Show all plays that have a home team epa above the average home team epa for all plays

SELECT 
	play_id
	,game_id
    ,home_team
    ,total_home_epa
FROM nfl_data.plays plys
WHERE plys.total_home_epa > (
			SELECT AVG(plys1.total_home_epa)
            FROM nfl_data.plays plys1
	)
;




#5: Show only the play with the smallest total home epa.

SELECT 
	plys.home_team
    ,ROUND(plys.season,0)
    ,plys.yrdln
    ,plys.play_type
    ,plys.yards_gained
    ,plys.passer_player_name
    ,plys.receiver_player_name
    ,plys.total_home_epa
FROM nfl_data.plays AS plys
WHERE plys.total_home_epa = (
			SELECT MIN(plys1.total_home_epa)
            FROM nfl_data.plays plys1
	)
;



#6: Create a select statement that returns all of the players and their positions from the players table and identifies whether they have a penalty for the data we have

SELECT 
	displayName AS player_name  
	,plyrs.position 
    ,"This player has a penalty" AS 'penalty'
FROM nfl_data.players plyrs
JOIN nfl_data.plays plys
ON plyrs.gsisId = plys.penalty_player_id
GROUP BY plyrs.displayName, plyrs.position

UNION

SELECT 
	plyrs.displayName AS player_name 
	,plyrs.position 
    ,"This player has no penalty" AS 'penalty'
FROM nfl_data.players plyrs
LEFT OUTER JOIN nfl_data.plays plys
ON plyrs.gsisId = plys.penalty_player_id
GROUP BY plyrs.displayName, plyrs.position
;




#7: Create a running total by play, home team and year for home team epa that resets by year.

SELECT 
	home_team 
    ,ROUND(season, 0)
    ,game_date
    ,game_id
    ,play_id
    ,total_home_epa
    ,SUM(total_home_epa) OVER (PARTITION BY season ORDER BY home_team, season, game_date, game_id, play_id) AS running_total_epa
FROM plays
ORDER BY home_team, season, game_date, game_id, play_id
;



#8: Create a moving average by play, home team and year for home team epa that resets by year.

SELECT 
	home_team 
    ,ROUND(season, 0)
    ,game_date
    ,game_id
    ,play_id
    ,total_home_epa
    ,AVG(total_home_epa) OVER (PARTITION BY season ORDER BY home_team, season, game_date, game_id, play_id ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_average_epa
FROM plays
ORDER BY home_team, season, game_date, game_id, play_id
;



#9: Pivot the data and return the sum of total home epa by year with home teams in the NFC EAST Division (NYG, WAS, PHI, DAL) listed as columns


SELECT 
	YEAR(plays.game_date) as Season,
    SUM(CASE
		WHEN plays.home_team = 'NYG' THEN plays.total_home_epa ELSE 0 END
        ) AS NYG,
	SUM(CASE
		WHEN plays.home_team = 'WAS' THEN plays.total_home_epa ELSE 0 END
        ) AS WAS,
	SUM(CASE
		WHEN plays.home_team = 'PHI' THEN plays.total_home_epa ELSE 0 END
        ) AS PHI,
	SUM(CASE
		WHEN plays.home_team = 'DAL' THEN plays.total_home_epa ELSE 0 END
        ) AS DAL
FROM nfl_data.plays
GROUP BY YEAR(plays.game_date)
ORDER BY YEAR(plays.game_date)
;




#10: Return the play with the third highest total_home_epa available in the data.alter

SELECT 
	plays.play_id,
    plays.game_id,
    plays.home_team,
    plays.away_team,
    plays.game_date,
    plays.total_home_epa
FROM nfl_data.plays
ORDER BY plays.total_home_epa DESC
limit 1
OFFSET 2
;