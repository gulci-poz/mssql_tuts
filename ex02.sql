DROP DATABASE NFL
CREATE DATABASE NFL

USE NFL;

DROP TABLE Pases;

CREATE TABLE Pases (
    Quarterback NVARCHAR(50),
    Attempts INT,
    Completions INT,
    YARDS INT,
    Touchdowns INT,
    Interceptions INT,
    Year INT,
    Week INT
);

GO

INSERT INTO Pases VALUES ('Peyton Manning', 42, 33, 414, 4, 1, 2013, 5);
INSERT INTO Pases VALUES ('Tony Romo', 25, 36, 506, 5, 1, 2013, 5);

SELECT * FROM Pases;

/* GO (Transact-SQL)
https://msdn.microsoft.com/pl-pl/library/ms188037(v=sql.110).aspx
*/

/*
odświeżenie widoku: Ctrl + Shift + r lub F5
*/
