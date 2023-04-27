/* 

First Normal Form

The final schema for pokemon.sqlite is made by running files in this particular order:
    1) first_normal.sql
    2) second_normal.sql
    3) third_normal.sql

*/


-- import data
.mode csv
.import pokemon.csv imported_pokemon_data

-- check foreign key constraints
PRAGMA foreign_keys=ON;

-- correct the capture rate of Minior
UPDATE imported_pokemon_data SET capture_rate = 285 WHERE pokedex_number = 774;

/* create a pokemon table with more accurate data types
   NOTE: abilities are excluded, the primary key is pokedex_number (moved to the top)
*/
CREATE TABLE Pokemon (
    pokedex_number INTEGER PRIMARY KEY,
    against_bug REAL, 
    against_dark REAL, 
    against_dragon REAL, 
    against_electric REAL, 
    against_fairy REAL, 
    against_fight REAL, 
    against_fire REAL, 
    against_flying REAL, 
    against_ghost REAL, 
    against_grass REAL, 
    against_ground REAL, 
    against_ice REAL, 
    against_normal REAL, 
    against_poison REAL, 
    against_psychic REAL, 
    against_rock REAL, 
    against_steel REAL, 
    against_water REAL, 
    attack INTEGER, 
    base_egg_steps INTEGER, 
    base_happiness INTEGER, 
    base_total INTEGER, 
    capture_rate INTEGER, 
    classfication TEXT, 
    defense INTEGER, 
    experience_growth INTEGER, 
    height_m REAL, 
    hp INTEGER, 
    name TEXT, 
    percentage_male REAL,
    sp_attack INTEGER, 
    sp_defense INTEGER, 
    speed INTEGER, 
    type1 TEXT, 
    type2 TEXT, 
    weight_kg REAL, 
    generation INTEGER, 
    is_legendary INTEGER
);

-- fill in Pokemon data (still no abilities data)
INSERT INTO Pokemon
SELECT pokedex_number, against_bug, against_dark, against_dragon, 
    against_electric, against_fairy, against_fight, against_fire, 
    against_flying, against_ghost, against_grass, against_ground, 
    against_ice, against_normal, against_poison, against_psychic, 
    against_rock, against_steel, against_water, attack, 
    base_egg_steps, base_happiness, base_total, capture_rate, 
    classfication, defense, experience_growth, height_m, 
    hp, name, percentage_male, sp_attack, sp_defense, speed, type1, 
    type2, weight_kg, generation, is_legendary
FROM imported_pokemon_data;

-- split abilities into separate tuples, insert them into a temporary table
CREATE TABLE Abilities_temp AS
SELECT pokedex_number, trim(value, '''[] ') AS ability
FROM imported_pokemon_data, json_each('["' || replace(abilities, ',', '","') || '"]')
WHERE ability <> '';

-- Create a new table from the join of each Pokemon and their abilities
CREATE TABLE Pokemon_1nf AS
SELECT A.ability, P.*
FROM Pokemon AS P, Abilities_temp AS A 
WHERE P.pokedex_number = A.pokedex_number;

-- drop irrelevant table
DROP TABLE imported_pokemon_data;


/*

Table for 1NF:
- Pokemon_1nf

Temporary table that will be used/dropped later
- Pokemon
- Abilities_temp

*/
