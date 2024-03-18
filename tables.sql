PRAGMA foreign_key = ON;

CREATE TABLE parks
(
	park_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    dimension REAL NOT NULL,
    latitude REAL NOT NULL,
	longitude REAL NOT NULL,
    opening_time TEXT NOT NULL,
    closing_time TEXT NOT NULL,
  
	PRIMARY KEY (park_id)
);

CREATE TABLE informations
(
	park_id INTEGER NOT NULL UNIQUE,
    pet_friendly TEXT CHECK (0 OR 1),
    child_friendly TEXT CHECK (0 OR 1),
    drinkable_water TEXT CHECK (0 OR 1),
    bike TEXT CHECK (0 OR 1),
    car_parking TEXT CHECK (0 OR 1),
    wheelchair_accessible TEXT CHECK (0 OR 1),
    wheelchair_accessible_car_parking TEXT CHECK (0 OR 1),
    public_toilet TEXT CHECK (0 OR 1),
    picnic_table TEXT CHECK (0 OR 1),
    
    PRIMARY KEY (park_id),
    FOREIGN KEY (park_id) REFERENCES parks(park_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE staff
(
	codice_fiscale TEXT NOT NULL,
    name TEXT NOT NULL,
    surname TEXT NOT NULL,
    job TEXT NOT NULL,
    works_at INTEGER NOT NULL,
    
    PRIMARY KEY (codice_fiscale),
    FOREIGN KEY (works_at) REFERENCES parks(park_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE reviews
(
	review_id INTEGER NOT NULL,
	author TEXT NOT NULL DEFAULT 'Anonimo',
	description TEXT,
	mark INTEGER NOT NULL,
    created_at NUMERIC NOT NULL,
    park_id INTEGER NOT NULL,

    CHECK (mark BETWEEN 1 AND 5),
    CHECK (CURRENT_TIMESTAMP > created_at),
	
	PRIMARY KEY(review_id),
    FOREIGN KEY (park_id) REFERENCES parks(park_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE addresses
(
	park_id INTEGER NOT NULL,
	street TEXT NOT NULL,
	number TEXT,
	cap INTEGER,
	city TEXT NOT NULL,
	province TEXT NOT NULL,

    CHECK (cap BETWEEN 10000 AND 99999),

    PRIMARY KEY (park_id),
    FOREIGN KEY (park_id) REFERENCES parks(park_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE images
(
	image_id INTEGER NOT NULL,
    image BLOB NOT NULL,
    park_id INTEGER NOT NULL,

    PRIMARY KEY (park_id),
    FOREIGN KEY (park_id) REFERENCES parks(park_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE crowded
(
	day TEXT NOT NULL,
    morning TEXT NOT NULL,
    afternoon TEXT NOT NULL,
    evening TEXT NOT NULL,
    park_id INTEGER NOT NULL,
    
    CHECK (day = 'monday' OR day = 'tuesday' OR day = 'wednesday' OR day = 'thursday' OR day = 'friday' OR day = 'saturday' OR day = 'sunday')
    CHECK (morning = 'uncrowded' OR morning = 'crowded' OR morning = 'very crowded')
    CHECK (afternoon = 'uncrowded' OR afternoon = 'crowded' OR afternoon = 'very crowded')
    CHECK (evening = 'uncrowded' OR evening = 'crowded' OR evening = 'very crowded')

    PRIMARY KEY (day, park_id),
    FOREIGN KEY (park_id) REFERENCES parks(park_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);



