**SQL Query Example for NFL play-by-play data By Michael O'Shea**


The purpose of this portfolio is to build a database, execute queries and showcase SQL Knowledge. For this project I used MySQL Workbench which is a visual database design tool that MySQL develops.
It is a great tool for project like this, because it is free and extremely user friendly. For more information on MySQL workbench you can visit this website (https://www.mysql.com/products/workbench/).
The data used in this project was sourced from dolthub.com (https://www.dolthub.com/repositories/Liquidata/nfl-play-by-play), however, it was originally sourced from github.com (https://github.com/nflverse/nflverse-pbp).
There were a few challenges I encountered during this project, for example, every SQL Relationship Database Management System has slightly different rules and functions. In MySQL there is no PIVOT function which is a common function I have used in my work, so I had
to find work arounds or alternative methods of achieving the same result. Another issue I ran into is that this is really just a sample of the data rather than the full database. While all of the queries still execute and return results, it would be impossible to make any
significant conclusions from the data.


**_Using the software_**


The software can be downloaded from this website:

MySQL Workbench: https://dev.mysql.com/downloads/workbench/

After downloading the software, create a connection on the local server. Once the connection is established go to the schemas tab and right click to create a schema
called _nfl_data_. To create the individual tables in the schema, run this command (_use nfl_data;_) then run the create table statements. Once the tables are created the SQL script with all of the queries will work.



**_The Data_**

As mentioned above, this is more of a sample of the data than a complete dataset. There is not a record for every play in every year of the data. There is not every player for every team in the data. However, the goal of this project is not to come to specific conclusions but to showcase different 
functions and queries in SQL. 

Specific fields in the data:  

_total_home_epa_: EPA stands for Expected Points Added. In this case it is the expected points added for the home team on a specific play. EPA calculates the expected points scored based on the down, distance, and field position at the outset of the play compared to the end result. It is basically a stat that tells us how effective a team was on a certain play.

_position_: The position of the player on the team.

_yrdln_: The teams position on the field at the beginning of the play, in other words, the yard line.

_yards_gained_: The number of yards gained by the team on the play (negative or positive).

_play_type_: Whether the play was a pass or run.
