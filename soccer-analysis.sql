use soccer;

-- ----------------------------------------------------------------------------------------

-- Query attributes of a specific player
select *
from player_attributes
where player_api_id = 505942;

-- ----------------------------------------------------------------------------------------

-- Inspect how many records and unique players
select count(*) as all_records, count(distinct(player_api_id)) as unique_players
from player_attributes;

select * from player;
select * from player_attributes order by player_api_id;

-- ----------------------------------------------------------------------------------------

-- Inspect attributes of individual player by the latest date (using sub-query)
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

call top10Players('overall_rating');

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

