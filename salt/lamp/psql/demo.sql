CREATE DATABASE demo;

\c demo

CREATE TABLE items (
	item_id SERIAL PRIMARY KEY,
	item VARCHAR(255) NOT NULL
	);

INSERT INTO items (item)
VALUES ('Item1'),('Item2'),('Item3'),('Item4');

ALTER USER postgres PASSWORD 'password';
