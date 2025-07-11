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

-- Task 4: Practice Queries
-- Write queries to answer these questions:

-- 1. List all books with their authors

-- 2. Find all books published after 1950

-- 3. Count how many books each author has

-- 4. Find the average rating of all books

-- 5. List all Fantasy books

-- 6. Find the longest book (most pages)

-- Challenge tasks
-- 7. Find authors who have written more than one book

-- 8. List books with ratings above 9.0, showing title, author name, and rating

-- 9. Find the most popular genre (genre with most books)

-- 10. Create a query to show books published in each decade
