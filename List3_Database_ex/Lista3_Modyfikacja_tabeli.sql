-- Zadanie 7

-- Musimy dodaæ dwie dodatkowe kolumny do tabeli Pracownik pod nazw¹ DataUtworzenia oraz DataModyfikacji ( to jest zrobione w Alter Table ) 
-- Gdy utworzymy nowego pracownika zostanie wype³nione pole DataUtworzenia aktualn¹ dat¹ 
-- Gdy bêdzie aktualizowaæ dane tego pracownika ( dane osobowe czyli imiê i nazwisko albo adres zamieszkania czyli Miejscowoœæ Ulica ) to wpisze do DataModyfikacji aktualn¹ datê


ALTER TABLE Pracownik -- dziêki temu dodamy dwie dodatkowe kolumny
ADD 
    DataUtworzenia DATETIME DEFAULT GETDATE(),
    DataModyfikacji DATETIME NULL;



DROP PROCEDURE IF EXISTS InsertNowegoPracownika;
GO

CREATE PROCEDURE InsertNowegoPracownika
    @Imie NVARCHAR(50),
    @Nazwisko NVARCHAR(50),
    @Ulica NVARCHAR(50),
	@Miejscowosc NVARCHAR(50),
	@KodPocztowy CHAR(10),
    @KrajKod CHAR(2),
    @Typ CHAR(1)
AS
BEGIN

	DECLARE @AdresId INT;

    BEGIN TRANSACTION;

    INSERT INTO Adres (Ulica, Miejscowosc, KodPocztowy, KrajKod, Typ)
    VALUES (@Ulica, @Miejscowosc, @KodPocztowy, @KrajKod, @Typ);

    SET @AdresId = SCOPE_IDENTITY();

    INSERT INTO Pracownik (Imie, Nazwisko, AdresId)
    VALUES (@Imie, @Nazwisko, @AdresId);

    COMMIT TRANSACTION;
END;
GO
	
EXEC InsertNowegoPracownika
    @Imie = 'Jarek',
    @Nazwisko = 'M¹ciwoda',
    @Ulica = 'Malinowa',
    @Miejscowosc = 'Kraków',
	@KodPocztowy = '5140-103',
	@KrajKod = 'GE',
	@Typ = 'G'

SELECT * FROM Pracownik

DROP PROCEDURE IF EXISTS UpdateDanePracownika;
GO

CREATE PROCEDURE UpdateDanePracownika
	@PracownikId INT,
    @NoweImie NVARCHAR(50),
    @NoweNazwisko NVARCHAR(50)
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Pracownik
        WHERE Id = @PracownikId
          AND (Imie <> @NoweImie OR Nazwisko <> @NoweNazwisko)
    )
    BEGIN
        UPDATE Pracownik
        SET 
            Imie = @NoweImie,
            Nazwisko = @NoweNazwisko,
            DataModyfikacji= GETDATE()
        WHERE Id = @PracownikId;
    END
END;
GO

EXEC UpdateDanePracownika
    @PracownikId = 74,
    @NoweImie = 'Janina',
    @NoweNazwisko = 'Czajka'
 

SELECT * FROM Pracownik

/* TRIGGER */

ALTER TABLE Pracownik
ADD DataUtworzenia DATETIME NULL, DataModyfikacji DATETIME NULL;

CREATE TRIGGER Employee_Insert
ON Pracownik
AFTER INSERT
AS
BEGIN
UPDATE Pracownik
SET DataUtworzenia = GETDATE()
FROM Pracownik
JOIN inserted ON Pracownik.Id = inserted.Id;
END;

CREATE TRIGGER Employee_Update
ON Pracownik
AFTER UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN deleted d ON i.Id = d.Id
        WHERE i.Imie <> d.Imie OR i.Nazwisko <> d.Nazwisko
    )
    BEGIN
        UPDATE Pracownik
        SET DataModyfikacji = GETDATE()
        FROM Pracownik
        JOIN inserted ON Pracownik.Id = inserted.Id;
    END
END;

SELECT * From Pracownik

INSERT INTO Pracownik( Imie, Nazwisko, AdresId, DzialKod, OddzialId)
VALUES ( 'Jakub', 'Kowalski', 701 , 'RD1' , 31);

UPDATE Pracownik
SET Imie = 'Ma³gosia'
WHERE Id = 81;







