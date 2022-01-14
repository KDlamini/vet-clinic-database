/*Queries that provide answers to the questions from all projects.*/

--Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name LIKE '%mon%';

--List the name of all animals born between 2016 and 2019.
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';

--List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT * FROM animals WHERE neutered = TRUE AND escape_attempts < 3;

--List date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

--List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

--Find all animals that are neutered.
SELECT * FROM animals WHERE neutered = TRUE;

--Find all animals not named Gabumon.
SELECT * FROM animals WHERE name NOT LIKE '%Gabumon%';

--Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* TRANSACTIONS */

--Start of transaction 1
BEGIN TRANSACTION;

UPDATE animals SET species = 'unspecified';
SAVE TRANSACTION SP1;
SELECT * FROM animals;

ROLLBACK TRANSACTION;
--End of transaction 1
--check if table went back to the state before transaction.
SELECT * FROM animals;

--Start of transaction 2
BEGIN TRANSACTION;

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
SAVE TRANSACTION SP1;
SELECT * FROM animals;

UPDATE animals SET species = 'pokemon' WHERE name NOT LIKE '%mon';
SAVE TRANSACTION SP2;
SELECT * FROM animals;

COMMIT TRANSACTION;
--End of transaction 2
--Verify all updates after transaction commit
SELECT * FROM animals;

--Start of transaction 3
BEGIN TRANSACTION;

DELETE FROM animals;
SAVE TRANSACTION SP1;
SELECT * FROM animals;

ROLLBACK TRANSACTION;
--End of transaction 3 
--check if table went back to the state before transaction.
SELECT * FROM animals;

--Start of transaction 4
BEGIN TRANSACTION;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVE TRANSACTION SP1;
SELECT * FROM animals;

UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TRANSACTION SP1;
SELECT * FROM animals;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
SELECT * FROM animals;

COMMIT TRANSACTION;
--End of transaction 4
--Verify all updates after transaction commit
SELECT * FROM animals;


/* AGGREGATES QUERIES. */

SELECT COUNT(*) FROM animals;
SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT MAX(escape_attempts) FROM animals;

SELECT species, MIN(weight_kg), MAX(weight_kg)
FROM animals 
GROUP BY species;

SELECT species, AVG(escape_attempts)
FROM animals
WHERE date_of_birth BETWEEN 'Jan, 1, 1990' AND 'Dec, 31, 2000'
GROUP BY species;

/* JOIN QUERIES. */

-- Animals that belong to Melody Pond?
SELECT * FROM animals
LEFT JOIN owners
ON animals.owner_id = owners.id
WHERE full_name = 'Melody Pond';

-- List of all animals that are pokemon
SELECT * FROM animals
LEFT JOIN species
ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- List of all owners and their animals, including those that don't own any animal.
SELECT full_name AS owner_name, name AS animal_name
FROM owners
LEFT JOIN animals
ON owners.id = animals.owner_id;

-- Animal count per species
SELECT species.name, COUNT(*) FROM animals
LEFT JOIN species
ON animals.species_id = species.id
GROUP BY species.name;

-- List of all Digimon owned by Jennifer Orwell
SELECT * FROM animals
LEFT JOIN owners
ON animals.owner_id = owners.id
LEFT JOIN species
ON animals.species_id = species.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

-- List of all animals owned by Dean Winchester that haven't tried to escape.
SELECT * FROM animals
LEFT JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempt = 0;

-- Owner who owns the most animal
SELECT owners.full_name, COUNT(owners.full_name)
FROM animals
LEFT JOIN owners
ON animals.owner_id = owners.id
GROUP BY owners.full_name
ORDER BY COUNT(owners.full_name) DESC;