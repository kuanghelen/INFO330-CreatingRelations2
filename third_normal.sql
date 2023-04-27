/* 

Third Normal Form

The final schema for pokemon.sqlite is made by running files in this order
    1) first_normal.sql
    2) second_normal.sql
    3) third_normal.sql

*/

-- create a table for types
CREATE TABLE Types (
    type_combo_id INTEGER PRIMARY KEY AUTOINCREMENT,
    type1 TEXT NOT NULL, 
    type2 TEXT
);

-- insert type combos into the Types table
INSERT INTO Types (type1, type2)
SELECT DISTINCT P.type1, P.type2
FROM Pokemon AS P;

-- create a table to connect pokemon with their type
CREATE TABLE Pokemon_type (
    pokedex_number INTEGER REFERENCES Pokemon(pokedex_number),
    type_combo_id INTEGER REFERENCES Types(type_combo_id)
);

-- fill Pokemon_type with pokedex_number and matching type_id
INSERT INTO Pokemon_type (pokedex_number, type_combo_id)
SELECT DISTINCT P.pokedex_number, T.type_combo_id
FROM Pokemon AS P, Types AS T
WHERE P.type1 = T.type1
AND P.type2 = T.type2;

-- create a table for effectiveness
CREATE TABLE Effectiveness (
    type_combo_id INTEGER PRIMARY KEY REFERENCES Types(type_combo_id),
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
    against_water REAL
);

-- insert effectiveness data
INSERT INTO Effectiveness (
    against_bug, 
    against_dark, 
    against_dragon, 
    against_electric, 
    against_fairy, 
    against_fight, 
    against_fire, 
    against_flying, 
    against_ghost, 
    against_grass, 
    against_ground, 
    against_ice, 
    against_normal, 
    against_poison, 
    against_psychic, 
    against_rock, 
    against_steel, 
    against_water)
SELECT DISTINCT
    against_bug, 
    against_dark, 
    against_dragon, 
    against_electric, 
    against_fairy, 
    against_fight, 
    against_fire, 
    against_flying, 
    against_ghost, 
    against_grass, 
    against_ground, 
    against_ice, 
    against_normal, 
    against_poison, 
    against_psychic, 
    against_rock, 
    against_steel, 
    against_water
FROM Pokemon; 

-- delete duplicate columns in Pokemon
ALTER TABLE Pokemon DROP COLUMN type1;
ALTER TABLE Pokemon DROP COLUMN type2;
ALTER TABLE Pokemon DROP COLUMN against_bug;
ALTER TABLE Pokemon DROP COLUMN against_dark;
ALTER TABLE Pokemon DROP COLUMN against_dragon;
ALTER TABLE Pokemon DROP COLUMN against_electric;
ALTER TABLE Pokemon DROP COLUMN against_fairy;
ALTER TABLE Pokemon DROP COLUMN against_fight;
ALTER TABLE Pokemon DROP COLUMN against_fire;
ALTER TABLE Pokemon DROP COLUMN against_flying; 
ALTER TABLE Pokemon DROP COLUMN against_ghost;
ALTER TABLE Pokemon DROP COLUMN against_grass;
ALTER TABLE Pokemon DROP COLUMN against_ground;
ALTER TABLE Pokemon DROP COLUMN against_ice;
ALTER TABLE Pokemon DROP COLUMN against_normal;
ALTER TABLE Pokemon DROP COLUMN against_poison;
ALTER TABLE Pokemon DROP COLUMN against_psychic;
ALTER TABLE Pokemon DROP COLUMN against_rock;
ALTER TABLE Pokemon DROP COLUMN against_steel;
ALTER TABLE Pokemon DROP COLUMN against_water;