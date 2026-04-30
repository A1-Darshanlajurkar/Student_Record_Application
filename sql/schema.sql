-- ============================================================
-- Student Records — Azure SQL Database Schema
-- Run once on your Azure SQL server
-- ============================================================

CREATE TABLE Students (
    Id        INT           IDENTITY(1,1) PRIMARY KEY,
    Name      NVARCHAR(100) NOT NULL,
    RollNo    NVARCHAR(20)  NOT NULL,
    Class     NVARCHAR(50)  NOT NULL,
    City      NVARCHAR(100) NOT NULL,
    CreatedAt DATETIME2     NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT UQ_Students_RollNo UNIQUE (RollNo)
);

-- Optional sample data
INSERT INTO Students (Name, RollNo, Class, City) VALUES
    ('Alice Johnson', 'R001', '10th Grade', 'New York'),
    ('Bob Smith',     'R002', '11th Grade', 'Los Angeles'),
    ('Carol White',   'R003', '10th Grade', 'Chicago');
