-- create a table
USE MyDatabase;

DROP TABLE persons;


-- create a new table called persons with columns id, person_name, birth_date and phone
CREATE TABLE persons(
	id INT NOT NULL,
	person_name VARCHAR(50) NOT NULL,
	birth_date VARCHAR(50),
	phone VARCHAR(15) NOT NULL, 
    CONSTRAINT pk_persons PRIMARY KEY(id)
);


SELECT *
FROM persons;

SHOW CREATE TABLE persons; #gives me the create statement of a certain table

-- Add another column called email to the persons table
ALTER TABLE persons
ADD email VARCHAR(50) NOT NULL;


-- With modify column, I can change the column type for instance 
ALTER TABLE persons
MODIFY COLUMN email VARCHAR(50);

ALTER TABLE persons
MODIFY COLUMN email VARCHAR(50) NOT NULL;

-- Remove the phone column from table persons

ALTER TABLE persons
DROP phone;

-- Remove table persons from the db

DROP TABLE persons;







