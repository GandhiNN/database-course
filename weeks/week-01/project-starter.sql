-- Week 1 Project: Personal Library Database
-- Complete the following tasks to create your personal library system

-- Task 1: Create the database
CREATE DATABASE personal_library;

-- Task 2: Create the tables
-- Authors table
CREATE TABLE authors (
    author_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_year INTEGER,
    nationality VARCHAR(50)
);

-- Genres table
CREATE TABLE genres (
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR(50) NOT NULL UNIQUE
);

-- Books table
-- REFERENCES is a syntax to set foreign keys
CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author_id INTEGER REFERENCES authors (author_id),
    genre_id INTEGER REFERENCES genres (genre_id),
    publication_year INTEGER,
    isbn VARCHAR(13),
    pages INTEGER,
    rating DECIMAL(3, 2) CHECK (rating >= 0 AND rating <= 10)
);

-- Task 3: Insert sample data
-- Insert authors
INSERT INTO authors (first_name, last_name, birth_year, nationality) VALUES
('J.K.', 'Rowling', 1965, 'British'),
('George', 'Orwell', 1903, 'British'),
('Harper', 'Lee', 1926, 'American'),
('F. Scott', 'Fitzgerald', 1896, 'American'),
('Jane', 'Austen', 1775, 'British');

INSERT INTO authors (first_name, last_name, birth_year, nationality)
VALUES
('Maggie', 'O''Farrell', 1972, 'Ireland');


-- Insert genres
INSERT INTO genres (genre_name) VALUES
('Fantasy'),
('Dystopian Fiction'),
('Classic Literature'),
('Romance'),
('Science Fiction');

-- Insert books
INSERT INTO books (
    title,
    author_id,
    genre_id,
    publication_year,
    isbn,
    pages,
    rating
) VALUES
(
    'Harry Potter and the Philosopher''s Stone',
    1, 1, 1997, '9780747532743', 223, 9.2
),
('1984', 2, 2, 1949, '9780451524935', 328, 9.1),
('To Kill a Mockingbird', 3, 3, 1960, '9780061120084', 281, 8.8),
('The Great Gatsby', 4, 3, 1925, '9780743273565', 180, 8.5),
('Pride and Prejudice', 5, 4, 1813, '9780141439518', 432, 8.7);


-- Insert books
INSERT INTO books (
    title,
    author_id,
    genre_id,
    publication_year,
    isbn,
    pages,
    rating
) VALUES
(
    'Harry Potter and the Goblet of Fire',
    1, 1, 2005, '0747550794', 636, 9.4
),
(
    'The Marriage Portrait', 6, 4, 2022, '9788419089540', 448, 8.8
);

-- Task 4: Practice Queries
-- Write queries to answer these questions:

-- 1. List all books with their authors
SELECT
    books.title,
    CONCAT(authors.first_name, ' ', authors.last_name) AS author_name
FROM books
INNER JOIN authors
    ON books.author_id = authors.author_id;

-- 2. Find all books published after 1950
SELECT
    book_id,
    title,
    author_id,
    genre_id,
    publication_year,
    isbn,
    pages,
    rating
FROM books
WHERE publication_year > 1950;

-- 3. Count how many books each author has
WITH temp AS (
    SELECT
        books.title AS booktitle,
        CONCAT(authors.first_name, ' ', authors.last_name) AS author
    FROM books INNER JOIN authors
        ON books.author_id = authors.author_id
)

SELECT
    temp.booktitle,
    temp.author,
    COUNT(temp.author) AS countauthor
FROM temp
GROUP BY temp.booktitle, temp.author;

-- 4. Find the average rating of all books
SELECT AVG(rating) AS avgrating FROM books;

-- 5. List all Fantasy books
SELECT books.title
FROM books
INNER JOIN genres
    ON books.genre_id = genres.genre_id
WHERE genres.genre_name = 'Fantasy';

-- 6. Find the longest book (most pages)
SELECT
    books.title,
    MAX(books.pages) AS maxpage
FROM books
GROUP BY books.title
LIMIT 1;

-- Challenge tasks
-- 7. Find authors who have written more than one book
SELECT
    CONCAT(authors.first_name, ' ', authors.last_name) AS authorname,
    COUNT(books.title) AS bookswritten
FROM authors
INNER JOIN books
    ON authors.author_id = books.author_id
GROUP BY authorname
HAVING COUNT(books.title) > 1;

-- 8. List books with ratings above 9.0, showing title, author name, and rating
SELECT
    books.title,
    books.rating,
    CONCAT(authors.first_name, ' ', authors.last_name) AS authorname
FROM books
INNER JOIN authors
    ON books.author_id = authors.author_id
WHERE books.rating > 9.0;

-- 9. Find the most popular genre (genre with most books)
SELECT
    genres.genre_name,
    COUNT(genres.genre_name) AS countgenre
FROM books
INNER JOIN genres
    ON books.genre_id = genres.genre_id
GROUP BY genres.genre_name
ORDER BY countgenre DESC;

-- 10. Create a query to show books published in each decade   
