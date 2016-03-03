DROP DATABASE NFL
CREATE DATABASE NFL

USE NFL;

DROP TABLE Passes;

CREATE TABLE Passes (
    Quarterback NVARCHAR(50),
    YardsGained INT,
    Quarter INT,
    WasTouchdown BIT,
    WasInterception BIT,
    WasComplete BIT,
    Year INT,
    Week INT
);

GO

INSERT INTO Passes VALUES ('Peyton Manning', 23, 1, 0, 0, 1, 2013, 5);
INSERT INTO Passes VALUES ('Peyton Manning', 23, 1, 0, 0, 1, 2013, 5);
INSERT INTO Passes VALUES ('Peyton Manning', 12, 1, 0, 0, 1, 2013, 5);
INSERT INTO Passes VALUES ('Peyton Manning', 0, 1, 0, 0, 0, 2013, 5);
INSERT INTO Passes VALUES ('Peyton Manning', 15, 1, 1, 0, 1, 2013, 5);

SELECT * FROM Passes;

SELECT SUM(YardsGained) As TotalYards
FROM Passes
WHERE Quarterback = 'Peyton Manning';

INSERT INTO Passes VALUES ('Peyton Manning', 28, 1, 1, 0, 1, 2013, 6);

SELECT SUM(YardsGained) As TotalYards
FROM Passes
WHERE Quarterback = 'Peyton Manning' AND Year = 2013 AND Week = 5;

/* za pomocą nawiasów możemy zmienić kolejność operacji */

SELECT COUNT(WasTouchdown) As Touchdowns
FROM Passes
WHERE Quarterback = 'Peyton Manning' AND WasTouchdown = 1 AND (Year = 2013 AND Week = 5);

INSERT INTO Passes VALUES ('Peyton Manning', 25, 1, 1, 0, 1, 2013, 5);
INSERT INTO Passes VALUES ('Peyton Manning', 9, 1, 1, 0, 1, 2013, 5);

SELECT COUNT(WasTouchdown) As Touchdowns
FROM Passes
WHERE Quarterback = 'Peyton Manning' AND WasTouchdown = 1 AND (Year = 2013 AND Week = 5);

/* staramy się nie przechowywać kalkulowanych danych */
/* możemy przechowywać bardziej atomowe dane i zrobić przeliczenie */
