-- Postgres Version
SELECT version();

-- TEST
SELECT current_date;

-- Create Branch table
CREATE TABLE Branch (
    BranchID SERIAL PRIMARY KEY,
    BranchName VARCHAR(100) NOT NULL,
    BranchLocation VARCHAR(100)
);

-- Create Customer table
CREATE TABLE Customer (
    CustomerID SERIAL PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    BranchID INT REFERENCES Branch(BranchID) ON DELETE CASCADE
);

-- Insert records into Branch table
INSERT INTO Branch (BranchName, BranchLocation)
VALUES 
    ('Central Branch', 'Downtown'),
    ('North Branch', 'Uptown'),
    ('East Branch', 'Suburban Area');

-- Insert records into Customer table
INSERT INTO Customer (CustomerName, Email, BranchID)
VALUES 
    ('John Doe', 'john.doe@example.com', 1),
    ('Jane Smith', 'jane.smith@example.com', 1),
    ('Alice Brown', 'alice.brown@example.com', 2),
    ('Bob Johnson', 'bob.johnson@example.com', 3);

-- SELECT
SELECT customerid, customername, email, c.branchid FROM public.customer c join public.branch b on c.branchid=b.branchid;