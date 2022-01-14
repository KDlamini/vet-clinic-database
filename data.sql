--Populate database with sample data.
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Agumon', 'Feb, 3, 2020', 0, TRUE, 10.23),
    ('Gabumon', 'Nov, 15, 2018', 2, TRUE, 8),
    ('Pikachu', 'Jan, 7, 2021', 1, FALSE, 15.04),
    ('Devimon', 'May, 12, 2017', 5, TRUE, 11);
    ('Charmander', 'Feb, 8, 2020', 0, FALSE, -11),
    ('Plantmon', 'Nov, 15, 2022', 2, TRUE, -5.7),
    ('Squirtle', 'Apr, 02, 1993', 3, FALSE, -12.13),
    ('Angemon', 'Jun, 12, 2005', 1, TRUE, -45),
    ('Boarmon', 'Jun, 7, 2005', 7, TRUE, 20.4),
    ('Blossom', 'Oct, 13, 1998', 3, TRUE, 17);

--populate owners table
INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),
	('Jennifer Orwell', 19),
	('Bob', 45),
	('Melody Pond', 77),
	('Dean Winchester', 14),
	('Jodie Whittaker', 38);

--populate species table
INSERT INTO species (name) 
VALUES ('Pokemon'),
    ('Digimon');

--Modify animals table so it includes the species_id value.
UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Digimon')
WHERE name LIKE '%mon';

UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Pokemon')
WHERE species_id IS NULL;

--Modify animals table so it includes the owners_id value
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name = 'Gabumon' OR name = 'Pikachu';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name = 'Devimon' OR name = 'Plantmon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name = 'Angemon'  OR name = 'Boarmon';