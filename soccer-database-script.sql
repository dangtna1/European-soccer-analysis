-- drop database
drop database if exists soccer;

-- create database
create database if not exists soccer;

-- use database
use soccer;
SET FOREIGN_KEY_CHECKS = 0; -- because our data is not full

-- ----------------------------------------------------------------------------------------

-- create tables
create table if not exists country (
	id integer auto_increment,
    name varchar(50) unique,
    primary key(id)
);

create table if not exists league (
	id integer auto_increment,
    name varchar(50) unique,
    country_id integer,
    primary key(id),
    foreign key(country_id) references country(id)
);

create table if not exists `match` (
	id integer auto_increment,
	country_id integer,
	league_id integer,
	season text,
	stage integer,
	date text,
	match_api_id integer unique,
	home_team_api_id integer,
	away_team_api_id integer,
	home_team_goal integer,
	away_team_goal integer,
	home_player_X1 integer,
	home_player_X2 integer,
	home_player_X3 integer,
	home_player_X4 integer,
	home_player_X5 integer,
	home_player_X6 integer,
	home_player_X7 integer,
	home_player_X8 integer,
	home_player_X9 integer,
	home_player_X10 integer,
	home_player_X11 integer,
	away_player_X1 integer,
	away_player_X2 integer,
	away_player_X3 integer,
	away_player_X4 integer,
	away_player_X5 integer,
	away_player_X6 integer,
	away_player_X7 integer,
	away_player_X8 integer,
	away_player_X9 integer,
	away_player_X10 integer,
	away_player_X11 integer,
	home_player_Y1 integer,
	home_player_Y2 integer,
	home_player_Y3 integer,
	home_player_Y4 integer,
	home_player_Y5 integer,
	home_player_Y6 integer,
	home_player_Y7 integer,
	home_player_Y8 integer,
	home_player_Y9 integer,
	home_player_Y10 integer,
	home_player_Y11 integer,
	away_player_Y1 integer,
	away_player_Y2 integer,
	away_player_Y3 integer,
	away_player_Y4 integer,
	away_player_Y5 integer,
	away_player_Y6 integer,
	away_player_Y7 integer,
	away_player_Y8 integer,
	away_player_Y9 integer,
	away_player_Y10 integer,
	away_player_Y11 integer,
	home_player_1 integer,
	home_player_2 integer,
	home_player_3 integer,
	home_player_4 integer,
	home_player_5 integer,
	home_player_6 integer,
	home_player_7 integer,
	home_player_8 integer,
	home_player_9 integer,
	home_player_10 integer,
	home_player_11 integer,
	away_player_1 integer,
	away_player_2 integer,
	away_player_3 integer,
	away_player_4 integer,
	away_player_5 integer,
	away_player_6 integer,
	away_player_7 integer,
	away_player_8 integer,
	away_player_9 integer,
	away_player_10 integer,
	away_player_11 integer,
	goal text,
	shoton text,
	shotoff text,
	foulcommit text,
	card text,
	`cross` text,
	corner text,
	possession text,
	B365H numeric(10,2),
	B365D numeric(10,2),
	B365A numeric(10,2),
	BWH numeric(10,2),
	BWD numeric(10,2),
	BWA numeric(10,2),
	IWH numeric(10,2),
	IWD numeric(10,2),
	IWA numeric(10,2),
	LBH numeric(10,2),
	LBD numeric(10,2),
	LBA numeric(10,2),
	PSH numeric(10,2),
	PSD numeric(10,2),
	PSA numeric(10,2),
	WHH numeric(10,2),
	WHD numeric(10,2),
	WHA numeric(10,2),
	SJH numeric(10,2),
	SJD numeric(10,2),
	SJA numeric(10,2),
	VCH numeric(10,2),
	VCD numeric(10,2),
	VCA numeric(10,2),
	GBH numeric(10,2),
	GBD numeric(10,2),
	GBA numeric(10,2),
	BSH numeric(10,2),
	BS numeric(10,2),
	BSA numeric(10,2),
	primary key(id),
	foreign key(league_id) references league(id)
);

create table if not exists player (
	id integer auto_increment,
	player_api_id integer unique,
	player_name text,
	player_fifa_api_id integer unique,
	birthday text,
	height integer,
	weight integer,
	primary key(id)
);

