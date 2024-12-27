USE soccer;

INSERT INTO country(id, name)
VALUES
	(1, 'Belgium'),
    (1729, 'England'),
    (4769, 'France'),
    (7809, 'Germany'),
    (10257, 'Italy'),
    (13274, 'Netherlands'),
    (15722, 'Poland'),
    (17642, 'Portugal'),
    (19694, 'Scotland'),
    (21518, 'Spain'),
    (24558, 'Switzerland');
    
INSERT INTO league(id, country_id, name)
VALUES
	(1, 1, 'Belgium Jupiler League'),
    (1729, 1729, 'England Premier League'),
    (4769, 4769, 'France Ligue 1'),
    (7809, 7809, 'Germany 1. Bundesliga'),
    (10257, 10257, 'Italy Serie A'),
    (13274, 13274, 'Netherlands Eredivisie'),
    (15722, 15722, 'Poland Ekstraklasa'),
    (17642, 17642, 'Portugal Liga ZON Sagres'),
    (19694, 19694, 'Scotland Premier League'),
    (21518, 21518, 'Spain LIGA BBVA'),
    (24558, 24558, 'Switzerland Super League');