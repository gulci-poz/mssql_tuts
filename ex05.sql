/*
I forma normalna:

- klucz główny
klucz naturalny - potrzebujemy wartości unikalnej; czy dane z którejś kolumny zapewniają tę unikalność? jeśli nie, to potrzebujemy surogatu - sztucznego pola, np. jakiegoś id
Insert Column, Set Primary Key - w oknie Design
dodanie kolumny, domyślnie jest zablokowane zapisywanie zmian, które wymagają ponownego utworzenia tabeli, można odblokować: Tools -> Options -> Designers -> Prevent saving changes that require table re-creation
musimy usunąć dane z tabeli, bo nie damy rady wstawić NULL w pole Id, które nie może być NULL
dajemy ctrl + s
dla kolumny klucza głównego w Identity Specification zmieniamy Is Identity na Yes (Identities to wartości, które automatycznie się inkrementują); Increment i Seed przeważnie 1; nie trzeba w INSERT podawać Id

- w jednej kolumnie nie przechowujemy wielu wartości, np. z użyciem przecinka; nie mogą to być kolekcje danych, posiadające swoją strukturę

- obiekty w tabeli nie powtarzają się

musimy mieć bażę w I formie normalnej, żeby przejść do drugiej formy normalnej
*/

DELETE FROM Passes;

SELECT * FROM Passes
WHERE Id = 7;

UPDATE Passes
SET Quarterback = 'Doug Manning'
WHERE Quarterback = 'Peyton Manning';

/*
II forma normalna

- wyodrębniamy powtarzające się dane do osobnej tabeli, do której będziemy referowali
*/

CREATE TABLE Players (
    Id INT IDENTITY
    , FirstName NVARCHAR(100)
    , LastName NVARCHAR(100)
    , PRIMARY KEY(Id)
);

INSERT INTO Players VALUES ('Peyton', 'Manning');

ALTER TABLE Passes DROP COLUMN Quarterback;
ALTER TABLE Passes ADD PlayerId INT;

UPDATE Passes
SET PlayerId = 1;

/*
użycie funkcji agregującej COUNT pociąga użycie GROUP BY
*/

SELECT pl.FirstName + pl.LastName AS PlayerName
    , COUNT(WasTouchdown) AS Touchdowns
FROM Passes AS p
INNER JOIN Players AS pl
ON p.PlayerId = pl.Id
WHERE WasTouchdown = 1
GROUP BY pl.FirstName + pl.LastName;

/*
III forma normalna

- usuwamy zależności przechodnie, robimy dekompozycję (nowa tabela) i asocjację (pole odwołujące się do nowej tabeli)

u nas Week zależy nie tylko od Id, ale również od roku, w każdym roku może wystąpić piąty tydzień
*/

/*
DECLARE @count INT
SET @count = 1
WHILE (@count <= 1000000)
BEGIN
    INSERT INTO Passed VALUES (15, 1, 0, 0, 1, 2013, 7, 1);
    SET @count = @count + 1
END
*/

/* [] dajemy w wypadku występowania znaków specjalnych w nazwie kolumny, na wszelki wypadek wszędzie możemy używać [] */

/* klucz główny może być parą */

CREATE TABLE Schedules (
    [Id] INT IDENTITY
    , [Year] INT
    , [Week] INT
    , PRIMARY KEY(Id)
);

INSERT INTO Schedules VALUES (2013, 5);
INSERT INTO Schedules VALUES (2013, 6);
INSERT INTO Schedules VALUES (2013, 7);

/* na początku dopuszczamy NULL; musimy też pamiętać o zachowaniu danych o roku i tygodniu, żeby dobrać odpowiedni Id z nowej tabeli */
ALTER TABLE Passes ADD ScheduleId INT;

/* na razie robimy to w bardzo prosty sposób, bez uwzględnienia danych z nowej tabeli */
UPDATE Passes
SET ScheduleId = 1
WHERE Id != 6;

UPDATE Passes
SET ScheduleId = 2
WHERE Id = 6;

ALTER TABLE Passes DROP COLUMN [Year];
ALTER TABLE Passes DROP COLUMN [Week];

/*
relacje - ustanawiamy za pomocą kluczy obcych
integralność danych - nie wstawimy wartości, które nie istnieją
kandydat na klucz obcy - musi być kluczem głównym lub zawierać unikalną wartość
 */

/* ralacja one to many; jedna pozycja, np. QB może być pozycją wielu graczy */

CREATE TABLE Positions (
    Id INT IDENTITY
    , Name NVARCHAR(100) NOT NULL
    , Abbreviation NVARCHAR(3) NOT NULL
    , PRIMARY KEY(Id)
);

INSERT INTO Positions VALUES ('Quarterback', 'QB');
INSERT INTO Positions VALUES ('Running back', 'RB');
INSERT INTO Positions VALUES ('Wide Receiver', 'WR');

ALTER TABLE Players ADD PositionId INT;

ALTER TABLE Players
ADD CONSTRAINT FK_Players_Positions
FOREIGN KEY (PositionId)
REFERENCES Positions(Id);

UPDATE Players
SET PositionId = 1;

/* relacja many to many; pozycja może być pozycją wielu graczy oraz gracz może mieć więcej niż jedną pozycję */
/* tworzymy junction table z kluczami dla relacji; każdy rekord będzie zawierał klucz gracza i klucz pozycji */

ALTER TABLE Players DROP CONSTRAINT FK_Players_Positions;
ALTER TABLE Players DROP COLUMN PositionId;

/* zaznaczenie pól z shift w widoku Design */

CREATE TABLE PlayersPositions (
    PlayerId INT
    , PositionId INT
    , PRIMARY KEY (PlayerId, PositionId)
);

INSERT INTO Players VALUES ('Wiki', 'McGul');
INSERT INTO Players VALUES ('Mela', 'McGul');

INSERT INTO PlayersPositions VALUES (1, 1);
INSERT INTO PlayersPositions VALUES (1, 2);
INSERT INTO PlayersPositions VALUES (2, 2);
INSERT INTO PlayersPositions VALUES (2, 3);
INSERT INTO PlayersPositions VALUES (3, 1);
INSERT INTO PlayersPositions VALUES (3, 3);

ALTER TABLE PlayersPositions
ADD CONSTRAINT FK_PlayersPositions_Players
FOREIGN KEY (PlayerId)
REFERENCES Players(Id);

ALTER TABLE PlayersPositions
ADD CONSTRAINT FL_PlayersPositions_Positions
FOREIGN KEY (PositionId)
REFERENCES Positions(Id);