create table if not exists player_attributes (
	id integer auto_increment,
	player_fifa_api_id integer,
	player_api_id integer,
	date text,
	overall_rating integer,
	potential integer,
	preferred_foot text,
	attacking_work_rate text,
	defensive_work_rate text,
	crossing integer,
	finishing integer,
	heading_accuracy integer,
	short_passing integer,
	volleys integer,
	dribbling integer,
	curve integer,
	free_kick_accuracy integer,
	long_passing integer,
	ball_control integer,
	acceleration integer,
	sprint_speed integer,
	agility integer,
	reactions integer,
	balance integer,
	shot_power integer,
	jumping integer,
	stamina integer,
	strength integer,
	long_shots integer,
	aggression integer,
	interceptions integer,
	positioning integer,
	vision integer,
	penalties integer,
	marking integer,
	standing_tackle integer,
	sliding_tackle integer,
	gk_diving integer,
	gk_handling integer,
	gk_kicking integer,
	gk_positioning integer,
	gk_reflexes integer,
	primary key(id),
	foreign key(player_api_id) references player(player_api_id),
	foreign key(player_fifa_api_id) references player(player_fifa_api_id)
);

create table if not exists team (
	id integer auto_increment,
	team_api_id integer unique,
	team_fifa_api_id integer unique,
	team_long_name text,
	team_short_name text,
	primary key(id)
);

create table if not exists team_attributes (
	id integer auto_increment,
	team_fifa_api_id integer,
	team_api_id integer,
	date text,
	buildUpPlaySpeed integer,
	buildUpPlaySpeedClass text,
	buildUpPlayDribbling integer,
	buildUpPlayDribblingClass text,
	buildUpPlayPassing integer,
	buildUpPlayPassingClass text,
	buildUpPlayPositioningClass text,
	chanceCreationPassing integer,
	chanceCreationPassingClass text,
	chanceCreationCrossing integer,
	chanceCreationCrossingClass text,
	chanceCreationShooting integer,
	chanceCreationShootingClass text,
	chanceCreationPositioningClass text,
	defencePressure integer,
	defencePressureClass text,
	defenceAggression integer,
	defenceAggressionClass text,
	defenceTeamWidth integer,
	defenceTeamWidthClass text,
	defenceDefenderLineClass text,
	primary key(id),
	foreign key(team_api_id) references team(team_api_id),
	foreign key(team_fifa_api_id) references team(team_fifa_api_id)
);

-- update `match` table, add foreign key
alter table `match`
	add constraint fk_away_player_1 foreign key (away_player_1) references player(player_api_id),
    add constraint fk_away_player_10 foreign key (away_player_10) references player(player_api_id),
    add constraint fk_away_player_11 foreign key (away_player_11) references player(player_api_id),
    add constraint fk_away_player_2 foreign key (away_player_2) references player(player_api_id),
    add constraint fk_away_player_3 foreign key (away_player_3) references player(player_api_id),
    add constraint fk_away_player_4 foreign key (away_player_4) references player(player_api_id),
    add constraint fk_away_player_5 foreign key (away_player_5) references player(player_api_id),
    add constraint fk_away_player_6 foreign key (away_player_6) references player(player_api_id),
    add constraint fk_away_player_7 foreign key (away_player_7) references player(player_api_id),
    add constraint fk_away_player_8 foreign key (away_player_8) references player(player_api_id),
    add constraint fk_away_player_9 foreign key (away_player_9) references player(player_api_id),
    add constraint fk_away_team foreign key (away_team_api_id) references team(team_api_id),
    add constraint fk_home_player_1 foreign key (home_player_1) references player(player_api_id),
    add constraint fk_home_player_10 foreign key (home_player_10) references player(player_api_id),
    add constraint fk_home_player_11 foreign key (home_player_11) references player(player_api_id),
    add constraint fk_home_player_2 foreign key (home_player_2) references player(player_api_id),
    add constraint fk_home_player_3 foreign key (home_player_3) references player(player_api_id),
    add constraint fk_home_player_4 foreign key (home_player_4) references player(player_api_id),
    add constraint fk_home_player_5 foreign key (home_player_5) references player(player_api_id),
    add constraint fk_home_player_6 foreign key (home_player_6) references player(player_api_id),
    add constraint fk_home_player_7 foreign key (home_player_7) references player(player_api_id),
    add constraint fk_home_player_8 foreign key (home_player_8) references player(player_api_id),
    add constraint fk_home_player_9 foreign key (home_player_9) references player(player_api_id),
    add constraint fk_home_team foreign key (home_team_api_id) references team(team_api_id);

-- ----------------------------------------------------------------------------------------

-- query tables
select * from country;
select * from league;
select * from `match`;
select * from player;
select * from player_attributes;
select * from team;
select * from team_attributes;

# find out the number of attributes (columns) of `match` table
SELECT COUNT(*) AS attribute_count
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'match';
