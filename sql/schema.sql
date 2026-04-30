-- ============================================================
-- Student Records Database Schema
-- Run this on your Azure MySQL Flexible Server
-- ============================================================

CREATE DATABASE IF NOT EXISTS studentdb CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE studentdb;

CREATE TABLE IF NOT EXISTS students (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100)  NOT NULL,
    roll_no     VARCHAR(20)   NOT NULL UNIQUE,
    class       VARCHAR(50)   NOT NULL,
    city        VARCHAR(100)  NOT NULL,
    created_at  TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Index for faster search by roll number
CREATE INDEX IF NOT EXISTS idx_roll_no ON students(roll_no);

-- Sample data (optional)
INSERT INTO students (name, roll_no, class, city) VALUES
    ('Alice Johnson', 'R001', '10th Grade', 'New York'),
    ('Bob Smith',     'R002', '11th Grade', 'Los Angeles'),
    ('Carol White',   'R003', '10th Grade', 'Chicago');
