/* Populate database with sample data. */

INSERT INTO animals (id,name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES (1, 'Agumon', 'Feb, 3, 2020', 0, TRUE, 10.23);
INSERT INTO animals (id,name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES (2, 'Gabumon', 'Nov, 15, 2018', 2, TRUE, 8);
INSERT INTO animals (id,name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES (3, 'Pikachu', 'Jan, 7, 2021', 1, FALSE, 15.04);
INSERT INTO animals (id,name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES (4, 'Devimon', 'May, 12, 2017', 5, TRUE, 11);

INSERT INTO animals VALUES (5, 'Charmander', 'Feb, 8, 2020', 0, FALSE, -11),
(6, 'Plantmon', 'Nov, 15, 2022', 2, TRUE, -5.7),
(7, 'Squirtle', 'Apr, 02, 1993', 3, FALSE, -12.13),
(8, 'Angemon', 'Jun, 12, 2005', 1, TRUE, -45),
(9, 'Boarmon', 'Jun, 7, 2005', 7, TRUE, 20.4),
(10, 'Blossom', 'Oct, 13, 1998', 3, TRUE, 17);

/* Start of transaction 1 */

BEGIN TRANSACTION;

UPDATE animals SET species = 'unspecified';
SAVE TRANSACTION SP1;
SELECT * FROM animals;

ROLLBACK TRANSACTION;

/* End of transaction 1 */
/* check if table went back to the state before transaction.*/

SELECT * FROM animals;

/* Start of transaction 2 */

BEGIN TRANSACTION;

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
SAVE TRANSACTION SP1;
SELECT * FROM animals;

UPDATE animals SET species = 'pokemon' WHERE name NOT LIKE '%mon';
SAVE TRANSACTION SP2;
SELECT * FROM animals;

COMMIT TRANSACTION;

/* End of transaction 2 */
/* Verify all updates after transaction commit */

SELECT * FROM animals; 