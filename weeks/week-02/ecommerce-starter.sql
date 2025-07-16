-- Week 2 Project: E-commerce Product Catalog
-- Build a comprehensive product catalog system

-- Task 1: Create the database structure
CREATE DATABASE ecommerce_catalog;

-- Categories table
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    parent_category_id INTEGER REFERENCES categories (category_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);
