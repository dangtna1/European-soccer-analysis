use soccer;

-- ----------------------------------------------------------------------------------------

# Query attributes of a specific player
select *
from player_attributes
where player_api_id = 505942;

-- ----------------------------------------------------------------------------------------

# Inspect how many records and unique players
select count(*) as all_records, count(distinct(player_api_id)) as unique_players
from player_attributes;

select * from player;
select * from player_attributes order by player_api_id;

-- ----------------------------------------------------------------------------------------

# Inspect attributes of individual player by the latest date (using sub-query)
create view players_data as (
select 
	p.*,
	lpa.date,
	lpa.overall_rating,
	lpa.potential,
	lpa.preferred_foot,
	lpa.attacking_work_rate,
	lpa.defensive_work_rate,
	lpa.crossing,
	lpa.finishing,
	lpa.heading_accuracy,
	lpa.short_passing,
	lpa.volleys,
	lpa.dribbling,
	lpa.curve,
	lpa.free_kick_accuracy,
	lpa.long_passing,
	lpa.ball_control,
	lpa.acceleration,
	lpa.sprint_speed,
	lpa.agility,
	lpa.reactions,
	lpa.balance,
	lpa.shot_power,
	lpa.jumping,
	lpa.stamina,
	lpa.strength,
	lpa.long_shots,
	lpa.aggression,
	lpa.interceptions,
	lpa.positioning,
	lpa.vision,
	lpa.penalties,
	lpa.marking,
	lpa.standing_tackle,
	lpa.sliding_tackle,
	lpa.gk_diving,
	lpa.gk_handling,
	lpa.gk_kicking,
	lpa.gk_positioning,
	lpa.gk_reflexes
from player as p
inner join (
	select pa.*
	from player_attributes pa 
	inner join (
		select 
			player_api_id,
			max(date) as latest_date
		from player_attributes
		group by player_api_id
	) as latest_data
	on pa.player_api_id = latest_data.player_api_id 
	and pa.date = latest_data.latest_date 
) as lpa
on p.player_api_id = lpa.player_api_id
);
select * from players_data;

-- ----------------------------------------------------------------------------------------

# top 10 players in terms of different attributes (using procedure)
delimiter //

create procedure top10Players(in attribute varchar(50))
begin
	SET @query = CONCAT(
        'SELECT player_name, ', attribute, 
        ' FROM players_data',
        ' ORDER BY ', attribute, ' DESC',
        ' LIMIT 10;'
    );
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
end //

delimiter ;

call top10Players('potential');

-- ----------------------------------------------------------------------------------------

# Compare the average of attributes in respect to left or right foot
select 
	preferred_foot,
	round(avg(overall_rating)) as avg_overall_rating,
    round(avg(potential)) as avg_potentail,
    round(avg(crossing)) as avg_crossing,
    round(avg(finishing)) as avg_finishing,
    round(avg(free_kick_accuracy)) as avg_free_kick_accuracy,
    round(avg(ball_control)) as avg_ball_control,
    round(avg(shot_power)) as avg_shot_power
from players_data
group by preferred_foot;

-- ----------------------------------------------------------------------------------------

# Inspect attributes of individual team by the latest date (using sub-query)
create view teams_data as (
	select 
		t.team_short_name,
        t.team_long_name,
		lta.*
    from team t
    inner join (
		select 
		ta.*
		from 
			team_attributes as ta
		inner join (
			select 
				team_api_id,
				max(date) as latest_date 
			from team_attributes
			group by team_api_id
		) as latest_data 
		on ta.team_api_id = latest_data.team_api_id
		and ta.date = latest_data.latest_date
	) as lta 
    on t.team_api_id = lta.team_api_id
);

select * from teams_data;

-- ----------------------------------------------------------------------------------------

# top 10 teams in terms of different attributes (using procedure)
delimiter //

create procedure top10Teams(in attribute varchar(50))
begin
	set @query = concat(
		'select team_long_name, ', attribute,
        ' from teams_data',
        ' order by ', attribute, ' desc',
        ' limit 10;'
    );
    prepare stmt from @query;
    execute stmt;
    deallocate prepare stmt;
end //

delimiter ;

call top10Teams('buildUpPlayPassing');

-- ----------------------------------------------------------------------------------------

# find the average attributes for each league
select 
	m.league_id,
    l.name,
    avg(td.buildUpPlaySpeed) as avg_buildUpPlaySpeed,
    avg(td.buildUpPlayPassing) avg_buildUpPlayPassing,
--     td.buildUpPlayPassingClass,
--     td.buildUpPlayPositioningClass,
    avg(td.chanceCreationCrossing) avg_chanceCreationCrossing,
--     td.chanceCreationCrossingClass,
    avg(td.chanceCreationShooting) as avg_chanceCreationShooting,
--     td.chanceCreationShootingClass,
    avg(td.defenceAggression) as avg_defenceAggression,
--     td.defenceAggressionClass,
    avg(td.defenceTeamWidth) as defenceTeamWidth
--     td.defenceTeamWidthClass,
--     td.defenceDefenderLineClass,
from teams_data td
inner join `match` m
on td.team_api_id = m.home_team_api_id
inner join league l
on m.league_id = l.id
group by m.league_id;

-- ----------------------------------------------------------------------------------------

# find the mode (most frequent nominal value) for each attribute in every league (apply CTE)
with rankedBuildUpplayPassingClass as (
	SELECT 
		m.league_id,
		td.buildUpPlayPassingClass,
		COUNT(td.buildUpPlayPassingClass) AS frequency,
		RANK() OVER (PARTITION BY m.league_id ORDER BY COUNT(td.buildUpPlayPassingClass) DESC) AS ranking
	from teams_data td
	inner join `match` m
	on td.team_api_id = m.home_team_api_id
	inner join league l
	on m.league_id = l.id
	group by m.league_id, td.buildUpPlayPassingClass
)
select league_id, buildUpPlayPassingClass
from rankedBuildUpplayPassingClass
where ranking = 1;
