use library;
select * from books;
select * from issuereturn;
select * from users;

-- List All Available Books
SELECT * FROM Books WHERE Status = 'Available';

-- Average, Min, Max Price per Category
SELECT Category, 
       AVG(Price) AS AvgPrice, 
       MIN(Price) AS MinPrice, 
       MAX(Price) AS MaxPrice
FROM Books
GROUP BY Category;

-- List Books Issued by a Particular User
SELECT U.Name, B.Title, IR.IssueDate, IR.DueDate
FROM IssueReturn IR
JOIN Users U ON IR.UserID = U.UserID
JOIN Books B ON IR.BookID = B.BookID
WHERE U.Name = 'ravi kumar';

-- Number of Books Issued in Last 30 Days
SELECT COUNT(*) AS TotalIssued
FROM IssueReturn
WHERE IssueDate >= CURDATE() - INTERVAL 30 DAY;

-- Update Book Status on Issue/Return
UPDATE Books SET Status = 'Issued' WHERE BookID = 4;

-- Find Most Expensive Book per Category
SELECT Category, Title, Price
FROM Books B
WHERE Price = (
    SELECT MAX(Price)
    FROM Books
    WHERE Category = B.Category
);

--  Optional View (All Issued Books Summary)
CREATE VIEW IssuedBooksSummary AS
SELECT B.Title, U.Name AS IssuedTo, IR.IssueDate, IR.DueDate
FROM IssueReturn IR
JOIN Books B ON IR.BookID = B.BookID
JOIN Users U ON IR.UserID = U.UserID
WHERE B.Status = 'Issued';