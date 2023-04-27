/* 

Second Normal Form

The final schema for pokemon.sqlite is made by running files in this order
    1) first_normal.sql
    2) second_normal.sql
    3) third_normal.sql

*/

-- create a table for abilities
CREATE TABLE Abilities (
    ability_id INTEGER PRIMARY KEY AUTOINCREMENT,
    ability TEXT
);

-- fill in Abilities table with distinct abilities
INSERT INTO Abilities (ability)
SELECT DISTINCT ability
FROM Abilities_temp;

-- create a table to connect pokemon with their abilities
CREATE TABLE Pokemon_ability (
    pokedex_number INTEGER REFERENCES Pokemon(pokedex_number),
    ability_id INTEGER REFERENCES Abilities
);

-- fill in Pokemon_ability with pokedex_number and ability_id
INSERT INTO Pokemon_ability (pokedex_number, ability_id)
SELECT T.pokedex_number, A.ability_id
FROM Abilities_temp AS T, Abilities AS A
WHERE T.ability = A.ability;

-- drop irrelevant table
DROP TABLE Abilities_temp;
DROP TABLE Pokemon_1nf;


/*

Table for 2NF:
- Pokemon
- Abilities
- Pokemon_Abilities

Temporary table that will be dropped later
- Pokemon
- Abilities_temp

*/